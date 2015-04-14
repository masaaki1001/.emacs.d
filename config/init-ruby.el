;; ruby-mode
(with-eval-after-load 'ruby-mode
  (setq ruby-deep-indent-paren nil)
  (setq ruby-indent-level 2)
  (setq ruby-indent-tabs-mode nil)

  (defun my/ruby-block-mode-hook ()
    (require 'ruby-block)
    (ruby-block-mode t)
    (setq ruby-block-highlight-toggle t))

  ;; ruby-block
  (add-hook 'ruby-mode-hook 'my/ruby-block-mode-hook)
  ;; rspec-mode
  (custom-set-variables '(rspec-use-rake-flag nil))
  ;; robe
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-hook 'robe-mode-hook 'ac-robe-setup))

;; rbenv
(when (executable-find "rbenv")
  (global-rbenv-mode))

(provide 'init-ruby)
