load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/basic.zsh
load ~/.zsh/environments/emacs.zsh

start-emacs-session
rename-first-tab

# Custom functions & aliases.
t() {
  if test $# = 0; then
    elm-test src/**/*Test.elm
  else
    elm-test $@
  fi
}

report-custom-functions
