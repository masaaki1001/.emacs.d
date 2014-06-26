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

  ;; markdown-css
  (setq github-markdown-style-dir (expand-file-name "github-css" repositories-dir))
  (setq markdown-css-themes-dir (expand-file-name "markdown-css-themes" repositories-dir))

  (setq markdown-css-path (expand-file-name "github.css" github-markdown-style-dir))
  )

(provide 'init-markdown)
