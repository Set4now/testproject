#!/bin/bash
#this will start the salt services and all other dependencies services for this container
LOG_LEVEL=${LOG_LEVEL:-"info"}
/etc/init.d/sshd start
/etc/init.d/salt-minion start
sleep 20
salt-call --local tls.create_self_signed_cert
/etc/init.d/salt-api start
# Run Salt as a Deamon
/usr/bin/salt-master --log-level=$LOG_LEVEL
