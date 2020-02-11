name "sysstat"
default_version "11.1.3"

ship_source true

source url: "https://github.com/sysstat/sysstat/archive/v#{version}.tar.gz",
       sha256: "e76dff7fa9246b94c4e1efc5ca858422856e110f09d6a58c5bf6000ae9c9d16e"

relative_path "sysstat-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}
if linux?
  env = with_glibc_version(env)
end

build do
  ship_license "https://raw.githubusercontent.com/sysstat/sysstat/master/COPYING"

  patch source: "sysstat-11.1.3-hackadog.patch", env: env

  command(["./configure",
       "--prefix=#{install_dir}/embedded",
       "--disable-nls", "--disable-sensors"].join(" "),
    env: env)
  command "make -j #{workers}", env: env
  command "make install"
end
