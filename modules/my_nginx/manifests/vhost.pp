define my_nginx::vhost ($ssl=true, $default_server=false, $vhost_dir=undef) {
  include my_nginx
  include my_nginx::params


  if $vhost_dir {
    $vhost_dir_actual = $vhost_dir
  } else {
    $vhost_dir_actual = "${my_nginx::params::wwwroot}/${name}"
  }

  file { $vhost_dir_actual:
    ensure => directory,
    owner => root,
    group => root,
    mode => 0644,
    recurse => true,
    purge => true,
  }

  if $default_server {
    $listen_options = 'default_server'
    $ipv6_listen_options = 'default_server ipv6only=on'
  } else {
    $listen_options = ''
    $ipv6_listen_options = ''
  }

  if $ssl {
    $rewrite_to_https = true
  } else {
    $rewrite_to_https = false
  }

  nginx::resource::vhost { $name:
    ensure      => present,
    server_name => [$name],
    www_root    => $vhost_dir_actual,
    ipv6_enable => true,
    listen_options => $listen_options,
    ipv6_listen_options => $ipv6_listen_options,
    rewrite_to_https => $rewrite_to_https,
    access_log  => "${my_nginx::params::logdir}/${name}_access.log",
    error_log   => "${my_nginx::params::logdir}/${name}_error.log",
    require     => [File[$vhost_dir_actual], File[$my_nginx::params::logdir]],
  }

  if $ssl {
    $cert = "${my_nginx::params::certdir}/${name}.crt"
    $key = "${my_nginx::params::certdir}/${name}.key"

    my_nginx::cert { $name:
      cert => $cert,
      key => $key,
    }

    nginx::resource::vhost { "${name}_ssl":
      ensure      => present,
      server_name => [$name],
      www_root    => $vhost_dir_actual,
      ipv6_enable => true,
      ssl         => true,
      ssl_cert    => $cert,
      ssl_key     => $key,
      listen_port => 443,
      listen_options => $listen_options,
      ipv6_listen_options => $ipv6_listen_options,
      access_log  => "${my_nginx::params::logdir}/${name}_ssl_access.log",
      error_log   => "${my_nginx::params::logdir}/${name}_ssl_error.log",
      require     => [File[$vhost_dir_actual], File[$my_nginx::params::logdir], My_nginx::Cert[$name]],
    }
  }
}
