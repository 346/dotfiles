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
if [ ${TERM_PROGRAM} = "vscode" ]; then
  # tab name
  echo -ne "\033]0;$(basename $(pwd))\007"

  # monorepo
  MONOREPO_ROOT=`(cd ../ && pwd | xargs basename)`
  export PS1='\[\033[01;33m\] $MONOREPO_ROOT * \W\[\033[01;34m\]$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
elif type __git_ps1 > /dev/null 2>&1 ; then
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w\[\033[01;34m\]$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
else
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\$\[\033[00m\] '
fi

PROMPT_COMMAND='aws_account_info'

[[ -n "$VIMRUNTIME" ]] && export PS1="(vim)$PS1"


# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# pg9.6
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
