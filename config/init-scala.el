;;;; scala
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp")
(setq ensime-ac-override-settings nil)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(provide 'init-scala)
