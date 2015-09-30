#!/bin/bash

/opt/postfix-configure-sasl.sh
service postfix start
# tail -f /var/log/mail.log
