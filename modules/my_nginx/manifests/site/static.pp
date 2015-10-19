define my_nginx::site::static ($html, $ssl=true, $default_server=false) {
  include nginx::config
  include nginx::params
  include my_nginx
  include my_nginx::params

  file { "${vhost_dir}/index.html":
    ensure => present,
    content => $html,
    owner => root,
    group => root,
    mode => 0644,
    require => File[$vhost_dir],
  }

  my_nginx::vhost { $name:
    ssl => $ssl,
    default_server => $default_server,
  }
}
