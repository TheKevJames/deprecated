# Install subversion packages.
class subversion(
  $packages = undef,
  $diff = undef,
  $diff3 = undef,
  $editor = undef,
  $mergetool = undef,
  $passwordstore = undef
) {

  ensure_packages($packages, { ensure => latest })

}
