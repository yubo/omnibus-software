name "pywin32"
default_version "221"

dependency "python"
dependency "pip"
source :url => "https://derekwbrown.github.io/pywin32-221-cp27-cp27m-win_amd64.whl",
       :sha256 => "d0a5ba858dcb08e110a73a25e543b57bbb35c0329685fcee5a9e9dfb31706457"

build do
  relative_path "pywin32-#{version}"
  # Switch on the architecture
  pip "install pywin32-221-cp27-cp27m-win_amd64.whl "\
      "--prefix=#{windows_safe_path(install_dir)}/embedded"
  # pywintypes is patched, it doesn't work on Python > 2.7 otherwise
  # Since we don't install it from source, we can't use the patch option of omnibus
  # Here is a manual patch, using the same options as omnibus
  patch_path = File.realpath(
    File.join(
      File.dirname(__FILE__), "..",
      "patches", "pywin32", "fix_pywintypes_dll_import.patch"
    )
  )
  win32_path = File.join(install_dir, "embedded", "Lib", "site-packages", "win32")
  command "patch -d \"#{win32_path}\" -p1 -i \"#{patch_path}\""
end
