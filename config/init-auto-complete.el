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
        ac-use-fuzzy t
        ac-auto-start nil
        ac-ignore-case nil)

  (ac-set-trigger-key "TAB")

  (add-hook 'auto-complete-mode-hook
            (lambda ()
              (define-key ac-completing-map (kbd "C-n") 'ac-next)
              (define-key ac-completing-map (kbd "C-p") 'ac-previous)
              (define-key ac-completing-map (kbd "C-s") 'ac-isearch)
              (define-key ac-completing-map (kbd "<tab>") 'ac-complete)
              (define-key ac-mode-map (kbd "M-RET") 'auto-complete)
              ;; (define-key ac-mode-map (kbd "M-/") 'auto-complete)
              ))

  (dolist (mode '(text-mode
                  coffee-mode
                  fundamental-mode
                  org-mode
                  web-mode
                  typescript-mode
                  ))
    (add-to-list 'ac-modes mode))

  (ac-ispell-setup)
  (dolist (hook '(text-mode-hook))
    (add-hook hook 'ac-ispell-ac-setup))

  (eval-after-load "yasnippet"
    '(progn
       (setq-default ac-sources (append '(ac-source-yasnippet) ac-sources))))

  )

(provide 'init-auto-complete)
