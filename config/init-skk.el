;;;; ddskk
;; http://openlab.ring.gr.jp/skk/index-j.html
;; http://quruli.ivory.ne.jp/document/ddskk_14.2/skk_toc.html#SEC_Contents
;; http://www.bookshelf.jp/texi/skk/skk_4.html#SEC15
(require 'skk)
(require 'skk-autoloads)
(require 'skk-study)
(setq skk-user-directory (expand-file-name ".skk" user-emacs-directory))
(setq skk-large-jisyo (expand-file-name "SKK-JISYO.L" skk-user-directory))
(setq skk-sticky-key ";")
(setq skk-byte-compile-init-file t)
(setq skk-tut-file (expand-file-name "SKK.tut" skk-user-directory))
(setq skk-show-annotation t)
(setq skk-show-tooltip t)
(setq skk-show-inline t)
(setq skk-egg-like-newline t)
(setq skk-auto-insert-paren t)
(setq-default skk-kutouten-type 'en)
(setq skk-henkan-strict-okuri-precedence t)
(setq skk-check-okurigana-on-touroku 'auto)
(setq skk-indicator-use-cursor-color nil)
(setq skk-emacs-hiragana-face "LimeGreen")
(setq skk-dcomp-multiple-activate t)

(add-to-list 'Info-additional-directory-list (expand-file-name "info" skk-user-directory))
(global-set-key (kbd "C-x j") 'skk-mode)

(defun my/skk-hook ()
  (skk-latin-mode t))
(add-hook 'find-file-hooks 'my/skk-hook)

(provide 'init-skk)
