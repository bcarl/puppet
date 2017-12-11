node /^dev[\.-].*$/ {
  include common
  include my_sites
}

node default {
  include common
}
