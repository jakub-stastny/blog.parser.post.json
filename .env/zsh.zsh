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

up() {
  tmux split-window -h
  tmux send-keys -t 1 'clear' C-m
  tmux send-keys -t 1 'elm reactor' C-m
  tmux send-keys -t 2 'elm-test src/*.elm --watch' C-m
}

report-custom-functions
