name "datadog-trace-agent"
default_version "master"

env = {
  "GOPATH" => "#{Omnibus::Config.cache_dir}/src/#{name}",
  "GOROOT" => "/usr/local/go17/go"
}

gourl = "https://storage.googleapis.com/golang/go1.7.1.linux-amd64.tar.gz"
goout = "go.tar.gz"
godir = "/usr/local/go17"
gobin = "#{godir}/go/bin/go"

build do
   ship_license "https://raw.githubusercontent.com/DataDog/datadog-trace-agent/#{version}/LICENSE"
   # download go1.7
   command "curl #{gourl} -o #{goout}"
   command "mkdir -p #{godir}"
   command "tar zxfv #{goout} -C #{godir}"

   # Download datadog-trace-agent without installing
   command "git clone https://github.com/DataDog/datadog-trace-agent.git $GOPATH/src/github.com/DataDog/datadog-trace-agent", :env => env
   # Checkout datadog-trace-agent's build dependencies
   command "#{gobin} get -d github.com/robfig/glock", :env => env

   # Pin build deps to known versions
   command "git checkout 7bc8ce51048e2adc11733f90a87b1c02fb7feebe", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/datadog-trace-agent/src/github.com/robfig/glock"

   # Checkout and build datadog-trace-agent
   command "rake restore", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/datadog-trace-agent/src/github.com/DataDog/datadog-trace-agent"
   command "git checkout master && git pull", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/datadog-trace-agent/src/github.com/DataDog/datadog-trace-agent"
   command "#{gobin} build -i -o trace-agent github.com/DataDog/datadog-trace-agent/agent && mv ./trace-agent #{install_dir}/bin/trace-agent", :env => env, :cwd => "#{Omnibus::Config.cache_dir}/src/datadog-trace-agent/src/github.com/DataDog/datadog-trace-agent"
end
