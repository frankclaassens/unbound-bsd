# $FreeBSD: releng/12.0/bin/csh/csh.cshrc 337849 2018-08-15 14:41:24Z brd $
#
# System-wide .cshrc file for csh(1).

#########################################################
#                       Colors!
#########################################################
set red = "%{\033[1;31m%}"
set green = "%{\033[0;32m%}"
set blue = "%{\033[1;34m%}"
set white = "%{\033[0;37m%}"
set red = "%{\033[1;31m%}"
set magenta = "%{\033[1;35m%}"
set end = "%{\033[0m%}" # This is needed at the end... :(
#########################################################

set path = ($HOME/bin /usr/local/bin /usr/local/sbin /bin /sbin /usr/bin /usr/sbin)

alias h         history 25
alias j         jobs -l
alias la        ls --color=always -aF
alias lf        ls --color=always -FA
alias ll        ls --color=always -lAFh
alias l         ls --color=always -lah
alias ls        ls --color=always

setenv  EDITOR          vi
setenv  PAGER           less
setenv  BLOCKSIZE       K
setenv  CLICOLOR        1
setenv  LSCOLORS        ExGxFxdxCxDxDxBxBxExEx
setenv  MACHINE_CPUARCH amd64
setenv  MACHTYPE        x86_64

set color
set colorcat