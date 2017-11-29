name "protobuf-py"
default_version "3.4.0"

dependency "python"
dependency "setuptools"
dependency "pip"
dependency "six"
dependency "protobuf-py-cpp"


build do
  ship_license "https://raw.githubusercontent.com/google/protobuf/3.4.x/LICENSE"

  pip "install protobuf==#{version} --install-option=\"--cpp_implementation\""
end
