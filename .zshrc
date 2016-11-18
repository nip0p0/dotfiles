# Set Env variables
export LANG=ja_JP.UTF-8
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export GOPATH="${HOME}/.go"
export PGDATA=/usr/local/var/postgres
export EMOJI_CLI_KEYBIND="^b"
export XDG_CONFIG_HOME=$HOME/.nvim
export PATH="/usr/local/sbin:$PATH"

# Initialize rbenv
eval "$(rbenv init -)"

# Inisialize nvm
if [[ -s ~/.nvm/nvm.sh ]];
  then source ~/.nvm/nvm.sh
fi

# Initialize pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
  export PATH=${PYENV_ROOT}/bin:$PATH
  eval "$(pyenv init -)"
fi

# Set alias
alias gco="git checkout"
alias gst="git status"
alias gci="git commit -a"
alias gdi="git diff"
alias gbr="git branch"
alias be='bundle exec'
alias rs='rails s'
alias -g G='| grep'

# Zgen settings
source "${HOME}/.zgen/zgen.zsh"
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=lightblue

# Zgen plugins
if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh themes/af-magic

  zgen load "b4b4r07/emoji-cli"
  zgen load "zsh-users/zsh-syntax-highlighting"
  zgen load "zsh-users/zsh-completions"

  zgen save
fi
