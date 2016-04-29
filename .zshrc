
# --------------------
#   ZSH PROMPT
# --------------------

ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status custom_docker custom_aws time)

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=""

POWERLEVEL9K_TIME_FOREGROUND="000"
POWERLEVEL9K_TIME_BACKGROUND="011"
POWERLEVEL9K_AWS_FOREGROUND="007"
POWERLEVEL9K_AWS_BACKGROUND="166"
POWERLEVEL9K_STATUS_OK_FOREGROUND="000"
POWERLEVEL9K_STATUS_OK_BACKGROUND="010"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="007"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="001"
POWERLEVEL9K_VCS_FOREGROUND="000"
POWERLEVEL9K_VCS_BACKGROUND="010"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="009"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="010"
POWERLEVEL9K_DIR_HOME_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_BACKGROUND="012"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="012"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="007"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="012"

zsh_custom_aws() {
#  echo -n $AWS_DEFAULT_PROFILE | awk '{print substr($1,1,3)"..."substr($1,length($1)-2)}'
  echo -n $AWS_DEFAULT_PROFILE
}

POWERLEVEL9K_CUSTOM_AWS="zsh_custom_aws"
POWERLEVEL9K_CUSTOM_AWS_FOREGROUND="007"
POWERLEVEL9K_CUSTOM_AWS_BACKGROUND="166"

zsh_custom_docker() {
  if [[ -z "$DOCKER_HOST" ]]; then
    return;
  fi
  echo -n \
  $(echo -n $DOCKER_HOST | awk '{print substr($1,7,length($1)-11)}') \
  $(docker version | awk 'FNR==2{printf $2}FNR==10{print "/"$2}')
}

POWERLEVEL9K_CUSTOM_DOCKER="zsh_custom_docker"
POWERLEVEL9K_CUSTOM_DOCKER_FOREGROUND="007"
POWERLEVEL9K_CUSTOM_DOCKER_BACKGROUND="052"

# --------------------
#   ZSH CONFIG
# --------------------

# ~ is sometimes not working for me on osx
export PATH="./vendor:$HOME/bin:$HOME/tools/rsp/docker-experiments:$HOME/.composer/vendor/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
export ZSH=~/.oh-my-zsh

CASE_SENSITIVE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
plugins=( \
  aws \
  branch \
  brew \
  composer \
  docker \
  docker-compose \
  git \
  git-flow \
  git-hubflow \
  git-extras \
  git-remote-branch \
  github \
  go \
  golang \
  grunt \
  iwhois \
  jira \
  jsontools \
  knife \
  kitchen \
  vundle \
)

source $ZSH/oh-my-zsh.sh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# --------------------
#   BINDS
# --------------------

# I need that for iterm2
bindkey -e;
bindkey '^[[1;5C' forward-word;
bindkey '^[[1;5D' backward-word;
# option-right
bindkey '\e\e[C' forward-word;
# option-left
bindkey '\e\e[D' backward-word;
# cmd-right
bindkey "^[[1;2C" end-of-line;
# cmd-left
bindkey "^[[1;2D" beginning-of-line;

# --------------------
#   SYSTEM ALIASES
# --------------------

# prevent embarassingly running command on whole server
# does not work on osx
# alias chown='chown --preserve-root'
# alias chmod='chmod --preserve-root'
# alias chgrp='chgrp --preserve-root'

# Interactive confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# set defaults for disk usage and disk free
alias df='df -H'
alias du='du -ch'

# Resume wget by default
alias wget='wget -c'

# Create parent directories on demand ##
alias mkdir='mkdir -pv'

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# get rid of command not found ##
alias cd..='cd ..'

# a quick way to get out of current directory
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# Colorize the ls output
alias ls='ls -ahlG'

# --------------------
#   DOCKER ALIASES
# --------------------

# include docker version manager
source ~/.dvm/dvm.sh

load-docker-machine() {
  eval $(docker-machine env default)
}
alias ldm="load-docker-machine"

load-docker-qnap() {
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.1.100:2376"
  export DOCKER_CERT_PATH="$HOME/.docker/qnap"
  export DOCKER_MACHINE_NAME=""
  dvm use 1.9.1
}

# Get latest container ID
alias dl="docker ps -l -q"
# Get container processes
alias dps="docker ps"
# Get container processes for smaller screens
alias dpsf="docker ps --format \"table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.Ports}}\" | tail -n +2 | sort"
# Get process included stop container
alias dpa="docker ps -a"
# Get images
alias di="docker images"
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"
# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"
dkill() { docker kill $@; }
# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"
# Stop all containers
dstop() { docker stop $(docker ps -a -q); }
# Remove all exited containers
drm() { docker rm -v $(docker ps --filter status=exited -aq); }
# Remove all containers
drmf() { docker rm -v -f $(docker ps -aq); }
# Remove all unused images
dri() { docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc); }
# Remove all images
drif() { docker rmi -f $(docker images -q --no-trunc); }
# Remove all orphaned volumes
drv() { docker volume rm $(docker volume ls --filter "dangling=true" -q); }
# Remove all volumes
drvf() { docker volume rm -f $(docker volume ls -q); }
# Remove all exited containers, unused images and orphaned volumes
alias dclear="drm; drv; dri;"
# Remove all containers, images and volumes with force
alias dclean="drmf; drvf; drif;"
# Dockerfile build, e.g., $dbu image/name, without image it name takes current folder name
dbu() {
  d=${PWD##*/}
  n=${1:-$d}
  docker build -t="$n" .
}

alias ddu="disk-usage"
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dcs="docker-compose stop"
alias dck="docker-compose kill"
alias dcr="docker-compose rm -f"

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# --------------------
#   AWS ALIASES
# --------------------

load-aws-gg-production() { export AWS_DEFAULT_PROFILE=gg-production }
load-aws-ps-playground() { export AWS_DEFAULT_PROFILE=ps-playground }

load-aws-docker-ps-playground() {
  login=$(aws ecr get-login)
  export aws_ecr_host=$(echo $login | grep -o "https.*")
  eval $login
  dvm use 1.9.1
  echo "aws_ecr_host: $aws_ecr_host"
  load-aws-ps-playground
}

# --------------------
#   GIT ALIASES
# --------------------

alias gac='git add -A . && git commit -m' $1
alias gpom='git push origin master'
alias gpod='git push origin develop'
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add -A'
alias gb='git branch'
alias gbd='git branch -d '
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gp='git pull'
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias grsh='git reset --soft HEAD~${1:-1}'

# Show all alias related git
galias() { alias | grep 'git' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# --------------------
#   PHP ALIASES
# --------------------

# I'm using my own php docker image to run the php qa tools for projects that are cloned on my host
# I'm only mounting /Users and PWD since I'm on osx and using the docker-machine
docker_run_php="docker run --rm -it -v /Users:/Users -v "${PWD}":"${PWD}" --net=host -w "${PWD}" php"
alias dcomposer="$docker_prefix composer $@"
alias dphpmd="$docker_prefix phpmd $@"
alias dphpcs="$docker_prefix phpcs $@"
alias dphpcbf="$docker_prefix phpcbf $@"
alias dphploc="$docker_prefix phploc $@"
alias dpdepend="$docker_prefix pdepend $@"
alias dphpcpd="$docker_prefix phpcpd $@"
alias dphpmetrics="$docker_prefix phpmetrics $@"
alias dphpdox="$docker_prefix phpdox $@"
alias dphpunit="$docker_prefix phpunit $@"
alias dcodecept="$docker_prefix codecept $@"
