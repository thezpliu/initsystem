#!/bin/bash

grep -q SELINUX=disabled /etc/sysconfig/selinux || sed -i '/^SELINUX=enforcing/aSELINUX=disabled' /etc/sysconfig/selinux
sed -i 's/^SELINUX=enforcing/#SELINUX=enforcing/g' /etc/sysconfig/selinux
grep -q SELINUX=disabled /etc/selinux/config || sed -i '/^SELINUX=enforcing/aSELINUX=disabled' /etc/selinux/config
sed -i 's/^SELINUX=enforcing/#SELINUX=enforcing/g' /etc/selinux/config
/usr/sbin/setenforce 0
cat /etc/selinux/config | grep -v "^#" | grep SELINUX
echo "------------------------ 1), selinux set up done ------------------------" 
