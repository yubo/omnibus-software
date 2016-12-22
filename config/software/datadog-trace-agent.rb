name "datadog-trace-agent"
default_version "master"

env = {
  "GOPATH" => "#{Omnibus::Config.cache_dir}/src/#{name}"
}

if ohai['platform_family'] == 'mac_os_x'
  gobin = "/usr/local/bin/go"
elsif ohai['platform'] == 'windows'
  gobin = 'C:/Go/bin/go'
else
  env['GOROOT'] = "/usr/local/go"
  gobin = "/usr/local/go/bin/go"
end

def go_build(program, opts={})
  default_cmd = "go build -a"
  if ENV["INCREMENTAL_BUILD"] then
    default_cmd = "go build -i"
  end
  opts = {
    :cmd => default_cmd
  }.merge(opts)

  dd = 'main'
  commit = `git rev-parse --short HEAD`.strip
  branch = `git rev-parse --abbrev-ref HEAD`.strip
  date = `date`.strip
  goversion = `go version`.strip
  agentversion = ENV["TRACE_AGENT_VERSION"] || "0.99.0"

  ldflags = {
    "#{dd}.BuildDate" => "#{date}",
    "#{dd}.GitCommit" => "#{commit}",
    "#{dd}.GitBranch" => "#{branch}",
    "#{dd}.GoVersion" => "#{goversion}",
    "#{dd}.Version" => "#{agentversion}",
  }.map do |k,v|
    if goversion.include?("1.4")
      "-X #{k} '#{v}'"
    else
      "-X '#{k}=#{v}'"
    end
  end.join ' '

  cmd = opts[:cmd]
  sh "#{cmd} -ldflags \"#{ldflags}\" #{program}"
end

build do
   ship_license "https://raw.githubusercontent.com/DataDog/datadog-trace-agent/#{version}/LICENSE"
   ship_license "https://raw.githubusercontent.com/DataDog/datadog-trace-agent/#{version}/THIRD_PARTY_LICENSES.md"
   # Download datadog-trace-agent without installing
   command "git clone https://github.com/DataDog/datadog-trace-agent.git $GOPATH/src/github.com/DataDog/datadog-trace-agent", :env => env
   # Checkout datadog-trace-agent's build dependencies
   command "#{gobin} get -d github.com/robfig/glock", :env => env

   # Pin build deps to known versions
   command "git checkout 7bc8ce51048e2adc11733f90a87b1c02fb7feebe", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/datadog-trace-agent/src/github.com/robfig/glock"
   command "rake restore", :env => env

   # Checkout and build datadog-trace-agent
   command "git checkout #{version} && git pull", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/datadog-trace-agent/src/github.com/DataDog/datadog-trace-agent"
   command "go build -i -o trace-agent github.com/DataDog/datadog-trace-agent/agent && mv ./trace-agent #{install_dir}/bin/trace-agent", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/datadog-trace-agent/src/github.com/DataDog/datadog-trace-agent"
end
