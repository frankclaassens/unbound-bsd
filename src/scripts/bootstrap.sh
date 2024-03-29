#!/bin/sh

PATH="~/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
export PATH

rm /root/.profile /home/dragon/.profile
rm /root/.login /home/dragon/.login

# Set local time
cp /usr/share/zoneinfo/Europe/London /etc/localtime

# Install FreeBSD updates
/usr/sbin/freebsd-update --not-running-from-cron fetch && /usr/sbin/freebsd-update --not-running-from-cron install

# Install latests port-tree
/usr/sbin/portsnap fetch && /usr/sbin/portsnap extract && /usr/sbin/portsnap update && /usr/sbin/portsnap fetch update

# Remove all packages
pkg delete -a --force -y

# Reinstall pkgng
make -DBATCH -C /usr/ports/ports-mgmt/pkg install clean
make -DBATCH -C /usr/ports/ports-mgmt/dialog4ports install clean

# Install portmaster
make -DBATCH -C /usr/ports/ports-mgmt/portmaster install clean

# Rebuild all ports
rehash
portmaster --clean-distfiles -y
env BATCH=yes; portmaster --no-confirm -y ports-mgmt/dialog4ports
pkg update -f

# Install libressl
env BATCH=yes; portmaster -G --no-confirm -y security/libressl

##############################################################
# GNU TOOLING
##############################################################
env BATCH=yes; portmaster -G --no-confirm -y devel/gmake
env BATCH=yes; portmaster -G --no-confirm -y devel/autoconf
env BATCH=yes; portmaster -G --no-confirm -y devel/automake
env BATCH=yes; portmaster -G --no-confirm -y devel/binutils
env BATCH=yes; portmaster -G --no-confirm -y devel/libtool
env BATCH=yes; portmaster -G --no-confirm -y lang/gcc9

export CC="gcc9"
export CXX="g++9"
export CPP="gcc9 -E"

echo 'setenv  CC   gcc9' | tee -a /root/.cshrc
echo 'setenv  CXX  g++9' | tee -a /root/.cshrc
echo 'setenv  CPP  "gcc9 -E"' | tee -a /root/.cshrc

echo 'setenv  CC   gcc9' | tee -a /home/dragon/.cshrc
echo 'setenv  CXX  g++9' | tee -a /home/dragon/.cshrc
echo 'setenv  CPP  "gcc9 -E"' | tee -a /home/dragon/.cshrc

##############################################################

# Install OPEN_NTPD
env BATCH=yes; portmaster -G --no-confirm -y net/openntpd
echo 'ntpd_enable="NO"' | tee -a /etc/rc.conf
echo 'openntpd_enable="YES"' | tee -a /etc/rc.conf
echo 'openntpd_flags="-s"' | tee -a /etc/rc.conf
service ntpd onestop
service openntpd start
###### END ######

# Install OPENSSH-PORTABLE
env BATCH=yes; portmaster -G --no-confirm -y security/openssh-portable
echo 'sshd_enable="NO"' | tee -a /etc/rc.conf
echo 'openssh_enable="YES"' | tee -a /etc/rc.conf
cp /tmp/sshd_config /usr/local/etc/ssh/sshd_config
#service sshd stop
#service openssh start
###### END ######

##############################################################
# Configure oh-my-zsh
##############################################################
env BATCH=yes; portmaster -G --no-confirm -y ftp/curl
env BATCH=yes; portmaster -G --no-confirm -y shells/zsh
env BATCH=yes; portmaster -G --no-confirm -y devel/git

# Configure oh-my-zsh => root
rehash
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

echo "ALL DONE!! PLEASE REBOOT TO REFRESH LIBRESSL"