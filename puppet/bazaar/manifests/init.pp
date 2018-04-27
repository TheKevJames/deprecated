# Installs bazaar.
class bazaar($package_index, $packages, $editor, $mergetool, $tabwidth) {

  ensure_packages($package_index, { ensure => latest })
  ensure_packages($packages, { ensure => latest })

}
