;;;; typescript
(when (require 'typescript nil t)
  (add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
  (setq typescript-auto-indent-flag nil)
  (define-key typescript-mode-map (kbd "C-c C-j") nil)

  (eval-after-load "typescript"
    (setq require-final-newline t)
    )

  (when (require 'tss nil t)
    (setq tss-popup-help-key "C-c C-c t")
    (setq tss-jump-to-definition-key "C-c C-c C-t")
    ;; auto-completeが重いので"SPC" "." ":"の入力で起動しないようにする．
    (setq tss-ac-trigger-command-keys nil)

    (tss-config-default)
    (remove-hook 'after-save-hook 'tss-run-flymake)
    (setq ac-sources (append '(ac-source-words-in-buffer
                               ac-source-words-in-all-buffer
                               ac-source-imenu) ac-sources))
    )

  (eval-after-load "flycheck"
    '(progn
       (defcustom flycheck-tslintrc-file-name "./config/tslint.json"
         "Customize config file name"
         :type 'string)

       (flycheck-def-config-file-var flycheck-tslintrc typescript-tslint flycheck-tslintrc-file-name
         :safe #'string)

       ;; (flycheck-define-checker typescript-tslint
       ;;   "Use tslint to flycheck TypeScript code."
       ;;   :command ("tslint"
       ;;             "-f" source-inplace
       ;;             (config-file "-c" flycheck-tslintrc)
       ;;             "-t" "prose")
       ;;   :error-patterns ((warning (file-name) "[" line ", " column "]: " (message)))
       ;;   :modes typescript-mode)
       ;; (add-to-list 'flycheck-checkers 'typescript-tslint)

       (flycheck-define-checker typescript-tslint
         "Use tslint to flycheck TypeScript code."
         :command ("tslint"
                   "-f" source
                   "-c" (eval (projectile-expand-root flycheck-tslintrc-file-name))
                   "-t" "prose")
         :error-patterns ((warning (file-name) "[" line ", " column "]: " (message)))
         :modes typescript-mode)
       (add-to-list 'flycheck-checkers 'typescript-tslint)
       )
    )
  )

(provide 'init-typescript)
