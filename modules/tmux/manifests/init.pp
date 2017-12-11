class tmux {
  package { 'tmux':
    ensure => installed,
  }

  file { '/usr/local/bin/tmux-auto-session.sh':
    ensure => file,
    source => 'puppet:///modules/tmux/auto-session.sh',
    mode   => 0755,
    owner  => root,
    group  => root,
  }
}