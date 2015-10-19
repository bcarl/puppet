class my_packages ($gems, $packages) {
  if $gems {
    package { $gems:
      ensure => installed,
      provider => gem,
    }
  }
  if $packages {
    package { $packages:
      ensure => installed,
    }
  }
}
