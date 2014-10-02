;; i-searchでのbackspace有効
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

(defun isearch-yank-symbol ()
  (interactive)
  (isearch-yank-internal (lambda () (forward-symbol 1) (point))))
(define-key isearch-mode-map (kbd "C-M-w") 'isearch-yank-symbol)

(global-anzu-mode t)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "black" :weight 'bold)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)

(provide 'init-search)
