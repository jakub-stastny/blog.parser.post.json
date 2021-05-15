load ~/.zsh/environments/helpers.zsh && save-function-list
load ~/.zsh/environments/basic.zsh

start-emacs-session
rename-first-tab

# Custom functions & aliases.
#export DENO_INSTALL="/root/.deno"
#path-add $DENO_INSTALL/bin

path-add /root/.deno/bin

watch() {
  deno run --allow-read --allow-run bin/watch.ts
}
        
report-custom-functions
