; -*- mode: lisp; coding: utf-8 -*-
(when (require 'scala-mode nil t))

(add-to-list 'load-path "~/.emacs.d/ensime_2.9.2-0.9.8.1/elisp")
(when (require 'ensime nil t)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
  )

(provide 'init-scala)
