# Base devbox configuration.
class devbox($update_packages_command, $home) {

  exec { 'update-packages': command => $update_packages_command }
  Exec['update-packages'] -> Package <| |>

  ensure_resource(file, ["${home}/.config", "${home}/.config/terminal", "${home}/.config/terminal/extras"], { ensure => directory })
  ensure_resource(file, ["${home}/.local", "${home}/.local/share"], { ensure => directory })

}
