# Configure networking #
###
echo 'Setting static IP address for Hyper-V...'
cat << EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - $1/24
      gateway4: 192.168.1.1
      dhcp6: false
      nameservers:
          addresses: [8.8.8.8, 4.4.4.4]
EOF

echo "sleep 90 && sudo netplan apply" >> /root/script.sh
chmod +x /root/script.sh
nohup /root/script.sh &
###



