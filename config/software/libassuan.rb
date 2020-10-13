#
# Copyright:: Chef Software, Inc.
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

name "libassuan"
default_version "2.5.3"

dependency 'libgpg-error'

license "LGPL-2.1"
license_file "COPYING.LIB"
skip_transitive_dependency_licensing true

version("2.5.3") { source sha256: "91bcb0403866b4e7c4bc1cc52ed4c364a9b5414b3994f718c70303f7f765e702" }

source url: "https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-#{version}.tar.bz2"

relative_path "libassuan-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  configure_options = [
    "--prefix=#{install_dir}/embedded",
    "--enable-maintainer-mode",
  ]

  configure(*configure_options, env: env)

  make "-j #{workers}", env: env
  make "install", env: env
end
