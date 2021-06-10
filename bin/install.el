#!/usr/bin/emacs --script

; This is for the CI, so we can tangle code blocks.

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-refresh-contents)

(message "~ Installing Org mode.")
(package-install 'org)
