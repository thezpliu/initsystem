#!/bin/bash

#######################################################################################
#add groups
grep -q 1010 /etc/group || /usr/sbin/groupadd -g 1010 devel
grep -q 1011 /etc/group || /usr/sbin/groupadd -g 1011 editor

#add System Administrator lcsa
id -u sadmin    >/dev/null 2>&1 || /usr/sbin/useradd -c "System Administrator" -d /home/sadmin -u 600 -m -s /bin/bash -g wheel sadmin
/usr/sbin/usermod -a -G devel sadmin

#add comment users
id -u liuzp      >/dev/null 2>&1 || /usr/sbin/useradd  -c "Liu Zongping"   -d /home/liuzp       -m -s /bin/bash -g devel liuzp
/usr/sbin/usermod -G wheel liuzp
#######################################################################################
#dispose keys
temp=`mktemp`
cat <<EOF > $temp
test
EOF
for i in sadmin liuzp
do
    [ -d /home/$i/.ssh ] || mkdir /home/$i/.ssh
    grep $i $temp | awk -F"'" '{print $2}' > /home/$i/.ssh/authorized_keys
    chown -R `id -u $i`.`id -g $i` /home/$i/.ssh
    chmod 700 /home/$i/.ssh
    chmod 644 /home/$i/.ssh/authorized_keys
done

rm -f $temp
