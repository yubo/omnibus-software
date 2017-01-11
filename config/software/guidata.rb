name 'guidata'

default_version '1.6.1'

dependency 'pyside'

source :url => "https://github.com/PierreRaybaut/guidata/archive/v#{version}.zip",
       :md5 => "6827b98db4aca3ca50a7efa419367633"

relative_path "guidata-#{version}"

env = {
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  patch :source => 'fix_blocking_import.patch'
  patch :source => 'remove_default_image_path.patch' if ohai['platform_family'] == 'mac_os_x'
  command "#{install_dir}/embedded/bin/python setup.py install "\
          "--record #{install_dir}/embedded/guidata-files.txt", :env => env
end
