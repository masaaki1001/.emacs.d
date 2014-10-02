;;;; emacs lisp
(with-eval-after-load "eldoc"
  (require 'eldoc-extension)
  (setq eldoc-idle-delay 0.2)
  (set-face-attribute 'eldoc-highlight-function-argument nil
                      :underline t :foreground "green"
                      :weight 'bold))

(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook 'enable-paredit-mode)
  (add-hook hook 'turn-on-elisp-slime-nav-mode)
  (add-hook hook 'turn-on-eldoc-mode))

(provide 'init-elisp)
