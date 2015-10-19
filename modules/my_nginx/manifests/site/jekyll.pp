define my_nginx::site::jekyll ($repo, $branch='master', $ssl=true) {
  include jekyll
  include my_nginx::params
  include my_packages

  $repo_path = "${my_nginx::params::gitroot}/${name}"
  $build_dir = "${repo_path}_build"
  $vhost_dir = "${my_nginx::params::wwwroot}/${name}"
  $sha1_path = "${vhost_dir}/_sha1"
  $sha1_exec = "$(cd ${repo_path} && git rev-parse HEAD)"

  vcsrepo { $repo_path:
    ensure   => latest,
    owner    => root,
    group    => root,
    provider => git,
    source   => $repo,
    revision => $branch,
    require  => Package['git'],
  } ->
  exec { "build_jekyll_site_${name}":
    command => "rm -rf '${build_dir}' && mkdir '${build_dir}' && \
                jekyll build --safe --source '${repo_path}' --destination '${build_dir}' && \
                rm -rf '${vhost_dir}' && mv '${build_dir}' '${vhost_dir}' && \
                echo ${sha1_exec} > ${sha1_path}",
    cwd => $repo_path,
    path => $my_nginx::params::execpath,
    unless => "test ${sha1_exec} = $(cat ${sha1_path})",
    notify => Service['nginx'],
    require => [File[$my_nginx::params::wwwroot], Vcsrepo[$repo_path], Package['jekyll']],
  }

  my_nginx::vhost { $name:
    ssl => $ssl,
    default_server => $default_server,
    vhost_dir => $vhost_dir,
    purge_vhost => false,
  }
}
