class my_utc {
  exec { 'timedatectl set-timezone UTC':
    unless => 'timedatectl status | grep "Time zone: UTC"'
  }
}
