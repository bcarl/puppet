define users::user ($uid, $gid, $shell, $groups, $ssh_key) {
  $home = "/home/${name}"

  group { $name:
    ensure => present,
    gid    => $gid,
  }

  group { $groups:
    ensure => present,
  }

  user { $name:
    ensure         => present,
    home           => $home,
    shell          => $shell,
    uid            => $uid,
    gid            => $gid,
    groups         => $groups,
    password       => '*',
    purge_ssh_keys => true,
    require        => [Group[$name], Group[$groups]],
  }

  file { $home:
    ensure  => directory,
    owner   => $name,
    group   => $name,
    mode    => 0700,
    require => User[$name],
  }

  $ssh_dir = "${home}/.ssh"

  file { $ssh_dir:
    ensure  => directory,
    owner   => $name,
    group   => $name,
    mode    => 0700,
    require => File[$home],
  }

  $authorized_keys = "${ssh_dir}/authorized_keys"

  file { $authorized_keys:
    ensure  => present,
    owner   => $name,
    group   => $name,
    mode    => 0600,
    require => File[$ssh_dir],
  }

  Ssh_authorized_key {
    require =>  File[$authorized_keys]
  }

  if $ssh_key {
    ssh_authorized_key { $ssh_key['comment']:
      ensure => present,
      user   => $name,
      type   => $ssh_key['type'],
      key    => $ssh_key['key'],
    }
  }
}
