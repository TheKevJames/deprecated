# Base devbox configuration.
class devbox($home) {

  ensure_resource(file, ["${home}/.config", "${home}/.config/terminal", "${home}/.config/terminal/extras"], { ensure => directory })
  ensure_resource(file, ["${home}/.local", "${home}/.local/share"], { ensure => directory })

}
