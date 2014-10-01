if [  -a ~/.bashrc ]; then
  source ~/.bashrc
fi

source ~/.bashrc.common

if [ `uname` = "Darwin" ]; then
	 . ~/.bashrc.osx
elif [ `uname` = "Linux" ]; then
	 . ~/.bashrc.linux
fi

if type __git_ps1 > /dev/null 2>&1 ; then
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\[\033[01;34m\]$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
else
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\$\[\033[00m\] '
fi


