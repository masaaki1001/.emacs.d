;;;; ruby
;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))

(setq ruby-deep-indent-paren nil)

;; ruby-indent
(setq ruby-indent-level 2)
(setq ruby-indent-tabs-mode nil)

(defun my/ruby-block-mode-hook ()
  (require 'ruby-block)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t))

;; ruby-block
(add-hook 'ruby-mode-hook 'my/ruby-block-mode-hook)

;; Rinari
;; https://github.com/eschulte/rinari
(setq rinari-rgrep-file-endings "*.rb *.erb *.yml *.js")

;; rspec-mode
(custom-set-variables '(rspec-use-rake-flag nil))

;; rhtml-mode
;; http://d.hatena.ne.jp/willnet/20090110/1231595231
(add-hook 'rhtml-mode-hook
          (lambda () (rinari-launch)))

(defun find-ruby-lib (name)
  (interactive "sRuby library name: ")
  (find-file (ffap-ruby-mode name)))

;; robe
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

;; rbenv
(when (executable-find "rbenv")
  (global-rbenv-mode))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8) (encoding . UTF-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby")))))

(provide 'init-ruby)
