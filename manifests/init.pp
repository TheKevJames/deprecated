class bazaar($packages, $editor, $mergetool, $tabwidth) {

  ensure_packages($packages, { ensure => latest })

}
