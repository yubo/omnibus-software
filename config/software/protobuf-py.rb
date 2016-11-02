name "protobuf-py"
default_version "3.1.0"

dependency "python"
dependency "setuptools"
dependency "pip"
dependency "six"

source :url => "https://github.com/google/protobuf/releases/download/v#{version}/protobuf-python-#{version}.tar.gz",
       :sha256 => "0bc10bfd00a9614fae58c86c21fbcf339790e48accf6d45f098034de985f5405"

relative_path "protobuf-#{version}/python"

env = {}

if ohai['platform_family'] == 'mac_os_x'
    env['MACOSX_DEPLOYMENT_TARGET'] = '10.9'
end

build do
    ship_license "https://raw.githubusercontent.com/google/protobuf/3.1.x/LICENSE"

    build_options = ""

    # C++ runtime
    if ohai['platform_family'] != 'rhel'
        command ["cd .. && ./configure",
                 "--prefix=#{install_dir}/embedded",
                 "--enable-static=no",
                 "--without-zlib"].join(" ")

        command "cd .. && make check"
        command "cd .. && make -j #{workers}"
        command "cd .. && make install"

        build_options = "--cpp_implementation"
    end

    # Python lib
    command "#{install_dir}/embedded/bin/python setup.py build #{build_options}", :env => env
    command "#{install_dir}/embedded/bin/python setup.py test #{build_options}", :env => env
    command "#{install_dir}/embedded/bin/pip install . --install-option=\"#{build_options}\""

    # We don't need protoc
    delete "#{install_dir}/embedded/lib/libprotoc.*"
    delete "#{install_dir}/embedded/bin/protoc"
end
