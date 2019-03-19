#!/bin/bash
if [ `id -u` -ne 0 ] ; then
       	echo You must be root.
   	exit
fi

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

export CURDIR=$(dirname $(readlink /proc/$$/fd/255))

chmod +x ${CURDIR}/sbin/*.sh

while [ -z ${select} ] ; do

    echo "[1] off selinux & yum repo update & set su group & set history & set rm alias & set sshd"
    echo "[2] off selinux & yum repo update & set su group & set history & set rm alias"
    echo -n ":"
    
    read select 
    case ${select} in
       1)
         ${CURDIR}/sbin/init_selinux.sh
         ${CURDIR}/sbin/init_sshd.sh
         ${CURDIR}/sbin/init_devel.sh
         ${CURDIR}/sbin/init_sysctl.sh
         ${CURDIR}/sbin/init_yum_7.sh
         ;;
       2)
         ${CURDIR}/sbin/init_selinux.sh
         ${CURDIR}/sbin/init_devel.sh
         ${CURDIR}/sbin/init_sysctl.sh
         ${CURDIR}/sbin/init_yum_7.sh
         ;;
       0)
         :
         ;;
       *)
        echo "Select from underside"
        unset select
        continue
        ;;
   
    esac

done

unset CURDIR
