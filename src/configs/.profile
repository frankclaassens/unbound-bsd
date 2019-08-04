# $FreeBSD: releng/12.0/bin/sh/dot.profile 338374 2018-08-29 16:59:19Z brd $
#
PATH=~/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export PATH

HOME=/root
export HOME

TERM=${TERM:-xterm}
export TERM

PAGER=less
export PAGER

MACHINE_CPUARCH=amd64
export MACHINE_CPUARCH

#export CC="gcc9"
#export CXX="g++9"
#export CPP="gcc9 -E"

# Query terminal size; useful for serial lines.
if [ -x /usr/bin/resizewin ] ; then /usr/bin/resizewin -z ; fi

# Uncomment to display a random cookie on each login.
# if [ -x /usr/bin/fortune ] ; then /usr/bin/fortune -s ; fi