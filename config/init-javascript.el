;;;; javascript
;; js2-mode
;; https://github.com/mooz/js2-mode
(add-hook 'js2-mode-hook '(lambda () (setq mode-name "js2")))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode))
(setq js2-auto-indent-p t)
(setq-default js2-global-externs '("require" "assert" "__dirname" "console" "JSON"))
(eval-after-load 'js2-mode
  '(progn
     (js2-imenu-extras-setup)))

(require 'jquery-doc nil t)
(require 'json nil t)

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
