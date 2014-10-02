(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))

(with-eval-after-load "typescript"
  (setq require-final-newline t)
  (setq typescript-auto-indent-flag nil)
  (define-key typescript-mode-map (kbd "C-c C-j") nil)

  (setq tss-popup-help-key "C-c C-c t")
  (setq tss-jump-to-definition-key "C-c C-c C-t")
  ;; auto-completeが重いので"SPC" "." ":"の入力で起動しないようにする．
  (setq tss-ac-trigger-command-keys nil)

  (tss-config-default)
  (remove-hook 'after-save-hook 'tss-run-flymake)
  (setq ac-sources (append '(ac-source-words-in-buffer
                             ac-source-words-in-all-buffer
                             ac-source-imenu) ac-sources)))

(provide 'init-typescript)
