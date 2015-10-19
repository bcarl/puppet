define my_nginx::site::jekyll ($repo, $branch='master', $ssl=true) {
  include jekyll
  include git
  include my_nginx
  include my_nginx::params

  my_nginx::site::static { $name: ssl => $ssl }

  $vcsrepo_path = "${my_nginx::params::gitroot}/${name}"
  $site_path = "${my_nginx::params::wwwroot}/${name}"

  vcsrepo { $vcsrepo_path:
    ensure   => latest,
    provider => git,
    source   => $repo,
    revision => $branch,
  }

  exec { "jekyll build --source '${vcsrepo_path}' --destination '${site_path}'":
    cwd => $vcsrepo_path,
    path => '/usr/bin:/usr/sbin:/bin',
    subscribe => Vcsrepo[$vcsrepo_path],
  }
}
