class git($packages, $conflictstyle, $browser, $editor, $mergetool, $pager, $tar) {

  ensure_packages($packages, { ensure => latest })

}
