class jekyll {
  package { ['gcc', 'make', 'nodejs', 'ruby', 'ruby-dev']:
    ensure => installed,
  } ->
  package { 'jekyll':
    ensure => installed,
    provider => gem,
    install_options => ['--no-rdoc', '--no-ri'],
  }
}
