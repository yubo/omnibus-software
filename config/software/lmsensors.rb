name "lmsensors"
default_version "3.4.0"

source :url => "https://fossies.org/linux/misc/lm_sensors-#{version}.tar.gz",
       :sha256 => "e334c1c2b06f7290e3e66bdae330a5d36054701ffd47a5dde7a06f9a7402cb4e"

relative_path "lm_sensors-#{version}"

dependency "flex"
dependency "bison"

build do
  ship_license "https://raw.githubusercontent.com/groeck/lm-sensors/master/COPYING.LGPL"
  command "make -j #{workers} PREFIX=#{install_dir}/embedded", :env => { "LD_RUN_PATH" => "#{install_dir}/embedded/lib" }
  command "make install PREFIX=#{install_dir}/embedded"
end
