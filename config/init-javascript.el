;; js2-mode
;; https://github.com/mooz/js2-mode
;; originalではなくid:moozの拡張版を利用
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode)) ;; for rails

;; js3-mode
;; https://github.com/thomblake/js3-mode
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js3-mode)) ;; for rails

(provide 'init-javascript)
