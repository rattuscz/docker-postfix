#!/bin/bash

#configure maildomain from ENV
postconf -e myhostname=$maildomain

# sasldb2 - create from ENV users and maildomain
echo $smtp_user | tr , \\n > /tmp/passwd
while IFS=':' read -r _user _pwd; do
  echo $_pwd | saslpasswd2 -p -c -u $maildomain $_user
done < /tmp/passwd
chown postfix.sasl /etc/sasldb2
