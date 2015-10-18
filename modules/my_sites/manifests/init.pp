class my_sites {
  my_nginx::site::static { '_': html => '<!DOCTYPE html>', default_server => true }
  my_nginx::site::static { 'vbzb.com': html => '<!DOCTYPE html><html><body><small>vbzb.com' }
  my_nginx::site::static { 'dev.bcarl.me': html => '<!DOCTYPE html><html><body><small>dev.bcarl.me' }
}
