define users::user_file ($ensure, $user, $mode, $source) {
  concat { $name:
    ensure => $ensure,
    owner  => $user,
    group  => $user,
    mode   => $mode,
    ensure_newline => true,
  }
  concat::fragment { "${name} header":
    target => $name,
    source => 'puppet:///modules/users/header',
    order  => '01',
  }
  concat::fragment { "${name} user":
    target => $name,
    source => $source,
    order  => '02',
  }
}