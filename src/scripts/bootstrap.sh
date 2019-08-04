#!/bin/sh

PATH="~/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
export PATH

# Set local time
cp /usr/share/zoneinfo/Europe/London /etc/localtime

# Install FreeBSD updates
/usr/sbin/freebsd-update --not-running-from-cron fetch && /usr/sbin/freebsd-update --not-running-from-cron install

# Install latests port-tree
/usr/sbin/portsnap fetch && /usr/sbin/portsnap extract && /usr/sbin/portsnap update && /usr/sbin/portsnap fetch update

# Remove all packages
pkg update
pkg remove -a --force -y

# Reinstall pkgng
cd /usr/ports/ports-mgmt/dialog4ports
make -DBATCH install clean

# Install libressl
cd /usr/ports/security/libressl
make -DBATCH install clean

# Install portmaster
cd /usr/ports/ports-mgmt/portmaster
make -DBATCH install clean

# Rebuild all ports
portmaster --clean-distfiles -y
env BATCH=yes; portmaster -G --no-confirm -afy

echo "PLEASE REBOOT TO REFRESH LIBRESSL"
exit 0

# Install portupgrade
cd /usr/ports/ports-mgmt/portupgrade
make -DBATCH install clean

##############################################################
# GNU TOOLING
##############################################################
#env BATCH=yes; portmaster -G --no-confirm -y base/binutils devel/autoconf devel/automake devel/gmake devel/gdb devel/libtool lang/gcc9

env BATCH=yes; portmaster -G --no-confirm -y base/binutils
env BATCH=yes; portmaster -G --no-confirm -y devel/autoconf
env BATCH=yes; portmaster -G --no-confirm -y devel/automake
env BATCH=yes; portmaster -G --no-confirm -y devel/gmake
env BATCH=yes; portmaster -G --no-confirm -y devel/gdb
env BATCH=yes; portmaster -G --no-confirm -y devel/libtool
env BATCH=yes; portmaster -G --no-confirm -y lang/gcc9

# portinstall --batch --yes base/binutils
# portinstall --batch --yes devel/autoconf devel/automake devel/gmake devel/gdb devel/libtool lang/gcc9
# portinstall --batch --yes devel/automake
# portinstall --batch --yes devel/gmake
# portinstall --batch --yes devel/gdb
# portinstall --batch --yes devel/libtool
# portinstall --batch --yes lang/gcc9

# cd /usr/ports/base/binutils
# make -DBATCH install clean

# cd /usr/ports/devel/gmake
# make -DBATCH install clean

# cd /usr/ports/devel/autoconf
# make -DBATCH install clean

# cd /usr/ports/devel/automake
# make -DBATCH install clean

# cd /usr/ports/devel/gdb
# make -DBATCH install clean

# cd /usr/ports/devel/libtool
# make -DBATCH install clean

# cd /usr/ports/lang/gcc9
# make -DBATCH install clean

export CC="gcc9"
export CXX="g++9"
export CPP="gcc9 -E"

echo 'export CC="gcc9"' | tee -a /root/.profile
echo 'export CXX="g++9"' | tee -a /root/.profile
echo 'export CPP="gcc9 -E"' | tee -a /root/.profile

##############################################################

env BATCH=yes; portmaster -G --no-confirm -y ftp/curl shells/zsh devel/git
#portinstall --batch --yes ftp/curl
#portinstall --batch --yes shells/zsh
#portinstall --batch --yes devel/git

# clean ports working directories, no longer referenced distfiles, outdated package file
portmaster --clean-distfiles -y
#portsclean -Di

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