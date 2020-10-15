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

name "ntbtls"
default_version "0.2.0"

license "GPLv3"
license_file "COPYING"
skip_transitive_dependency_licensing true

version("0.2.0") { source sha256: "649fe74a311d13e43b16b26ebaa91665ddb632925b73902592eac3ed30519e17" }

source url: "https://www.gnupg.org/ftp/gcrypt/ntbtls/ntbtls-#{version}.tar.bz2"

relative_path "ntbtls-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  configure_options = [
    "--enable-maintainer-mode",
  ]

  configure(*configure_options, env: env)

  make "-j #{workers}", env: env
  make "install", env: env
end
