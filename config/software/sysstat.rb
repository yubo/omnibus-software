name "sysstat"
default_version "11.1.3"

source :url => "http://perso.orange.fr/sebastien.godard/sysstat-#{version}.tar.xz",
       :md5 => "3795dd5443efd6bc5d682d597423aa9f"

relative_path "sysstat-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  ship_source "http://perso.orange.fr/sebastien.godard/sysstat-#{version}.tar.xz"
  ship_license "https://raw.githubusercontent.com/sysstat/sysstat/master/COPYING"
  command(["./configure",
       "--prefix=#{install_dir}/embedded",
       "--disable-nls"].join(" "),
    :env => env)
  command "make -j #{workers}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "sudo make install"
end
