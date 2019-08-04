#!/bin/sh

# Install FreeBSD updates
/usr/sbin/freebsd-update fetch && /usr/sbin/freebsd-update install

# Install latests port-tree
/usr/sbin/portsnap fetch && /usr/sbin/portsnap extract && /usr/sbin/portsnap fetch update

# Remove all packages
pkg remove -a -y

env ASSUME_ALWAYS_YES=YES pkg install libressl
env ASSUME_ALWAYS_YES=YES pkg install binutils
env ASSUME_ALWAYS_YES=YES pkg install ftp/curl
env ASSUME_ALWAYS_YES=YES pkg install shells/zsh
env ASSUME_ALWAYS_YES=YES pkg install devel/git

# Install oh-my-zsh
chsh -s /usr/local/bin/zsh dragon
su - dragon -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended'

##############################################################
# GNU TOOLING
##############################################################
#portinstall gcc -y
#portinstall binutils -y
#portinstall gdb -y
#portinstall libgcc -y





##############################################################