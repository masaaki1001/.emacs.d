;;;; shell
;; emacs-bash-completion
(add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete)

;; emamux
(global-set-key (kbd "C-c C-c t") 'emamux:send-command)
(custom-set-variables
 '(emamux:completing-read-type 'helm))

(provide 'init-shell)
