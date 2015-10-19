define my_nginx::site::static ($html, $ssl=true, $default_server=false) {
  include my_nginx::params

  $vhost_dir = "${my_nginx::params::wwwroot}/${name}"

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
    vhost_dir => $vhost_dir,
  }
}
