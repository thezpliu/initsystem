#!/bin/bash
CONF=${CURDIR}/conf
DATE=`date +%Y%m%d%H%M%S`
yumupdate_flag=0
rpm --quiet -q wget || yum -y install wget >/dev/null 2>&1
if [ "$?" -ne 0 ]
	then 
	echo wget install faild , yum repo dont update.
	exit 1
fi
if [ -e /etc/yum.repos.d/CentOS-Base.repo ]
	then
	echo "CentOS-Base.repo exist"
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.${DATE}.bak
fi
if [ ! -f /etc/yum.repos.d/CentOS7-Base-163.repo ]
	then
	wget http://mirrors.aliyun.com/repo/Centos-7.repo -O /etc/yum.repos.d/Centos-7.repo >/dev/null 2>&1 || wget http://mirrors.163.com/.help/CentOS7-Base-163.repo -O /etc/yum.repos.d/CentOS-7.repo >/dev/null 2>&1
fi
rpm -Uvh http://centos.ustc.edu.cn/epel/epel-release-latest-7.noarch.rpm >/dev/null 2>&1
if [[ -f /etc/yum.repo.d/Centos-7.repo  ]]
    then
    if [[ -f /etc/yum.repo.d/epel.repo ]]
        then
	    yum clean all
	    yum makecache && yum -y install lrzsz libxml* libjpeg* psmisc sysstat ntp vim-enhanced gcc gcc-c++ autoconf automake glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel libtool* zlib-devel libxml2-devel libjpeg-devel libpng-devel libtiff-devel fontconfig-devel freetype-devel libXpm-devel curl curl-devel pam-devel openssl openssl-devel net-snmp net-snmp-devel cpan git tcpdump 
    else
        echo "wget epel.repo error"
    fi
else
    echo "wget Centos-7.repo error"
fi
unset CONF
unset DATE
