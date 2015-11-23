name "timeout-decorator"
default_version "0.3.2"

dependency "python"
dependency "pip"

build do
  ship_license "https://raw.githubusercontent.com/pnpnpn/timeout-decorator/master/LICENSE.txt"
  command "#{install_dir}/embedded/bin/pip install -I --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}"
end
