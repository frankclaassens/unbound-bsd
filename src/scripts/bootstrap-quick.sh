#!/bin/sh

# Install FreeBSD updates
/usr/sbin/freebsd-update fetch && /usr/sbin/freebsd-update install

# Install latests port-tree
/usr/sbin/portsnap fetch && /usr/sbin/portsnap extract && /usr/sbin/portsnap fetch update

# Remove all packages
pkg remove -a -y

# Install libressl
env ASSUME_ALWAYS_YES=YES pkg install libressl

##############################################################
# GNU TOOLING
##############################################################
env ASSUME_ALWAYS_YES=YES pkg install binutils
env ASSUME_ALWAYS_YES=YES pkg install gmake
env ASSUME_ALWAYS_YES=YES pkg install autoconf
env ASSUME_ALWAYS_YES=YES pkg install automake
env ASSUME_ALWAYS_YES=YES pkg install gdb
env ASSUME_ALWAYS_YES=YES pkg install libtool
env ASSUME_ALWAYS_YES=YES pkg install gcc9

#echo "USE_GCC=gcc9" | tee -a /etc/make.conf

export CC="gcc9"
export CXX="g++9"
export CPP="gcc9 -E"

rm -rf /root/.profile
cp /tmp/.profile /root/.profile

#portinstall gmake binutils gdb autoconf automake libtool gcc9 -y
##############################################################

# Install portmaster
env ASSUME_ALWAYS_YES=YES pkg install portmaster

# Upgrade and rebuild all ports
portmaster --clean-distfiles -y
portmaster -af

# Install portupgrade
env ASSUME_ALWAYS_YES=YES pkg install portupgrade

# clean ports working directories, no longer referenced distfiles, outdated package file
portsclean -Di

env ASSUME_ALWAYS_YES=YES pkg install ftp/curl
env ASSUME_ALWAYS_YES=YES pkg install shells/zsh
env ASSUME_ALWAYS_YES=YES pkg install devel/git

# Configure oh-my-zsh => root
chsh -s /usr/local/bin/zsh root
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
rm -rf /root/.zshrc
cp /tmp/.zshrc /root/.zshrc

# Configure oh-my-zsh => dragon
chsh -s /usr/local/bin/zsh dragon
su - dragon -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended'
rm -rf /home/dragon/.zshrc
cp /tmp/.zshrc /home/dragon/.zshrc
chown dragon:dragon /home/dragon/.zshrc