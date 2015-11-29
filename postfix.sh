#!/usr/bin/env bash

/opt/postfix-configure-sasl.sh

# exit cleanly
trap "{ /usr/sbin/service postfix stop; }" EXIT

/usr/sbin/service postfix start

tail -f /var/log/mail.log

# don't exit
sleep infinity
