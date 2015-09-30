#!/usr/bin/env bash

/opt/postfix-configure-sasl.sh

# exit cleanly
trap "{ /usr/sbin/service postfix stop; }" EXIT

/usr/sbin/service postfix start

# don't exit
sleep infinity
