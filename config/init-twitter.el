;;;; twittering-mode.el
;; http://www.emacswiki.org/emacs/TwitteringMode-ja
;; http://www.kototone.jp/com/how_to_use_twittering-mode.html
(setq twittering-use-master-password t)
(setq twittering-private-info-file (expand-file-name "twittering-mode.gpg" resource-dir))
(setq twittering-icon-mode t)

(provide 'init-twitter)
