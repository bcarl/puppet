define my_nginx::vhost($ssl => false) {
  nginx::resource::vhost { $name:
    www_root   => '/var/www/${name}',
    ssl        => $ssl,
    access_log => '/var/log/nginx/${name}_access.log',
    error_log  => '/var/log/nginx/${name}_error.log',
  }
}
