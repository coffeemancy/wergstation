# encoding: UTF-8
#
# Cookbook Name:: wergstation
#
# Attribute:: emacs
#
# Copyfree (F) 2014 Carlton Stedman
#

default["wergstation"]["emacs"] = {
  # package archives to use
  "package-archives" => {
    "gnu"       => "http://elpa.gnu.org/packages/",
    "marmalade" => "http://marmalade-repo.org/packages/",
    "melpa"     => "http://melpa.milkbox.net/packages/",
    "tromey"    => "http://tromey.com/elpa/" },
  # packages to install
  "packages" => %w{ undo-tree
                    evil
                    git-gutter-fringe
                    markdown-mode
                    nlinum
                    rainbow-delimiters

                    ruby-mode
                    inf-ruby
                    ruby-end
                    ruby-interpolation
                    rhtml-mode
                    rspec-mode
                    yaml-mode

                    clojure-mode
                    cider

                    ess }
}
