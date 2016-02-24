class git($packages, $conflictstyle, $browser, $editor, $mergetool, $pager, $tar) {

  package { $packages: ensure => latest }

}
