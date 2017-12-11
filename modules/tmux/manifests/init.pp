class tmux {
  package { 'tmux':
    ensure => installed,
  }

  file { '/usr/local/bin/tmux-auto-session':
    ensure => file,
    source => 'puppet:///modules/tmux/tmux-auto-session',
    mode   => 0755,
    owner  => root,
    group  => root,
  }
  file { '/usr/local/bin/tmux-login-shell':
    ensure => file,
    source => 'puppet:///modules/tmux/tmux-login-shell',
    mode   => 0755,
    owner  => root,
    group  => root,
  }
}