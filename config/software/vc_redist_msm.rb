# Microsoft Visual C++ redistributable

name "vc_redist_msm"
default_version "90"

# TODO: same for 32 bits
# source :url => "https://s3.amazonaws.com/dd-agent-omnibus/msvcrntm_x64.tar.gz",
#source :url => "http://192.168.255.32/sp0/Microsoft_VC90_CRT_x86_x64.msm",
#       :sha256 => "d5b4e8b100d2a9a6a756bb6d70df67203e3b611f49866f84944607dc096e4afe"

source :url => "http://192.168.255.32/sp1/Microsoft_VC90_CRT_x86_x64.msm",
       :sha256 => "a3ce9f8b524e8eee31cd0487dead3a89bfa9721d660fdce6ac56b59819e17917"

relative_path "vc_redist_msm"

build do
  # We also need to have these dlls side by side with the `.exe`... I think
  # command "XCOPY /YEH .\\*.dll \"#{windows_safe_path(install_dir)}\\embedded\" /MIR"
  tgt_dir = "#{Omnibus::Config.source_dir}\\extra_package_files"
  FileUtils.mkdir_p(tgt_dir) unless File.directory?(tgt_dir)
  command "copy /y .\\*.msm \"#{windows_safe_path(Omnibus::Config.source_dir)}\\extra_package_files\""
end
