;;;; emacs lisp
;; eldoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

(eval-after-load "eldoc"
  '(progn
     (require 'eldoc-extension)
     (setq eldoc-idle-delay 0.2)
     (set-face-attribute 'eldoc-highlight-function-argument nil
                         :underline t :foreground "green"
                         :weight 'bold)))

;; elisp-slime-nav
(add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t)))

(require 'paredit)
(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                lisp-mode-hook
                ielm-mode-hook
                scheme-mode-hook
                inferior-scheme-mode-hook
                clojure-mode-hook
                slime-repl-mode-hook))
  (add-hook hook 'enable-paredit-mode))

(provide 'init-elisp)
