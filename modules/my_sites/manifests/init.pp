class my_sites {
  my_nginx::site::static { '_': default_server => true, html => '<!DOCTYPE html>' }
  my_nginx::site::static { 'web.bcarl.me': html => '<!DOCTYPE html>' }
  my_nginx::site::static { 'vbzb.com': html => '<!DOCTYPE html><html><body><small>vbzb.com' }
  my_nginx::site::static { 'dev.bcarl.me': html => '<!DOCTYPE html><html><body><small>dev.bcarl.me' }

  my_nginx::site::jekyll { 'jekyll-test.bcarl.me':
    repo => 'https://github.com/bcarl/bcarl.me.git',
    branch => 'gh-pages',
  }
}
