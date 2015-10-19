class common {
  include bash
  include cron-puppet
  include git
  include my_fw
  include my_ssh
  include my_utc
  include '::ntp'
  include sudo
  include users
}
