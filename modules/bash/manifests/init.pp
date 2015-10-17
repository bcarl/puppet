class bash {
  package { ['bash', 'bash-completion']:
    ensure => installed
  }
}
