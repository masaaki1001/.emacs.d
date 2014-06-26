;;;; markdown
(when (require 'markdown-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.\\(md\\|mdt\\|mdwn\\)$" . markdown-mode))
  (defvar markdown-imenu-generic-expression
    '(("title"  "^\\(.+?\\)[\n]=+$" 1)
      ("h2-"    "^\\(.+?\\)[\n]-+$" 1)
      ("h1"   "^#\\s-+\\(.+?\\)$" 1)
      ("h2"   "^##\\s-+\\(.+?\\)$" 1)
      ("h3"   "^###\\s-+\\(.+?\\)$" 1)
      ("h4"   "^####\\s-+\\(.+?\\)$" 1)
      ("h5"   "^#####\\s-+\\(.+?\\)$" 1)
      ("h6"   "^######\\s-+\\(.+?\\)$" 1)
      ("fn"   "^\\[\\^\\(.+?\\)\\]" 1) ))

  (add-hook 'markdown-mode-hook
            (lambda ()
              (setq imenu-generic-expression markdown-imenu-generic-expression)))
  )

(provide 'init-markdown)
