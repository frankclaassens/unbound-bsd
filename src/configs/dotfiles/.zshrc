########################################
# oh-my-zsh settings
########################################
export ZSH="$HOME/.oh-my-zsh"

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=999999
SAVEHIST=999999

ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(git history common-aliases)

source $ZSH/oh-my-zsh.sh

###############################################################################
############################## User Configuration #############################
###############################################################################

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export LS_OPTIONS='--color=always'

export CC="gcc9"
export CXX="g++9"
export CPP="gcc9 -E"

########################################
# Aliases
########################################

# Display the list of packages which require pkg-name
alias d-pkg-requiredby="pkg info -rx"

# Display the list of packages on which pkg-name depends.
alias d-pkg-package-deps="pkg info -dF"