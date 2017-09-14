
# --------------------
#   ZSH PROMPT
# --------------------

export DEFAULT_USER=`whoami`

ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status custom_docker custom_aws time)

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=""

# currently this must be set as string because it's compared against a string :/
POWERLEVE9K_VCS_HIDE_TAGS="false"
POWERLEVEL9K_SHOW_CHANGESET="false"

POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="015"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="000"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="015"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="001"

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
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="000"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="010"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="009"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="010"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="000"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="010"
POWERLEVEL9K_DIR_HOME_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_BACKGROUND="012"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="012"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="007"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="012"

zsh_custom_aws() {
    if [ -n "$AWS_DEFAULT_PROFILE" ]; then
        echo -n "$AWS_DEFAULT_PROFILE";
    fi
    if [ -n "$AWS_DEFAULT_REGION" ]; then
        echo -n "/$AWS_DEFAULT_REGION";
    fi
    if [ -n "$ENVIRONMENT" ]; then
        echo -n "/$ENVIRONMENT";
    fi
}

POWERLEVEL9K_CUSTOM_AWS="zsh_custom_aws"
POWERLEVEL9K_CUSTOM_AWS_FOREGROUND="007"
POWERLEVEL9K_CUSTOM_AWS_BACKGROUND="166"

zsh_custom_docker() {
    echo -n $(docker version --format '{{.Client.Version}}/{{.Server.Version}}')
}

POWERLEVEL9K_CUSTOM_DOCKER="zsh_custom_docker"
POWERLEVEL9K_CUSTOM_DOCKER_FOREGROUND="007"
POWERLEVEL9K_CUSTOM_DOCKER_BACKGROUND="052"

# --------------------
#   ZSH CONFIG
# --------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PATH="$HOME/bin:/usr/local/opt/gettext/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"

# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins
plugins=( \
    aws \
    brew \
    docker \
    docker-compose \
    git \
    git-extras \
    github \
    ssh-agent \
    zsh-syntax-highlighting \
    zsh-completions \
)

if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fpath=(/usr/local/share/zsh-completions $fpath)

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

# Reload .zshrc
alias rz="source $HOME/.zshrc"

# make(){/usr/local/bin/make "$@" 2>&1 | sed -u '/recipe for target/d'}

# --------------------
#   BREW ALIASES
# --------------------

alias buuc='brew update && brew upgrade && brew cleanup'

# --------------------
#   DOCKER ALIASES
# --------------------

# include docker version manager
if [ -f $HOME/.dvm/dvm.sh ]; then
    source $HOME/.dvm/dvm.sh
fi

load-docker-qnap() {
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.1.100:2376"
export DOCKER_CERT_PATH="$HOME/.docker/qnap"
export DOCKER_MACHINE_NAME=""
dvm use 1.10.2
}

# Get latest container ID
alias dl="docker ps -l -q"
# Get container processes
alias dps="docker ps"
# Get container processes for smaller screens
alias dpsf="docker ps --size --format \"table {{.Names}}\t{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.Ports}}\" | tail -n +2 | sort"
# Get process included stop container
alias dpa="docker ps --size -a"
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

ecr-login() {
	login=$(aws ecr get-login --region eu-west-1 --no-include-email)
	export aws_ecr_host=$(echo $login | grep -o "https.*")
	eval $login
	echo "aws_ecr_host: $aws_ecr_host"
}

load-aws() {
	export AWS_DEFAULT_PROFILE=${1:-io}
	export AWS_DEFAULT_REGION=${2:-eu-west-1}
}

alias start-work="load-aws && ecr-login"


# --------------------
#   GIT ALIASES
# --------------------

alias gac='git add -A . && git commit -m' $1
alias gpom='git push origin master'
alias gpod='git push origin develop'
alias gtf='git tag -l | xargs git tag -d && git fetch'
alias gt='git tag'
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
alias gpps='for ns in *; do echo "\t$ns" && cd $ns && for r in *; do echo "\t\t$r" && cd $r && git pull --recurse-submodules && cd ../; done; cd ../; done'

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
