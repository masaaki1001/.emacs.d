;; Homebrew
(push "/usr/local/bin" exec-path)

;; node.js
(setq exec-path (cons "~/.nvm/v0.8.18/bin" exec-path))
(setenv "PATH" (concat "~/.nvm/v0.8.18/bin:" (getenv "PATH")))

;; markdown
(setq markdown-command "/usr/local/bin/markdown")


;; load environment value
;; http://d.hatena.ne.jp/syohex/20111117/1321503477
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (split-string (getenv "PATH") ":"))
  (add-to-list 'exec-path path))


(provide 'env)
