define my_nginx::site::static ($content=undef, $source=undef, $ssl=true, $default_server=false) {
  include my_nginx::params

  $vhost_dir = "${my_nginx::params::wwwroot}/${name}"

  if (! $content and ! $source) or ($content and $source) {
    fail('one of content or source required')
  }

  file { "${vhost_dir}/index.html":
    ensure => present,
    content => $content,
    source => $source,
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
