#!/bin/bash

SSHD_CONFIG=/etc/ssh/sshd_config

## deny Password Authentication
if grep -q "^PasswordAuthentication.*no" ${SSHD_CONFIG}; then
		:	
	else
        	grep -q "^PasswordAuthentication.*yes" ${SSHD_CONFIG} && sed -i '/^PasswordAuthentication.*yes/s/yes/no/' ${SSHD_CONFIG} || sed -i '/^#PasswordAuthentication/a\PasswordAuthentication no' ${SSHD_CONFIG}
fi

## Deny PermitRootLogin

if [ -f /home/sadmin/.ssh/authorized_keys ] ; then
        if grep -q "^PermitRootLogin.*no" ${SSHD_CONFIG} ; then
			:
		else
			grep -q "^PermitRootLogin.*yes" ${SSHD_CONFIG} && sed -i '/^PermitRootLogin.*yes/s/yes/no/' ${SSHD_CONFIG} || sed -i '/^#PermitRootLogin.*/aPermitRootLogin no' ${SSHD_CONFIG}
        fi
else
        echo "###########################################"
        echo "      The ddlsa is not exist.              "
        echo "The PermitRootLogin Option does not be set "
        echo "###########################################"
fi


if [ -f /etc/debian_version ] ; then
        /etc/init.d/ssh reload
    else
        /etc/init.d/sshd reload
fi
