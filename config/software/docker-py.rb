name "docker-py"
default_version "1.10.6"

dependency "python"
dependency "pip"
dependency "pywin32"

build do
  ship_license "Apachev2"
  pip "install --install-option=\"--install-scripts=#{windows_safe_path(install_dir)}/bin\" #{name}==#{version}"
end
