# $FreeBSD: releng/12.0/bin/csh/dot.cshrc 338374 2018-08-29 16:59:19Z brd $
#
# .cshrc - csh resource script, read at beginning of execution by each shell
#
# see also csh(1), environ(7).
# more examples available at /usr/share/examples/csh/
#

umask 22

# An interactive shell?
if ($?prompt) then

        set prompt="${green}%n@%m${blue}:%~ ${white}%#${end} "
        set promptchars = "%#"

        set filec
        set history = 20000
        set savehist = (20000 merge)
        set autolist = ambiguous
        set complete = 'enhance'
        set autoexpand
        set autorehash
        set mail = (/var/mail/$USER)

        if ( $?tcsh ) then
                bindkey "^W" backward-delete-word
                bindkey -k up history-search-backward
                bindkey -k down history-search-forward
        endif

        unset red green yellow blue magenta cyan yellow white end
endif

#setenv  CC      gcc9
#setenv  CXX     g++9
#setenv  CPP     "gcc9 -E"