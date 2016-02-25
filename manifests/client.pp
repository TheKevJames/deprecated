class mpd::client($packages) {

  include ::mpd

  package { $packages: ensure => latest }

}
