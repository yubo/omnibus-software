name "lmsensors"
default_version "3.4.0"

source :url => "https://fossies.org/linux/misc/lm_sensors-#{version}.tar.gz",
       :sha256 => "7fa779633ea1ee4391d440de6369d9bdd8eaf38a42dc7daf05522b9640920b38"

relative_path "lm_sensors-#{version}"

# order matters here
dependency "bison"
dependency "flex"

build do
  ship_license "https://raw.githubusercontent.com/groeck/lm-sensors/master/COPYING.LGPL"
  command "make -j #{workers} PREFIX=#{install_dir}/embedded", :env => { "LD_RUN_PATH" => "#{install_dir}/embedded/lib" }
  command "make install PREFIX=#{install_dir}/embedded"
end
