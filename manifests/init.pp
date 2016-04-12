# Install subversion packages.
class subversion($packages, $diff, $diff3, $editor, $mergetool, $passwordstore) {

  ensure_packages($packages, { ensure => latest })

}
