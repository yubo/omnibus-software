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

name "gnupg"
default_version "2.2.23"

dependency 'libksba'
dependency 'npth'
dependency 'libgpg-error'
dependency 'libgcrypt'
dependency 'libassuan'
dependency 'ntbtls'
dependency 'zlib'
dependency 'bzip2'
dependency 'sqlite'
dependency 'readline'
dependency 'ncurses'

license "LGPL-2.1"
license_file "COPYING.LGPL21"
skip_transitive_dependency_licensing true

version("2.2.23") { source sha256: "10b55e49d78b3e49f1edb58d7541ecbdad92ddaeeb885b6f486ed23d1cd1da5c" }

source url: "https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-#{version}.tar.bz2"

relative_path "gnupg-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  configure_options = [
    "--enable-maintainer-mode",
    "--disable-guile",
    "--disable-dane",
    "--disable-static",
    "--disable-openssl-compatibility",
    "--disable-non-suiteb-curves",
    "--disable-gnutls",
    "--disable-ldap",
    "--disable-dirmngr",
    "--disable-doc",
    "--disable-wks-tools",
    "--disable-scdaemon",
  ]

  configure(*configure_options, env: env)

  make "-j #{workers}", env: env
  make "install", env: env
end
