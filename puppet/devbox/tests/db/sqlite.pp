class { '::devbox':
  home => '/root',
}

class { '::devbox::db::sqlite':
}
