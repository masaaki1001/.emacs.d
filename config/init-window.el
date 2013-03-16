;; e2wm.el
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
;; https://github.com/kiwanami/emacs-window-manager
;; 最小の e2wm 設定例
(when (require 'e2wm nil t)
  (global-set-key (kbd "M-+") 'e2wm:start-management)
  (e2wm:add-keymap e2wm:pst-minor-mode-keymap '(("prefix v" . e2wm:dp-svn)) e2wm:prefix-key)
  ;; 終了する場合は「C-c ; Q」だけどsticky.elの影響でだめ
  )

;; windows.el
(when (require 'windows nil t)
  (setq win:use-frame nil)
  (win:startup-with-window)
  (global-set-key (kbd "C-M-k") 'win-prev-window)
  (global-set-key (kbd "C-M-j") 'win-next-window)
  ;; M-数字で窓を選択する
  (setq win:switch-prefix [esc])
  (loop for i from 1 to 9 do
        (define-key esc-map (number-to-string i) 'win-switch-to-window))
  ;; winner-mode.el is default
  (winner-mode 1)
  (global-set-key (kbd "C-c C-u") 'winner-undo)
  )

(provide 'init-window)
