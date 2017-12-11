class common {
  include cron-puppet
  include my_fw
  include my_mosh
  include my_packages
  include my_ssh
  include my_utc
  include sudo
  include tmux
  include users
}
