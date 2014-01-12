;;;; ruby
;; ruby-mode.el
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))

;; ruby-indent
(setq ruby-indent-level 2)
(setq ruby-indent-tabs-mode nil)

;; ruby-block.el
(when (require 'ruby-block nil t)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)
  )

;; Rinari
;; https://github.com/eschulte/rinari
(when (require 'rinari nil t)
  (setq rinari-rgrep-file-endings "*.rb *.erb *.yml *.js"))

;; rspec-mode
(when (require 'rspec-mode nil t)
  (custom-set-variables '(rspec-use-rake-flag nil))
  )

;; rhtml-mode.el
;; http://d.hatena.ne.jp/willnet/20090110/1231595231
(when (require 'rhtml-mode nil t)
  (add-hook 'rhtml-mode-hook
            (lambda () (rinari-launch)))
  )

(defun find-ruby-lib (name)
  (interactive "sRuby library name: ")
  (find-file (ffap-ruby-mode name)))

;; ruby-interpolation.el
(require 'ruby-interpolation nil t)

;; https://github.com/tobiassvn/bundler.el
(require 'bundler nil t)

;; robe
(when (require 'robe nil t)
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-hook 'robe-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-robe)
              (setq completion-at-point-functions '(auto-complete)))))

;; yaml-mode.el
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; rbenv
(when (require 'rbenv nil t)
  (global-rbenv-mode))

(when (require 'rdefsx nil t)
  (define-key ruby-mode-map (kbd "C-c C-i") 'helm-rdefsx)
  (rdefsx-auto-update-mode 1)
  )

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rspec-use-rake-flag nil)
 '(safe-local-variable-values (quote ((encoding . utf-8) (encoding . UTF-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby")))))

(provide 'init-ruby)
