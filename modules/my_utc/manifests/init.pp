class my_utc {
  exec { 'timedatectl set-timezone UTC':
    path => '/usr/bin:/usr/sbin:/bin',
    unless => 'timedatectl status | grep "Time zone: UTC"'
  }
}
