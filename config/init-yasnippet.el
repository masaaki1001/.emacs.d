;;;; yasnippet
(when (require 'yasnippet nil t)
  (yas-global-mode 1)
  ;; (custom-set-variables '(yas-trigger-key "TAB"))

  ;; 自分の定義したsnippetのみにする．
  (setq-default yas-snippet-dirs (expand-file-name  "snippets" user-emacs-directory))
  ;; (setq yas-snippet-dirs (expand-file-name  "snippets" user-emacs-directory))

  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
  )

(provide 'init-yasnippet)
