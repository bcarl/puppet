#!/bin/bash
BOOTSTRAP="/root/bootstrap.sh"
wget -qO $BOOTSTRAP "https://raw.githubusercontent.com/bcarl/puppet/master/bootstrap.sh"
chmod +x $BOOTSTRAP
$BOOTSTRAP
