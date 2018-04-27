class clementine($packages, $config_file, $config_folder, $config_template, $home, $music_dir) {

  package { $packages: ensure => latest }

  file { "${home}/${config_folder}": ensure => directory } ->
  file { "${home}/${config_folder}/${config_file}":
    ensure  => file,
    content => template("clementine/${config_template}"),
    mode    => '0644',
  }

}
