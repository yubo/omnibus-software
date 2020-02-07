name "nghttp2"
default_version "1.12.0"

dependency "openssl"

source url: "https://github.com/nghttp2/nghttp2/releases/download/v1.12.0/nghttp2-#{version}.tar.gz",
       md5: "04235f1d7170a2efce535068319180a1"

relative_path "nghttp2-#{version}"

env = with_standard_compiler_flags(with_embedded_path)
env["OPENSSL_CFLAGS"] = "-I#{install_dir}/embedded/include/openssl"
env["OPENSSL_LIBS"] = "-L#{install_dir}/embedded/lib"
env["LD_RUN_PATH"] = "#{install_dir}/embedded/lib"

if linux?
  env = with_glibc_version(env)
end

build do
  command [
    "./configure",
    "--disable-app",
    "--disable-examples",
    "--disable-hpack-tools",
    "--prefix=#{install_dir}/embedded",
  ].join(" "), env: env
  command "make -j #{workers}", env: {  }
  command "make install"
end
