if [  -a ~/.bashrc ]; then
  source ~/.bashrc
fi

source ~/.bashrc.common

if [ `uname` = "Darwin" ]; then
	 . ~/.bashrc.osx
elif [ `uname` = "Linux" ]; then
	 . ~/.bashrc.linux
fi
function aws_account_info {
  [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo -n "aws:($AWS_ACCOUNT_NAME:$AWS_ACCOUNT_ROLE) "
}

if type __git_ps1 > /dev/null 2>&1 ; then
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\[\033[01;34m\]$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
else
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\$\[\033[00m\] '
fi

PROMPT_COMMAND='aws_account_info'

[[ -n "$VIMRUNTIME" ]] && export PS1="(vim)$PS1"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
