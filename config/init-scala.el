;;;; scala
(with-eval-after-load 'scala-mode
  (setq ensime-ac-override-settings nil)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

(provide 'init-scala)
