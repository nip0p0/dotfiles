autoload -Uz compinit
compinit -C

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
nvm() {
	# unset nvm
	unset -f nvm

	# load nvm.sj
	source "${NVM_DIR:-$HOME/.nvm}/nvm.sh"
	if [[ -s ~/.nvm/nvm.sh ]];
	  then source ~/.nvm/nvm.sh
	fi

	# Pass true args
	nvm "$@"
}

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

# Antigen settings
source $(brew --prefix)/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen-use oh-my-zsh

antigen-bundle git
antigen-bundle sudo
antigen-bundle command-not-found

antigen-bundle b4b4r07/emoji-cli
antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-completions

# Load the theme.
antigen-theme robbyrussell

# Tell antigen that you're done.
antigen-apply
