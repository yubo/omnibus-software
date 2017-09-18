name "supervisor"
default_version "3.3.3"

dependency "python"
dependency "pip"

build do
  supervisord_file = "#{install_dir}/bin/supervisord"
  supervisorctl_file = "#{install_dir}/bin/supervisorctl"
  pidproxy_file = "#{install_dir}/bin/pidproxy"

  ship_license "https://raw.githubusercontent.com/Supervisor/supervisor/master/LICENSES.txt"
  pip "install --install-option=\"--install-scripts=#{install_dir}/bin\" #{name}==#{version}"

  # install-option not being honored with 3.3.3
  if !File.exists?(supervisord_file)
    link "#{install_dir}/embedded/bin/supervisord", "#{supervisord_file}", :force
    link "#{install_dir}/embedded/bin/supervisorctl", "#{supervisorctl_file}", :force
    link "#{install_dir}/embedded/bin/pidproxy", "#{pidproxy_file}", :force
  end
end
