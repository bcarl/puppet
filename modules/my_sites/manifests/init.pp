class my_sites {
  my_nginx::site::static { '_': default_server => true, content => '<!DOCTYPE html>' }
  my_nginx::site::static { 'spleeyah.com': source => 'puppet:///modules/my_sites/empty.html' }
  my_nginx::site::static { 'u9t.net': source => 'puppet:///modules/my_sites/empty.html'}
  my_nginx::site::static { 'vbzb.com': source => 'puppet:///modules/my_sites/empty.html'}
  my_nginx::site::jekyll { 'jekyll-test.bcarl.me':
    repo => 'https://github.com/bcarl/bcarl.me.git',
    branch => 'gh-pages',
  }
}
