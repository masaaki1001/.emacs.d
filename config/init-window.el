;;;; window
;; e2wm.el
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
;; 最小の e2wm 設定例
(when (require 'e2wm nil t)
  (global-set-key (kbd "M-+") 'e2wm:start-management)
  (e2wm:add-keymap e2wm:pst-minor-mode-keymap '(("prefix v" . e2wm:dp-svn)) e2wm:prefix-key)
  )

(require 'spaces nil t)

(provide 'init-window)
