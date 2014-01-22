;;;; search
;; i-searchでのbackspace有効
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

(when (require 'anzu nil t)
  (global-anzu-mode t)
  (set-face-attribute 'anzu-mode-line nil
                      :foreground "black" :weight 'bold)
  ;; (global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
  (global-set-key [remap query-replace] 'anzu-query-replace)
  )

(provide 'init-search)
