;;;; env
;; Homebrew
(push "/usr/local/bin" exec-path)

;; node.js
(setq exec-path (cons "~/.nvm/v0.10.26/bin" exec-path))
(setenv "PATH" (concat "~/.nvm/v0.10.26/bin" (getenv "PATH")))

;; markdown
(setq markdown-command "/usr/local/bin/markdown")

(when is-mac
  (when (require 'exec-path-from-shell nil t)
    (exec-path-from-shell-initialize)))

(provide 'init-env)
