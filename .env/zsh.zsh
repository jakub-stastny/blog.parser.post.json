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
  tmux send-keys -t 2 'tmux resize-pane -Z' C-m
  tmux send-keys -t 2 'elm-test src/*.elm --watch' C-m
}

# We compile on save, but for the first-time compilation,
# we want to be able to do it from the shell, rather than
# having to go and save manually each file from Emacs.
compile() {
  cd src
  echo "(dolist (file argv) (message file) (find-file file) (org-babel-tangle))" > compile.el
  emacs --script compile.el *.org
  rm compile.el
  cd -
}

report-custom-functions
