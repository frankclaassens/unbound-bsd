########################################
# oh-my-zsh settings
########################################
PATH="/sbin:/bin:/usr/sbin:/usr/bin"
export PATH="$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH"
export ZSH="/root/.oh-my-zsh"

ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
HIST_STAMPS="mm/dd/yyyy"

#plugins=(git history common-aliases)

source $ZSH/oh-my-zsh.sh
########################################
# Environment Var
########################################
export MANPATH="/usr/local/man:$MANPATH"
export MACHINE_CPUARCH="amd64"
#export CC="gcc9"
#export CXX="g++9"
#export CPP="gcc9 -E"

########################################
# Aliases
########################################