#!/bin/bash

SSH_PORT=38199
SSHD_CONFIG=/etc/ssh/sshd_config

## deny Password Authentication
#if grep -q "^PasswordAuthentication.*no" ${SSHD_CONFIG}; then
#		:	
#	else
#        	grep -q "^PasswordAuthentication.*yes" ${SSHD_CONFIG} && sed -i '/^PasswordAuthentication.*yes/s/yes/no/' ${SSHD_CONFIG} || sed -i '/^#PasswordAuthentication/a\PasswordAuthentication no' ${SSHD_CONFIG}
#fi

## Deny PermitRootLogin

if grep -q "^PermitRootLogin.*no" ${SSHD_CONFIG} ; then
			:
else
    grep -q "^PermitRootLogin.*yes" ${SSHD_CONFIG} && sed -i '/^PermitRootLogin.*yes/s/yes/no/' ${SSHD_CONFIG} || sed -i '/^#PermitRootLogin.*/aPermitRootLogin no' ${SSHD_CONFIG}
fi

if grep -q "^Port.*${SSH_PORT}" ${SSHD_CONFIG} ; then
			:
else
    grep -q "^Port.*22" ${SSHD_CONFIG} && sed -i "/^Port.*22/s/22/${SSH_PORT}/g"  ${SSHD_CONFIG} || sed -i "/^#Port.*22/aPort ${SSH_PORT}" ${SSHD_CONFIG}
fi


if grep -q "^UseDNS.*no" ${SSHD_CONFIG} ; then
			:
else
    grep -q "^UseDNS.*yes" ${SSHD_CONFIG} && sed -i "/^UseDNS.*yes/s/yes/no/g"  ${SSHD_CONFIG} || sed -i "/^#UseDNS.*yes/aUseDNS no" ${SSHD_CONFIG}
fi

if [ -f /etc/debian_version ] ; then
        /etc/init.d/ssh reload
    else
        systemctl reload sshd
fi
