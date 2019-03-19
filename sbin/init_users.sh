#!/bin/bash

#######################################################################################
#add groups
grep -q 1111 /etc/group || /usr/sbin/groupadd -g 1111 devel

#add System Administrator lcsa
id -u thezpliu    >/dev/null 2>&1 || /usr/sbin/useradd -c "System Administrator" -d /home/thezpliu -u 600 -m -s /bin/bash -g wheel thezpliu
/usr/sbin/usermod -a -G devel thezpliu

#add comment users
id -u liuzp      >/dev/null 2>&1 || /usr/sbin/useradd  -c "Liu Zongping"   -d /home/liuzp       -m -s /bin/bash -g devel liuzp
/usr/sbin/usermod -G wheel liuzp
#######################################################################################
#dispose keys
temp=`mktemp`
cat <<EOF > $temp
ssh-dss AAAAB3NzaC1kc3MAAACBAKGu6Jy8Y1xYwdFvUqDVeL3mM/5clN+stiBl9IYoHfZLVFhFe8/3H0CO6I+D/7ZNeNA9dtDK/Ph7u0UuqTeeR9xi/msvzGbY+RTMxIltaDm4V+95St6+dqW/2GKVlCDCe30ENenGpHD9AgCpOaN4iB5Z6syUPhsqxl8MdNQkfnwJAAAAFQDszmqOgr+mvKg96SUUyWIT2EiCXQAAAIBLIoZF04tokEiXFFGvZRL4wMaiGvjjaxadzLoUocNyyp9j92jgrMImSYQsKgX1Xb62gLMIurtI77ixhmuqOEUPfVuWjT26a7X1onVUSELzhPPgDEeAbf5FzoKBewd2hllN929oJ9XYnfeB6s9plq92NAj+kEK+iZy7r+jzOfE3uQAAAIBgNccOHm4L+fgHvp5NzUL4/bIa8349oZ0DhdgCiYIUzkijrVrfYkypa0+5AwAKxyfviFT2R2hXqShYv7zTjmLV7sbedlkoxfc5wOlnQPjOO9AXXX0/LhzYEGaP2CN9DaSyZmI4QasuANgA5FJbzQ0J7aI/iqTtm49S9Ov3khLqOA== root@test
EOF
for i in thezpliu liuzp
do
    [ -d /home/$i/.ssh ] || mkdir /home/$i/.ssh
    grep $i $temp | awk -F"'" '{print $2}' > /home/$i/.ssh/authorized_keys
    chown -R `id -u $i`.`id -g $i` /home/$i/.ssh
    chmod 700 /home/$i/.ssh
    chmod 644 /home/$i/.ssh/authorized_keys
done

rm -f $temp
