name "grpcio-tools"
default_version "1.0.0"

dependency "python"
dependency "pip"
dependency "cython"

build do
  ship_license "https://raw.githubusercontent.com/grpc/grpc/master/LICENSE"
  command "#{install_dir}/embedded/bin/pip install --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}", :env => env
end
