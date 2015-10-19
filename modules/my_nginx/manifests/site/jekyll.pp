define my_nginx::site::jekyll ($repo, $branch='master', $ssl=true) {
  include jekyll
  include git
  include my_nginx
  include my_nginx::params

  my_nginx::site::static { $name: ssl => $ssl }

  $repo_path = "${my_nginx::params::gitroot}/${name}"
  $vhost_dir = "${my_nginx::params::wwwroot}/${name}"

  vcsrepo { $repo_path:
    ensure   => latest,
    provider => git,
    source   => $repo,
    revision => $branch,
  }

  exec { "rm -rf '${vhost_dir}' && jekyll build --safe --source '${repo_path}' --destination '${vhost_dir}'":
    cwd => $repo_path,
    path => '/usr/local/bin:/usr/bin:/usr/sbin:/bin',
    subscribe => Vcsrepo[$repo_path],
  }

  my_nginx::vhost { $name:
    ssl => $ssl,
    default_server => $default_server,
  }
}
