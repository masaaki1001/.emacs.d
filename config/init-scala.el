(when (require 'scala-mode2)
  (add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
  )

(add-to-list 'load-path "~/.emacs.d/ensime/elisp")
(when (require 'ensime nil t)
  ;; ensime 同梱の auto-complete を使おうとするのを止める
  (setq ensime-ac-override-settings nil)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
  )

(provide 'init-scala)
