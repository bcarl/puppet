# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-masterless-puppet-environment-on-ubuntu-14-04
class cron-puppet {
  $puppet_update_sh = '/usr/local/sbin/puppet-update.sh'

  file { 'post-hook':
    ensure  => file,
    path    => '/etc/puppet/.git/hooks/post-merge',
    source  => 'puppet:///modules/cron-puppet/post-merge',
    mode    => 0755,
    owner   => root,
    group   => root,
  }
  cron { 'puppet-apply':
    ensure  => present,
    command => $puppet_update_sh,
    user    => root,
    minute  => '*/30',
    require => File['post-hook'],
  }
  file { '/usr/local/sbin/puppet-apply.sh':
    ensure => file,
    source => 'puppet:///modules/cron-puppet/puppet-apply.sh',
    owner  => root,
    group  => root,
    mode   => 0755,
  }
  file { $puppet_update_sh:
    ensure => file,
    source => 'puppet:///modules/cron-puppet/puppet-update.sh',
    owner  => root,
    group  => root,
    mode   => 0755,
  }
}
