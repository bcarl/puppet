class common {
  include cron-puppet
  include my_fw
  include my_packages
  include my_ssh
  include my_utc
  include sudo
  include users
}
