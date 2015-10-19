class my_nginx::params {
  $certdir = '/etc/nginx/ssl'
  $logdir = '/var/log/nginx'
  $wwwroot = '/var/www'
  $gitroot = '/var/www-git'
  $buildroot = '/var/www-build'
  $execpath = '/usr/local/bin:/usr/bin:/usr/sbin:/bin'
}
