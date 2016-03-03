class transmission::gui($home, $config_folder) {

  include ::transmission

  file { "${home}/${config_folder}": ensure => directory } ->
  file { "${home}/${config_folder}/settings.json":
    ensure  => present,
    content => template('transmission/gui.erb'),
    mode    => '0644',
  }

}
