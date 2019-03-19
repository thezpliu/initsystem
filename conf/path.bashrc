PS1="`whoami`@`hostname`:"'[$PWD]'
USER_IP=`who -u am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'`
if [ "$USER_IP" = "" ]
then
USER_IP=`hostname`
fi
if [ ! -d /tmp/history ]
then
mkdir /tmp/history
chmod 777 /tmp/history
fi
if [ ! -d /tmp/history/${LOGNAME} ]
then
mkdir /tmp/history/${LOGNAME}
chmod 300 /tmp/history/${LOGNAME}
fi
export HISTSIZE=50000
DT=`date +"%Y%m%d_%H%M%S"`
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTFILE="/tmp/history/${LOGNAME}/history.$DT.$USER_IP"
chmod 600 /tmp/history/${LOGNAME}/history* 2>/dev/null
alias rm='/bin/rm.py'
export LANG=en_US.UTF-8
