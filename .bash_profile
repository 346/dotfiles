if [  -a ~/.bashrc ]; then
  source ~/.bashrc
fi

source ~/.bashrc.common

if [ `uname` = "Darwin" ]; then
	 . ~/.bashrc.osx
elif [ `uname` = "Linux" ]; then
	 . ~/.bashrc.linux
fi
function env_color {
  if [[ $1 =~ \-prod$ ]]; then
    COLOR="\[\e[91m\]"
  elif [[ $1 =~ \-dev$ ]]; then
    COLOR="\[\e[92m\]"
  elif [[ $1 =~ \-stg$ ]]; then
    COLOR="\[\e[93m\]"
  else
    COLOR="\[\e[95m\]"
  fi
  echo -ne "${COLOR}"
}
function prompt_command {
  local EMOJI_DEV=""
  local EMOJI_STG=""
  local EMOJI_PROD=""
  local EMOJI_PULUMI=""
  local EMOJI_AWS=""
  local RESET="\[\e[0m\]"
  # pwd
  local DIR="\[\e[1;33m\]\w${RESET}"
  # 現在のユーザー
  local USER="\[\e[1;32m\]\u${RESET}"
  # gitのブランチ
  if [ `type -t __git_ps1` == "function" ]; then
    local BRANCH="\[\e[01;34m\]$(__git_ps1)${RESET}"
  fi

  # assume-role
  if [[ "$AWS_ACCOUNT_NAME" && "$AWS_ACCOUNT_ROLE" ]]; then
    local COLOR="$(env_color "${AWS_ACCOUNT_NAME}")"
    local AWS="(aws:${COLOR}${AWS_ACCOUNT_ROLE:0:3}@${AWS_ACCOUNT_NAME}${RESET})"
  fi
  # pulumi
  local PULUMI_YML=$(pwd)/Pulumi.yaml
  if [ -f $PULUMI_YML ]; then
    local WORKSPACE_HASH=$(echo -n "${PULUMI_YML}" | openssl sha1)
    local PROJECT_NAME=$(cat ${PULUMI_YML} | grep name: | sed -e 's/name: //g')
    local WORKSPACE_PATH=$(eval echo "~/.pulumi/workspaces/${PROJECT_NAME}-${WORKSPACE_HASH}-workspace.json")
    if [ -f $WORKSPACE_PATH ]; then
      local STACK=`cat ${WORKSPACE_PATH} | grep stack | sed -e 's/.*"stack": "\(.*\)".*/\1/' | sed -e 's/^.*\///'`
      local COLOR="$(env_color "${STACK}")"
      local PULUMI="${PROJECT_NAME}:(stack:${COLOR}${STACK}${RESET})"
    fi
  fi
  if [ $PULUMI ]; then
    # pulumiディレクトリはインフラ実行なので環境だけ表示
    local INFO="${PULUMI}"
  elif [ ${TERM_PROGRAM} = "vscode" ]; then
    # vscodeの場合は画面が狭いので短めに
    local CURRENT_DIR="$(basename $(pwd))"
    local MONOREPO_ROOT=`(cd ../ && pwd | xargs basename)`
    local INFO="\[\e[1;33m\]${MONOREPO_ROOT}/${CURRENT_DIR}"
  else
    # デフォルト
    local INFO="${USER}${DIR}"
  fi
  export PS1="${INFO}${AWS}${BRANCH} \n\[\e[01;34m\]\$${RESET}"
}


PROMPT_COMMAND='prompt_command'

[[ -n "$VIMRUNTIME" ]] && export PS1="(vim)$PS1"


# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# pg9.6
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin


[ -f /usr/local/etc/profile.d/bash-preexec.sh ] && . /usr/local/etc/profile.d/bash-preexec.sh

preexec() {
  if [ -d ./kubeconfig ] && [ -n "$AWS_ACCOUNT_ID" ]; then
    KUBECONFIG_PATH="./kubeconfig/${AWS_ACCOUNT_ID}.json"
    if [ -f $KUBECONFIG_PATH ]; then
      export KUBECONFIG=$KUBECONFIG_PATH
    fi
  fi
  if [ -n "$ROLE_SESSION_START" ] && [ $(($(date +%s)-ROLE_SESSION_START>3600)) == 1 ]; then
    assume-role $AWS_ACCOUNT_NAME $AWS_ACCOUNT_ROLE
  fi
}
precmd() {
  # echo -n "$(pulumi_stack)"
  true
}


