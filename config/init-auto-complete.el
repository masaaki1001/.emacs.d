;;----------------------------------------------------------------------------
;; auto-complete
;; http://cx4a.org/software/auto-complete/manual.ja.html
;;----------------------------------------------------------------------------
(require 'popup nil t)
(require 'fuzzy nil t)

(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20131001.1051/dict")
  (setq ac-comphist-file "~/.emacs.d/resource/ac-comphist.dat")
  (ac-config-default)
  (setq ac-delay 0.5)
  (setq ac-use-quick-help t)
  (setq ac-quick-help-delay 1.0)
  (setq ac-use-menu-map t)
  (setq ac-auto-start t)
  (setq ac-ignore-case nil)
  (add-hook 'auto-complete-mode-hook
            (lambda ()
              (define-key ac-completing-map (kbd "C-n") 'ac-next)
              (define-key ac-completing-map (kbd "C-p") 'ac-previous)
              (define-key ac-completing-map (kbd "C-s") 'ac-isearch)
              (define-key ac-mode-map (kbd "M-RET") 'auto-complete)
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
                  web-mode
                  ))
    (add-to-list 'ac-modes mode))

  (eval-after-load "auto-complete"
  '(progn
      (ac-ispell-setup)))

  (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
  (add-hook 'text-mode-hook 'ac-ispell-ac-setup)

  )

(provide 'init-auto-complete)
