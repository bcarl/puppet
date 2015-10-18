class my_sites {
  my_nginx::site::static { '_': default_server => true, html => '<!DOCTYPE html>' }
  my_nginx::site::static { 'web.bcarl.me': html => '<!DOCTYPE html>' }
  my_nginx::site::static { 'vbzb.com': html => '<!DOCTYPE html><html><body><small>vbzb.com' }
  my_nginx::site::static { 'dev.bcarl.me': html => '<!DOCTYPE html><html><body><small>dev.bcarl.me' }
}
