class users ($users) {
  create_resources(users::user, $users)

  users::user_file { '/usr/local/bin/scm-prompt':
    ensure => present,
    user   => 'root',
    mode   => 0755,
    source => 'puppet:///modules/users/scm-prompt',
  }
}
