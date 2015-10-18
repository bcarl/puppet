class my_sites {
  my_nginx::site::static { '_': html => 'default', default_server => true }
  my_nginx::site::static { 'vbzb.com': html => 'hello world' }
}
