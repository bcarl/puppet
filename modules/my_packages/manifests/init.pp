class my_packages ($packages) {
  if $packages {
    package { $packages:
      ensure => installed,
    }
  }
}
