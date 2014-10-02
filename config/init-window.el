(require 'elscreen)
;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;; モードラインにフレーム番号を表示しない
(setq elscreen-display-screen-number nil)
;; http://blog.n-z.jp/blog/2013-09-24-elscreen-last-command-char.html
(defadvice elscreen-jump (around elscreen-last-command-char-event activate)
  (let ((last-command-char last-command-event))
    ad-do-it))

(provide 'init-window)
