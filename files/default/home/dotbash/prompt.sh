#!/usr/bin/env bash
#
# MANAGED BY CHEF IN wergstation::bashrc RECIPE.
# CHANGES WILL BE OVERWRITTEN!
#

__git_ps1() {
    ref=$(git symbolic-ref -q HEAD 2> /dev/null) || return
    printf "${1:- \e[00m(\e[31m%s\e[00m)}" "${ref#refs/heads/}"
}

__knife_ps1() {
    if [ -L ~/.chef/knife.rb ]; then
        printf "\e[00m [\e[33m$(ls -l ~/.chef/knife.rb | sed -e 's/.*\/knife-//' | sed -e 's/\.rb//')\e[00m]"
    fi
}

PS1='\[\e[35m\]\t \[\e[32m\]\u\[\e[00m\]@\[\e[32m\]\h\[\e[00m\]:\[\e[36m\]\w$(__git_ps1)$(__knife_ps1)\[\e[00m\]\n\$ '

