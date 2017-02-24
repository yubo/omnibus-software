# Microsoft Visual C++ redistributable

name "vc_redist_policy_msm"
default_version "90"

# TODO: same for 32 bits
# source :url => "https://s3.amazonaws.com/dd-agent-omnibus/msvcrntm_x64.tar.gz",

#source :url => "http://192.168.255.32/sp0/policy_9_0_Microsoft_VC90_CRT_x86_x64.msm",
#       :sha256 => "339a8334f1ddacc24f052594aecec6925c7c575ca0e8f07004cbbb7e0263a91e"

source :url => "http://192.168.255.32/sp1/policy_9_0_Microsoft_VC90_CRT_x86_x64.msm",
       :sha256 => "0bc32881753fd98c16462cd3ed720fefc2505ac2a0a811ec039e80943c01d4ba"

relative_path "vc_redist_policy_msm"

build do
  # We also need to have these dlls side by side with the `.exe`... I think
  # command "XCOPY /YEH .\\*.dll \"#{windows_safe_path(install_dir)}\\embedded\" /MIR"
  command "copy /y .\\*.msm \"#{windows_safe_path(Omnibus::Config.source_dir)}\\extra_package_files\""
end
