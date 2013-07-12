;;----------------------------------------------------------------------------
;; twittering-mode.el
;; http://www.emacswiki.org/emacs/TwitteringMode-ja
;; http://www.kototone.jp/com/how_to_use_twittering-mode.html
;;----------------------------------------------------------------------------
(when (require 'twittering-mode nil t)
  (setq twittering-use-master-password t)
  (setq twittering-private-info-file "~/.emacs.d/resource/twittering-mode.gpg")
  (setq twittering-icon-mode t)
  )

(provide 'init-twitter)
