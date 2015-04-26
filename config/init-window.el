(with-eval-after-load 'elscreen
  ;; タブの先頭に[X]を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; header-lineの先頭に[<->]を表示しない
  (setq elscreen-tab-display-control nil)
  ;; モードラインにフレーム番号を表示しない
  (setq elscreen-display-screen-number nil))

(provide 'init-window)
