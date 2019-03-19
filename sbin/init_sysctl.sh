#!/bin/bash
echo 'vm.overcommit_memory=1' >> /etc/sysctl.conf
echo 'fs.file-max=655350' >> /etc/sysctl.conf
echo 'vm.swappiness=0' >> /etc/sysctl.conf

echo 'kernel.msgmnb = 65536' >> /etc/sysctl.conf
echo 'kernel.msgmax = 65536' >> /etc/sysctl.conf
echo 'kernel.shmmax = 68719476736' >> /etc/sysctl.conf
echo 'kernel.shmall = 4294967296' >> /etc/sysctl.conf

echo 'net.ipv4.conf.default.rp_filter=0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.rp_filter=0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.eth0.rp_filter=0' >> /etc/sysctl.conf

echo 'net.core.wmem_max=12582912' >> /etc/sysctl.conf
echo 'net.core.rmem_max=12582912' >> /etc/sysctl.conf
echo 'net.core.wmem_default=8388608' >> /etc/sysctl.conf
echo 'net.core.rmem_default=8388608' >> /etc/sysctl.conf
echo 'net.core.netdev_max_backlog=5000' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_mem=10240 87380 12582912' >> /etc/sysctl.conf 
echo 'net.ipv4.tcp_rmem=10240 87380 12582912' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_wmem=10240 87380 12582912' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_window_scaling=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_timestamps=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_sack=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_fack=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_no_metrics_save=1' >> /etc/sysctl.conf

echo 'net.ipv4.ip_local_port_range=2000 65535' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_fin_timeout=20' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_tw_reuse=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_max_tw_buckets=10000' >> /etc/sysctl.conf

echo 'net.ipv4.tcp_max_syn_backlog=200000' >> /etc/sysctl.conf
echo 'net.core.somaxconn=200000' >> /etc/sysctl.conf
sysctl -p
echo "------------------------ 4), set up sysctl done -------------------------"
