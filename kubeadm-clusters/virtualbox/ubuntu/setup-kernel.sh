#!/bin/bash
#
# Sets up the kernel with the requirements for running Kubernetes
set -e

# Add br_netfilter kernel module otherwise it may face this error due to the bridge module missing its directory:
# "Failed to check br_netfilter: stat /proc/sys/net/bridge/bridge-nf-call-iptables: no such file or directory"
modprobe br_netfilter

# Set network tunables
cat <<EOF >> /etc/sysctl.d/10-kubernetes.conf
net.bridge.bridge-nf-call-iptables=1
net.ipv4.ip_forward=1
EOF

systemctl restart systemd-sysctl.service