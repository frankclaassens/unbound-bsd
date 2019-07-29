#!/bin/sh

# Install FreeBSD updates
/usr/sbin/freebsd-update fetch && /usr/sbin/freebsd-update install

# Install latests port-tree
/usr/sbin/portsnap fetch && /usr/sbin/portsnap extract && /usr/sbin/portsnap fetch update

# Remove all packages
pkg remove -a -y

# Install portmaster
pkg install portmaster -y




