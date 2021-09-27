name "unixodbc"
default_version "2.3.7"

version "2.3.7" do
  source sha256: "a226f9eed19e8519125c4e71c077849de1c2862ea212a25a735bfab9c78cc6b5"
end

source url: "https://github.com/lurcher/unixODBC/archive/refs/tags/#{version}.tar.gz"

relative_path "unixODBC-#{version}"

build do
  ship_license "./COPYING"
  env = with_standard_compiler_flags(with_embedded_path)

  configure_args = [
    "--disable-readline",
    "--prefix=#{install_dir}/embedded",
    "--with-included-ltdl",
    "--enable-ltdl-install",
  ]

  configure_command = configure_args.unshift("./configure").join(" ")

  command configure_command, env: env, in_msys_bash: true
  make env: env
  make "install", env: env

  # Remove the sample (empty) files unixodbc adds, otherwise they will replace
  # any user-added configuration on upgrade.
  delete "#{install_dir}/embedded/etc/odbc.ini"
  delete "#{install_dir}/embedded/etc/odbcinst.ini"

  # Add a section to the README
  block do
    File.open(File.expand_path(File.join(install_dir, "/embedded/etc/README.md")), "a") do |f|
      f.puts <<~EOF
          ## unixODBC

          To add unixODBC data sources that can be used by the Agent embedded environment,
          add `odbc.ini` and `odbcinst.ini` files to this folder, containing the data sources'
          configuration.

      EOF
    end
  end
end
