name "protobuf-py-cpp"
default_version "3.4.0"

source :url => "https://github.com/google/protobuf/releases/download/v#{version}/protobuf-python-#{version}.tar.gz",
       :sha256 => "3f833c1c367f53803f5f849181af4a4edb20f8dd1fbdced19b5a2d52ee43ed54"

relative_path "protobuf-#{version}/python"

env = {}

if ohai["platform_family"] == "mac_os_x"
  env["MACOSX_DEPLOYMENT_TARGET"] = "10.9"
end

build do
  ship_license "https://raw.githubusercontent.com/google/protobuf/3.4.x/LICENSE"

  # Note: RHEL5 is equipped with gcc4.1 that is not supported by Protobuf (it actually crashes during the build)
  # so we use the official package from PyPI and skip the CPP extension for the time being.
  # C++ runtime
  command ["cd .. && ./configure",
              "--prefix=#{install_dir}/embedded",
              "--enable-static=no",
              "--without-zlib"].join(" ")

  # You might want to temporarily uncomment the following line to check build sanity (e.g. when upgrading the
  # library) but there's no need to perform the check every time.
  # command "cd .. && make check"
  command "cd .. && make -j #{workers}"
  command "cd .. && make install"
end
