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

source $HOME/.zplug/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"
zplug 'zsh-users/zsh-autosuggestions'
zplug "zsh-users/zsh-syntax-highlighting", nice:10

zplug "b4b4r07/zsh-vimode-visual", \
	    use:"*.sh"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

# Then, source plugins
zplug load

# VCSの情報を取得するzsh関数
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }

# プロンプト（左）
PROMPT='%{$fg[cyan]%}%~:%{$reset_color%}'
PROMPT=$PROMPT'${vcs_info_msg_0_} %{${fg[cyan]}%}%}$%{${reset_color}%} '
