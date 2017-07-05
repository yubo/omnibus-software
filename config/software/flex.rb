name "flex"
default_version "2.6.0"

relative_path "flex-#{version}"

version "2.6.0" do
  source :url => "https://downloads.sourceforge.net/project/flex/flex-2.6.0.tar.gz",
         :md5 => "5724bcffed4ebe39e9b55a9be80859ec"
end

version "2.6.4" do
  source :url => "https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz",
         :sha256 => "e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995"
end

default_version "2.6.4"

env = with_standard_compiler_flags()

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make -j #{workers}", :env => env
  command "make -j #{workers} install", :env => env
end
