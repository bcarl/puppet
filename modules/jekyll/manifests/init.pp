class jekyll {
  package { 'jekyll':
    ensure => installed,
    provider => gem,
  }
}
