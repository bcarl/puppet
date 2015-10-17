class users ($users, $groups, $ssh_keys) {
  create_resources(user, $users)
  create_resources(group, $groups)
  create_resources(ssh_authorized_key, $ssh_keys)
}
