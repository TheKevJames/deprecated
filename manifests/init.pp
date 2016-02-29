class git($packages, $conflictstyle, $browser, $difftool, $editor, $pager, $tar) {

  ensure_packages($packages, { ensure => latest })

}
