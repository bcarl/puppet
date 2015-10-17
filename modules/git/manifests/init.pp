class git {
  package { ['git', 'git-core']:
    ensure => installed
  }
}
