#!/bin/bash
#this will start the salt services and all other dependencies services for this container
LOG_LEVEL=${LOG_LEVEL:-"info"}
/usr/bin/ssh-keygen -A
/usr/sbin/sshd -D
/usr/bin/salt-minion
sleep 20
salt-call --local tls.create_self_signed_cert
#/etc/init.d/salt-api start
# Run Salt as a Deamon
/usr/bin/salt-master --log-level=$LOG_LEVEL
