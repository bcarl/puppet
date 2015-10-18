define my_nginx::cert ($cert, $key, $type='rsa', $bits=2048) {
  include ssl
  exec { "create_self_signed_sslcert_${name}":
    command => "openssl req -newkey ${type}:${bits} -nodes -keyout ${key} -x509 -days 365 -out ${cert} -subj '/CN=${name}'",
    cwd     => $my_nginx::params::certdir,
    creates => [$cert, $key],
    path    => ['/usr/bin', '/usr/sbin'],
    require => Package['openssl'],
  }
}