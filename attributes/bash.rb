# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: bash
#
# Copyfree (F) 2014 Carlton Stedman
#

include_attribute "wergstation::default"
home = node["wergstation"]["user"]["home"]

# some commonly used shortcuts
be  = "bundle exec"
beb = "#{be} berks"
bek = "#{be} kitchen"
k   = "#{be} knife"

default["wergstation"]["bash"].tap do |bash|
  # bash aliases
  bash["aliases"] = {
    "a" => "alias",

    # bundle
    "b"      => "bundle",
    "be"     => be,
    "betvc"  => "#{be} thor version:current",

    # berks
    "beb"  => beb,
    "bebi" => "#{beb} install",
    "bebu" => "#{beb} upload",

    # command defaults
    "df"    => "df -h",
    "egrep" => "egrep --color",
    "grep"  => "grep --color -E",
    "ls"    => "ls -x --color -h",

    # knife
    "k"      => k,
    "kb"     => "#{k} block",
    "kclean" => "#{k} cookbook bulk delete .*",
    "kne"    => "#{k} node edit",
    "knl"    => "#{k} node list",
    "ksn"    => "#{k} search node",

    # git aliases
    # FIXME: 2 -- Put these in .gitconfig?
    "ga."   => "git add . -A",
    "gb"    => "git branch",
    "gcam"  => "git commit -a --amend -m",
    "gcfg"  => "git config --get-regexp \".*\"",
    "gcm"   => "git commit -a -m",
    "gco"   => "git checkout",
    "gd"    => "git difftool",
    "gft"   => "git fetch --tags",
    "gl"    => "git log",
    "gm"    => "git mergetool",
    "gpl"   => "git pull",
    "gplo"  => "git pull origin",
    "gplom" => "git pull origin master",
    "gplu"  => "git pull upstream",
    "gplum" => "git pull upstream master",
    "gpo"   => "git push origin",
    "gpt"   => "git push --tags",
    "gr"    => "git remote -v",
    "grrm"  => "git remote remove",
    "gst"   => "git status",
    "gt"    => "git tag",

    # misc
    "c"    => "cat",
    "e"    => "emacsclient -nw",
    "g"    => "egrep --color",
    "h"    => "history",
    "l"    => "less -r",
    "lrh"  => "lein trampoline repl :headless",
    "nflx" => "pulseaudio -k; netflix-desktop",
    "rdpp" => "rdesktop pinkiepie -r \"sound:remote\" -a 32 -g 95%",
    "t"    => "tree -C",
    "tl"   => "tree -C | less -r",
    "vbox" => "virtualbox >/dev/null 2>&1",

    # rspec
    "rspec" => "#{be} rspec --color --format documentation",

    # test-kitchen
    "bekb"   => "#{k} block",
    "bekc"   => "#{bek} converge -c -l info",
    "bekd"   => "#{bek} destroy",
    "bekl"   => "#{bek} list",
    "bekssh" => "#{bek} login",
    "bekt"   => "#{bek} test -c -l debug",
    "bekv"   => "#{bek} verify -c -l info",

    # tmux
    "tat"     => "tmux a -t",
    "tls"     => "tmux list-sessions",
    "tmcopy"  => "tmux show-buffer | xsel --clipboard --input",
    "tmpaste" => "tmux show-buffer",
    "tns"     => "tmux new-session -s",

    # utilities
    "fixmouse" => "synclient TouchpadOff=0",
    "khcz"     => "killall -HUP -r .*chef-zero",
    "mdl"      => "pandoc -s -f markdown -t man | man -l -",
    "pbcopy"   => "xsel --clipboard --input",
    "pbpaste"  => "xsel --clipboard --output",
    "pslag"    => "ps -lA | head -n 1; ps -lA | grep -i",
    "rmcolors" =>
      "sed -r \\\"s/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g\\\"",
    "sshkrm"   => "ssh-keygen -f \\\"/#{home}/.ssh/known_hosts\\\" -R",
    "unknife"  => "rm -f ~/.chef/knife.rb",
    "xdw"      => "xrandr --output DP1 --auto --left-of LVDS1",
    "xsw"      => "xrandr --output DP1 --off",

    # vagrant
    "vd"   => "vagrant destroy",
    "vh"   => "vagrant halt",
    "vp"   => "vagrant provision",
    "vre"  => "vagrant reload",
    "vssh" => "vagrant ssh",
    "vst"  => "vagrant status",
    "vup"  => "vagrant up"
  }

  # exports to add to ~/.bashrc
  bash["exports"] = {
    # colorful man pages
    "LESS_TERMCAP_mb" => "$'\\E[01;31m'",
    "LESS_TERMCAP_md" => "$'\\E[01;31m'",
    "LESS_TERMCAP_me" => "$'\\E[0m'",
    "LESS_TERMCAP_se" => "$'\\E[0m'",
    "LESS_TERMCAP_so" => "$'\\E[01;44;33m'",
    "LESS_TERMCAP_ue" => "$'\\E[0m'",
    "LESS_TERMCAP_us" => "$'\\E[01;32m'",

    # emacs
    "EDITOR" => '"/usr/bin/emacsclient -nw"',

    # gpg
    "GPGKEY" => "D5F32429",

    # ruby
    "RUBYOPT" => "W0",

    # test kitchen
    "DRIVER_PLUGIN"   => "vagrant",
    "DYN_CHEF_DATA"   => "#{home}/dataroot",
    "PLATFORMS"       => '"ubuntu ubuntu1204 ubuntu1404"',
    "PROVISIONER"     => "chef_zero",
    "RSPEC_LOG_LEVEL" => "error",
    "SSL_CERT_FILE"   => "#{home}/dataroot/config/cacert.pem",

    # vagrant
    "VAGRANT_DEFAULT_PROVIDER" => "virtualbox"
  }
end
