;;;; MacOS
(when is-mac
  (require 'ucs-normalize) ;; Mac用
  ;; Command-Key and Option-Key
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil)
  (setq trash-directory "~/.Trash/")
  ;; ispell/aspell
  (setq ispell-program-name "aspell")

  (exec-path-from-shell-initialize)

  (let* ((size 12)
         (asciifont "Menlo")
         (jpfont "Hiragino Maru Gothic ProN")
         (applefont "AppleMyungjo")
         (h (* size 10))
         (fontspec (font-spec :family asciifont))
         (jp-fontspec (font-spec :family jpfont))
         (apple-fontspec (font-spec :family applefont)))
    (set-face-attribute 'default nil :family asciifont :height h)
    (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec))

  ;; Don't minimize
  (global-set-key (kbd "C-z") nil))

(provide 'init-mac)
