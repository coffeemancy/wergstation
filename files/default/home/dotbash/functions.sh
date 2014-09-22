#!/usr/bin/env bash
#
# MANAGED BY CHEF IN wergstation::bashrc RECIPE.
# CHANGES WILL BE OVERWRITTEN!
#

# start emacs server or connect to it if running
function e {
    # start emacs daemon if not running
    if ! ps aux | egrep emacs.*daemon | grep -v grep > /dev/null; then
        printf "\e[35mStarting emacs daemon\e[00m\n"
        emacs --daemon 2>&1
    fi

    emacsclient -nw "$@"
}

function wtfgit {
    git log \
        --graph \
        --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' \
        --abbrev-commit \
        --date=relative
}

function wtf {
    # see if a git directory
    if [ -a .git ]; then
        wtfgit
    fi
}

# on 'cd' also list directory
function cd {
    builtin cd "$@"
    printf ">\e[33m$(pwd)\e[00m:\n"
    ls
}

# lookup gem on rubygems
function rbg {
    curl https://rubygems.org/api/v1/gems/$1.json 2>/dev/null | python -m json.tool
}

# get ruby gems version
function rbgv {
    rbg $1 | grep \"version\"
}

# find stuff and execute
function ffe {
  find ./* -type f -exec "$@" {} \;
}

# find emacs backup files and remove
function febr {
  find .* -type f -name '*#*' -exec rm -i {} \;
}

# kill processes based on regex match
function ekill {
    procs=$(ps aux | egrep "$1" | grep -v grep | awk '{print $2}')
    sig=${2:-SIGKILL} # default to kill
    if [ "$procs" ]; then
        printf "\e[31mKilling all /$1/ with signal /$sig/\e[00m\n"
        for proc in $procs; do
            printf "  \e[31mKilling $proc with signal $sig\e[00m\n"
            kill -$sig $proc
        done
    else
        printf "\e[33mNo processes found matching /$1/\e[00m\n"
    fi
}

# walk backwards until you hit a "root" folder
function cdr() {
  while [ 1 ]
  do
    # Stop at the true root
    if [ "$(pwd)" == "/" ]; then
      break
    fi

    # Stop at the home dir
    if [ "$(pwd)" == "/home/$USER" ]; then
      break
    fi

    FOUND_ROOT=0
    ROOT_TYPES=("^.git$")
    for root_type in "${ROOT_TYPES[@]}"
    do
      IS_ROOT=$(ls -a | grep -cP '^.git$')
      if [ "$IS_ROOT" == "1" ]
      then
        FOUND_ROOT=1
        break
      fi
    done
    if [ $FOUND_ROOT -eq 1 ]
    then
      break
    fi
    cd ..
  done
}

# delete cookbook and re-upload it
function kdbu {
    cb=$1
    printf "\e[35mDeleting cookbook $cb\e[00m\n"
    knife cookbook delete $cb -y 2>/dev/null
    bundle exec berks shelf uninstall $cb 2>/dev/null
    printf "\e[35mInstalling cookbooks\e[00m\n"
    bundle exec berks install
    printf "\e[35mUploading cookbook $cb\e[00m\n"
    bundle exec berks upload $cb
}

# find all ports vagrant is running on
function vports {
    for x in $(vagrant status | grep running | sed -e 's/\s.*//g'); do
        echo $x && vagrant ssh-config $x | grep -i port
    done
}

# xrandr helper
function xr {
    other=$1
    direction=${2:-left-of}

    # set up laptop screen
    printf "\e[35mSetting LVDS1 as auto\e[00m\n"
    xrandr --output LVDS1 --auto

    # set up other displays with direction, defaults to --left-of
    if [ "$other" ]; then
        printf "\e[35mSetting $other $direction LVDS1\e[00m\n"
        xrandr --output $other --auto --$direction LVDS1
    fi

    # disable any other outputs
    for another in DP1 HDMI1; do
        if [ "$another" != "$other" ]; then
            printf "\e[35mDisabling $another\e[00m\n"
            xrandr --output $another --off
        fi
    done
}
