;; Homebrew
(push "/usr/local/bin" exec-path)

;; node.js
(setq exec-path (cons "~/.nvm/v0.9.8/bin" exec-path))
(setenv "PATH" (concat "~/.nvm/v0.9.8/bin:" (getenv "PATH")))

;; markdown
(setq markdown-command "/usr/local/bin/markdown")

(when (require 'exec-path-from-shell nil t)
    (exec-path-from-shell-initialize))

(provide 'init-env)
