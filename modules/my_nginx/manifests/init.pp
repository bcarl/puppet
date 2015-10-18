class my_nginx {
  include nginx
  my_nginx::vhost { 'vbzb.com': ssl => true }
}
