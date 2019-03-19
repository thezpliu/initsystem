#!/bin/bash
export CONF=$CURDIR/conf
SU_CONFIG=/etc/pam.d/su
BASH_CONFIG=/etc/bashrc
chmod +x /etc/rc.d/rc.local
if grep -q "\#auth.*required.*pam_wheel.so.*use_uid" ${SU_CONFIG}; then
   /bin/sed -i 's/^#auth.*required.*pam_wheel.so.*use_uid/auth            required        pam_wheel.so use_uid/g' ${SU_CONFIG}
fi
cat /etc/pam.d/su | grep -v '^#' | grep 'auth' | grep 'use_uid'
echo "------------------------ 2), enable wheel group done --------------------"
/bin/cp -f $CONF/ld.so.conf /etc
/sbin/ldconfig
if [ ! -f /bin/rm.py ]; then
    cat $CONF/path.bashrc >> /etc/bashrc
    mkdir /data/Recycle -p
    mkdir /opt/scripts/ -p
    /bin/cp -f $CONF/rm.py /bin/
    /bin/cp -f $CONF/clean_recycle.sh /opt/scripts/
    /bin/chmod 755 /bin/rm.py
    /bin/chmod 777 /data/Recycle
    /usr/bin/chattr +i /bin/rm.py
    /usr/bin/chattr +i /opt/scripts/clean_recycle.sh
    source /etc/bashrc
    echo '0 5 * * 6 root /opt/scripts/clean_recycle.sh' >> /etc/crontab
    echo '0 1 * * * root /usr/sbin/ntpdate cn.ntp.org.cn' >> /etc/crontab
fi
unset CONF
ls -al /bin/rm.py
echo "------------------------ 3), rewrite rm command done --------------------"
