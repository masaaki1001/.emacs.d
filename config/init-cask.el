;;;; Cask
(add-to-list 'auto-mode-alist '("Cask$" . emacs-lisp-mode))

(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-compatibility-setup)             ; 互換性確保

(provide 'init-cask)
