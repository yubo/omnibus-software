#
# Copyright 2016 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "stunnel"
default_version "5.39"

license "GPL-2.0"
license_file "COPYING"
skip_transitive_dependency_licensing true

dependency "openssl"

source url:
"https://www.stunnel.org/downloads/stunnel-#{version}.tar.gz"
relative_path "stunnel-#{version}"

version "5.38" do
  source sha256: "09ada29ba1683ab1fd1f31d7bed8305127a0876537e836a40cb83851da034fd5"
end

version "5.39" do
  source sha256: "288c087a50465390d05508068ac76c8418a21fae7275febcc63f041ec5b04dee"
end

build do
  env = with_standard_compiler_flags(with_embedded_path)

  patch source: "stunnel-on-windows.patch", plevel: 1, env: env if windows?

  configure_args = [
    "--with-ssl=#{install_dir}/embedded",
    "--prefix=#{install_dir}/embedded",
  ]
  configure_args << "--enable-fips" if fips_mode?

  configure(*configure_args, env: env)

  if windows?
    # src/mingw.mk hardcodes and assumes SSL is at /opt so we patch and use
    # an env variable to redirect it to the correct location
    env["WIN32_SSL_DIR_PATCHED"] = "#{install_dir}/embedded"

    if windows_arch_i386?
      make "mingw", env: env, cwd: "#{project_dir}/src"
    else
      make "mingw64", env: env, cwd: "#{project_dir}/src"
    end

    # Stack Smash Protection
    dll = "libssp-0.dll"
    mingw = ENV["MSYSTEM"].downcase
    msys_path = ENV["OMNIBUS_TOOLCHAIN_INSTALL_DIR"] ? "#{ENV["OMNIBUS_TOOLCHAIN_INSTALL_DIR"]}/embedded/bin" : "C:/msys2"
    windows_path = "#{msys_path}/#{mingw}/bin/#{dll}"
    if File.exist?(windows_path)
      copy windows_path, "#{install_dir}/embedded/bin/#{dll}"
    else
      raise "Cannot find required DLL needed for dynamic linking: #{windows_path}"
    end
  else
    make env: env
    make "install", env: env
  end
end