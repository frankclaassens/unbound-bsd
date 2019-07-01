#!/bin/sh
# install beadm and create new boot environment hbsd and mount it at /mnt
pkg install -y beadm
beadm create hbsd
beadm mount hbsd /mnt

# fetch latest HBSD base and kernel - will be hbsd-update'd later
cd /tmp
fetch https://installer.hardenedbsd.org/pub/HardenedBSD/releases/amd64/amd64/hardenedbsd-12-stable-LAST/ftp/base.txz
fetch https://installer.hardenedbsd.org/pub/HardenedBSD/releases/amd64/amd64/hardenedbsd-12-stable-LAST/ftp/kernel.txz

# extract base and kernel to our hbsd boot environment
cd /mnt
chflags -R noschg /mnt
tar xf /tmp/base.txz
tar xf /tmp/kernel.txz

# copy some config files to our hbsd boot environment
cp /etc/*passwd* /mnt/etc/
cp -r /etc/group /mnt/etc/
cp -r /etc/login* /mnt/etc/
cp -r /etc/ssh /mnt/etc/

# without loader.conf beadm does not let us activate our hbsd boot environment
# while at it: include 30s delay to choose boot environment - DO's virtual console can take some time to start
echo "autoboot_delay=30" >> /mnt/boot/loader.conf

# run a few commands at first HBSD boot
# re-create password db in correct format
echo "/usr/sbin/pwd_mkdb -p /etc/master.passwd">>/mnt/etc/rc.local

# force upgrade of all pkg from HBSD pkg repo
echo "/usr/local/sbin/pkg-static update -f">>/mnt/etc/rc.local
echo "/usr/local/sbin/pkg-static clean -ay">>/mnt/etc/rc.local
echo "/usr/local/sbin/pkg-static upgrade -yf">>/mnt/etc/rc.local
echo "hbsd-update">>/mnt/etc/rc.local

# delete rc.local - we need it only at first run
echo "echo 'rm /etc/rc.local' > /etc/rc.local">>/mnt/etc/rc.local
echo "shutdown -r now">>/mnt/etc/rc.local

# make rc.local executable
chmod +x /mnt/etc/rc.local

# make sure our new base system has the correct uid:gid
chown -R root:wheel /mnt

# almost done: activate our hbsd boot enviroment and reboot
cd /
beadm activate hbsd
shutdown -r now