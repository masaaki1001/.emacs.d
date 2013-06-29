;; js2-mode
;; https://github.com/mooz/js2-mode
(add-hook 'js2-mode-hook '(lambda () (setq mode-name "js2")))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode)) ;; for rails
(js2-imenu-extras-setup)

;; js3-mode
;; (add-hook 'js3-mode-hook '(lambda () (setq mode-name "js3")))
;; (autoload 'js3-mode "js3" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
;; (add-to-list 'auto-mode-alist '("\\.js.erb$" . js3-mode)) ;; for rails

;; tern.js
(add-to-list 'load-path (expand-file-name "tern/emacs" repositories-dir))
(autoload 'tern-mode "tern.el" nil t)
;;(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'auto-complete
  '(eval-after-load 'tern
     '(progn
        (require 'tern-auto-complete)
        (tern-ac-setup))))


;; coffee-mode
(defun coffee-custom ()
  "coffee-mode-hook"
  (and (set (make-local-variable 'tab-width) 2)
       (set (make-local-variable 'coffee-tab-width) 2))
  )

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(provide 'init-javascript)
