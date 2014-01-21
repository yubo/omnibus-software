#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
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

name "keepalived"
version "1.2.10"

dependency "popt"

source :url => "http://www.keepalived.org/software/keepalived-1.2.10.tar.gz",
       :md5 => "d838c23d80682650315d1ae447dad48a"
#source :url => "https://api.github.com/repos/acassen/keepalived/tarball/v1.2.10",
#       :md5 => "06eecd2c4f497e28f85008dc930b2731"

relative_path "keepalived-1.2.10"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -static-libgcc",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command "./configure --prefix=#{install_dir}/embedded --disable-iconv", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install"
end


