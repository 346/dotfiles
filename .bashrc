# ゆーてぃーえふえいとだよっ
if [ "`hostname -s`" = "Takahiro-no-MacBook-Pro.local" ]; then
	 . ~/.bashrc.mbp2nd
elif [ "`hostname -s`" = "takahiro-no-MacBook-Pro" ]; then
	 . ~/.bashrc.trifort.mbp
fi

if [ `uname` = "Darwin" ]; then
	 . ~/.bashrc.osx
elif [ `uname` = "Linux" ]; then
	 . ~/.bashrc.linux
fi

export HISTSIZE=2000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups
export PS1="[\u@\h \W]\\$ "

