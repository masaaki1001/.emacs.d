(yas-global-mode 1)

;; 自分の定義したsnippetのみにする．
(setq-default yas-snippet-dirs (expand-file-name  "snippets" user-emacs-directory))
(yas-reload-all)

(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(provide 'init-yasnippet)
