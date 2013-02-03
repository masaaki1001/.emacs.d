;; Homebrew
(push "/usr/local/bin" exec-path)

;; node.js
(setq exec-path (cons "~/.nvm/v0.8.18/bin" exec-path))
(setenv "PATH" (concat "~/.nvm/v0.8.18/bin:" (getenv "PATH")))

(provide 'env)
