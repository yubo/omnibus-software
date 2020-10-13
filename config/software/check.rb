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

name "check"
default_version "0.15.2"

license "LGPL-2.1"
license_file "COPYING.LESSER"
skip_transitive_dependency_licensing true

version("0.15.2") { source sha256: "a8de4e0bacfb4d76dd1c618ded263523b53b85d92a146d8835eb1a52932fa20a" }

source url: "https://github.com/libcheck/check/releases/download/#{version}/check-#{version}.tar.gz"

relative_path "check-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  configure_options = [
    "--prefix=#{install_dir}/embedded",
  ]

  configure(*configure_options, env: env)

  make "-j #{workers}", env: env
  make "install", env: env
end
