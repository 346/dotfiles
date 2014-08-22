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

ssh() {
  # Host-specific background colors.
  if [[ "$@" =~ ^pro.* ]]; then
  set_term_bgcolor 127 0 0
  elif [[ "$@" =~ ^stg.* ]]; then
    set_term_bgcolor 0 100 0
  elif [[ "$@" =~ ^dev.* ]]; then
    set_term_bgcolor 0 0 100
  elif [[ "$@" =~ ^dep.* ]]; then
    set_term_bgcolor 127 127 0
  fi
   
  command ssh $@
   
  set_term_bgcolor 0 0 0
}
set_term_bgcolor() {
   local R=$1
   local G=$2
   local B=$3
   # /usr/bin/osascript <<EOF
# tell application "Terminal"
   # tell window 0
      # set the background color to {$(($R*65535/255)), $(($G*65535/255)), $(($B*65535/255))}
   # end tell
# end tell
# EOF
  /usr/bin/osascript <<EOF
tell application "iTerm"
  tell the current terminal
    tell the current session
      set background color to {$(($R*65535/255)), $(($G*65535/255)), $(($B*65535/255))}
    end tell
  end tell
end tell
EOF
}
 
export LESS="-eirMX"
eval "$(direnv hook bash)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

