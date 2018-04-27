class mpd::client($packages) {

  include ::mpd

  ensure_packages($packages, { ensure => latest})

}
