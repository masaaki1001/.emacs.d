;;;; auto-complete
;; http://cx4a.org/software/auto-complete/manual.ja.html
(require 'popup nil t)
(require 'fuzzy nil t)

(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
               (expand-file-name  "ac-dict" user-emacs-directory))
  (setq ac-comphist-file (expand-file-name "ac-comphist.dat" resource-dir))
  (ac-config-default)
  (setq-default ac-sources (append '(ac-source-words-in-buffer
                                     ac-source-words-in-all-buffer
                                     ac-source-imenu) ac-sources))
  (setq ac-delay 0.5
        ac-use-quick-help t
        ac-quick-help-delay 1.0
        ac-use-menu-map t
        ac-auto-start nil
        ac-ignore-case nil)

  (add-hook 'auto-complete-mode-hook
            (lambda ()
              (define-key ac-completing-map (kbd "C-n") 'ac-next)
              (define-key ac-completing-map (kbd "C-p") 'ac-previous)
              (define-key ac-completing-map (kbd "C-s") 'ac-isearch)
              (define-key ac-completing-map (kbd "<tab>") 'ac-complete)
              (define-key ac-mode-map (kbd "M-RET") 'auto-complete)
              ;; (define-key ac-mode-map (kbd "M-/") 'auto-complete)
              ))

  (eval-after-load "yasnippet"
    '(setq-default ac-sources (append '(ac-source-yasnippet) ac-sources)))

  (dolist (mode '(git-commit-mode
                  coffee-mode
                  markdown-mode
                  fundamental-mode
                  org-mode
                  text-mode
                  sass-mode
                  html-mode
                  web-mode
                  typescript-mode
                  ))
    (add-to-list 'ac-modes mode))

  (eval-after-load "auto-complete"
    '(progn
       (ac-ispell-setup)))

  (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
  (add-hook 'text-mode-hook 'ac-ispell-ac-setup)

  )

(provide 'init-auto-complete)
