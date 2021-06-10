#!/usr/bin/emacs --script

; TODO: Move inside the GitHub workflow, preferably
; don't do for file in src/*.org in shell, but rather
; in Elisp, so we don't have to start Emacs multiple
; times.
(find-file (elt argv 0))
(org-babel-tangle)
