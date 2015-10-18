node 'dev.bcarl.me' {
  include common
  include my_nginx
}

node default {
  include common
}
