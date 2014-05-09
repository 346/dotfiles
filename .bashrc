# ゆーてぃーえふえいとだよっ
if [ "`hostname -s`" = "Takahiro-no-MacBook-Pro" ]; then
	 . ~/.bashrc.mbp2nd
# elif [ "`hostname -s`" = "takahiro-no-MacBook-Pro" ]; then
fi

if [ `uname` = "Darwin" ]; then
	 . ~/.bashrc.osx
elif [ `uname` = "Linux" ]; then
	 . ~/.bashrc.linux
fi

export HISTSIZE=2000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups

if type __git_ps1 > /dev/null 2>&1 ; then
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\[\033[01;34m\]$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
else
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\$\[\033[00m\] '
fi

export LESS="-eirMX"
eval "$(direnv hook bash)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

