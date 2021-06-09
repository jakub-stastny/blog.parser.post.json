; TODO: This should be done as a save hook in Emacs.
(find-file (elt argv 0))
(org-babel-tangle)
