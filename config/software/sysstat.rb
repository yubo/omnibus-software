name "sysstat"
default_version "12.3.2"

ship_source true

source url: "https://github.com/sysstat/sysstat/archive/v#{version}.tar.gz",
       sha256: "c53b48f0a89cf0f6ea2af67ef0caf44ceed500d37fa7042a871a0541a1ce235d"

relative_path "sysstat-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  ship_license "https://raw.githubusercontent.com/sysstat/sysstat/master/COPYING"
  command(["./configure",
       "--prefix=#{install_dir}/embedded",
       "--disable-nls", "--disable-sensors"].join(" "),
    env: env)
  command "make -j #{workers}", env: { "LD_RUN_PATH" => "#{install_dir}/embedded/lib" }
  command "make install"
end
