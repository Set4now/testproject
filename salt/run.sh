#!/bin/bash
#this will start the salt services and all other dependencies services for this container
LOG_LEVEL=${LOG_LEVEL:-"info"}
/usr/bin/ssh-keygen -A

/usr/bin/salt-minion -d
if [ $? -ne 0];then
echo "salt minion service failed"
exit 1
fi
sleep 20
salt-call --local tls.create_self_signed_cert
#/etc/init.d/salt-api start
# Run Salt as a Deamon
/usr/bin/salt-master -d --log-level=$LOG_LEVEL
if [ $? -ne 0];then
echo "salt master service failed"
exit 1
fi
ps -ef | grep -i salt-master | grep -v grep
exit_status_salt-master=$?
ps -ef | grep -i salt-minion | grep -v grep
exit_status_salt-minion=$?
if [ exit_status_salt-master -ne 0 -o exit_status_salt-minion -ne 0 ];then
echo "One of the process exited"
exit -1
fi
/usr/sbin/sshd -D
if [ $? -ne 0];then
echo "sshd service failed"
exit 1
fi

