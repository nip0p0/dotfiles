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

# # Use viins keymaps
bindkey -v
bindkey "^R" history-incremental-search-backward

# Initialize rbenv
eval "$(rbenv init -)"

# Inisialize nvm
nvm() {
	# unset nvm
	unset -f nvm

	# load nvm.sh
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

source $HOME/.zplug/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

zplug "b4b4r07/zsh-vimode-visual", \
	use:"*.zsh"

zplug "junegunn/fzf-bin", \
	as:command, \
	from:gh-r, \
	rename-to:fzf

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

# Then, source plugins
zplug load

# get vcs_info with thi function
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# call vsc_info and open tab in the same directory
precmd () {
	vcs_info
	print -Pn "\e]2; %~/ \a"
}

preexec () {
	print -Pn "\e]2; %~/ \a"
}

PROMPT='%{$fg[cyan]%}%~:%{$reset_color%}'
PROMPT=$PROMPT'${vcs_info_msg_0_} %{${fg[cyan]}%}%}$%{${reset_color}%} '
