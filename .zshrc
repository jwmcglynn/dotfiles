export DOTFILES_DIR=$(cd $(dirname $(realpath "$HOME/.zshrc")) && pwd)

# These includes must be in a specific order, with help them os utils.
source $DOTFILES_DIR/zsh/help.zsh
source $DOTFILES_DIR/zsh/os.zsh

# These includes are in sorted order.
source $DOTFILES_DIR/zsh/docker.zsh
source $DOTFILES_DIR/zsh/path.zsh
if [ "$(uname)" = "Darwin" ]; then
  source $DOTFILES_DIR/zsh/osx.zsh
fi

path_prepend $HOME/bin

##
## Set locale
##
# This prevents an "git_prompt_info:20: character not in range" error within the bullet-train
# prompt.  See https://github.com/caiogondim/bullet-train.zsh/issues/207
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##
## Set up oh-my-zsh
##

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

source $DOTFILES_DIR/third_party/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle git
antigen bundle command-not-found
antigen bundle z

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme "$DOTFILES_DIR/third_party/bullet-train" bullet-train

antigen apply

##
## Prompt
##
BULLETTRAIN_CONTEXT_DEFAULT_USER="jwm"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  BULLETTRAIN_IS_SSH_CLIENT=true
fi
BULLETTRAIN_EXEC_TIME_ELAPSED=0
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_PROMPT_ORDER=(
  time
  status
  custom
  context
  dir
  screen
  virtualenv
  rust
  git
  cmd_exec_time
)

##
## Set EDITOR
##
if [[ -o interactive ]]; then
  export EDITOR="code --wait --new-window"
else
  export EDITOR=vim
fi

##
## History
##
# Lots and lots of it.
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

# Allow tab completion in the middle of a word.
setopt COMPLETE_IN_WORD

##
## Navigation
##

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Help for commands not directly provided by zsh, but available as part
# of the dotfiles.
DOTFILES_COMMANDS["z dotfiles"]="Go to dotfiles dir."

DOTFILES_COMMANDS["git amend"]="Amend the last commit."
DOTFILES_COMMANDS["git publish"]="Push and publish branch."

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias codedf="code $DOTFILES_DIR"
DOTFILES_COMMANDS["codedf"]="Open the dotfiles dir file in vscode."

alias gitdf="git -C $DOTFILES_DIR"
DOTFILES_COMMANDS["gitdf"]="Run git on the dotfiles directory."

alias zshreload="exec zsh"
DOTFILES_COMMANDS["zshreload"]="Reload the zsh shell."

##
## Machine-specific configs
##

if ! is_docker; then
  if [ -f "$DOTFILES_DIR/.zshrc.$HOST" ]; then
    source "$DOTFILES_DIR/.zshrc.$HOST"
  fi
fi
