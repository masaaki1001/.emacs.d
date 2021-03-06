;; i-searchでのbackspace有効
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

(global-set-key (kbd "C-M-s") 'isearch-forward-symbol-at-point)

(defun isearch-yank-symbol ()
  (interactive)
  (isearch-yank-internal (lambda () (forward-symbol 1) (point))))
(define-key isearch-mode-map (kbd "C-M-w") 'isearch-yank-symbol)

(global-anzu-mode t)
(setq anzu-use-migemo t)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "black" :weight 'bold)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)

(provide 'init-search)
