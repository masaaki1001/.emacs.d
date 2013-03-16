;;----------------------------------------------------------------------------
;; 各種elisp
;;----------------------------------------------------------------------------
;; e2wm.el
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
;; https://github.com/kiwanami/emacs-window-manager
;; 最小の e2wm 設定例
(when (require 'e2wm nil t)
  (global-set-key (kbd "M-+") 'e2wm:start-management)
  (e2wm:add-keymap e2wm:pst-minor-mode-keymap '(("prefix v" . e2wm:dp-svn)) e2wm:prefix-key)
  ;; 終了する場合は「C-c ; Q」だけどsticky.elの影響でだめ
  )

;; session.el
;; http://maruta.be/intfloat_staff/101
(when (require 'session nil t)
  (add-hook 'after-init-hook 'session-initialize)
  (setq session-save-file "~/.emacs.d/resource/.session")
  (setq session-save-print-spec '(t nil nil))
  )

;; savekill.el
;; http://d.hatena.ne.jp/rubikitch/20110226/
(when (require 'savekill nil t)
  (setq save-kill-file-name "~/.emacs.d/resource/kill-ring-saved.el"))

;; quickrun.el
;; https://github.com/syohex/emacs-quickrun
(when (require 'quickrun nil t)
  (global-set-key [(f9)] 'quickrun))

;; scratch-log.el
;; http://d.hatena.ne.jp/kitokitoki/20100612/p1
;; https://github.com/wakaran/scratch-log
(when (require 'scratch-log nil t)
  (setq sl-scratch-log-file "~/.emacs.d/resource/.scratch-log")
  (setq sl-prev-scratch-string-file "~/.emacs.d/resource/.scratch-log-prev")
  (setq sl-restore-scratch-p t)
  )

;; expand-region.el
;; https://github.com/magnars/expand-region.el
;; http://d.hatena.ne.jp/syohex/20120117/1326814127
(when (require 'expand-region nil t)
  (global-set-key (kbd "C-,") 'er/expand-region)
  ;; http://d.hatena.ne.jp/yuheiomori0718/20120118/1326893579
  (global-set-key (kbd "C-M-,") 'er/contract-region);広がりすぎたら戻る処理
  ;; transient-mark-modeが nilでは動作ないので注意
  (transient-mark-mode t)

  (add-hook 'sgml-mode-hook
            (lambda ()
              (require 'rename-sgml-tag)
              (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)))

  (when (require 'js2-refactor nil t)
    (define-key js2-mode-map (kbd "C-c C-r") 'js2-rename-var))
  (when (require 'inline-string-rectangle nil t)
    (global-set-key (kbd "C-x r t") 'inline-string-rectangle))
  )

;; change-inner.el
;; https://github.com/magnars/change-inner.el
(when (require 'change-inner nil t)
  (global-set-key (kbd "M-i") 'change-inner)
  (global-set-key (kbd "M-o") 'change-outer)
  )

;; Experimental multiple-cursors
(when (require 'multiple-cursors nil t)
  (setq mc/list-file "~/.emacs.d/resource/.mc-lists.el")

  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

;; deferred.el
(when (require 'deferred nil t))

;; yaml-mode.el
;; https://github.com/yoshiki/yaml-mode
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

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

;; volatile-highlights.el
(when (require 'volatile-highlights nil t)
  (volatile-highlights-mode t)
  )

;; open-junk-file.el
(when (require 'open-junk-file nil t)
  (setq open-junk-file-format "~/.emacs.d/junk/%Y-%m-%d-%H%M%S.")
  )

;; ndmacro.el
;; https://github.com/snj14/ndmacro.el
;; e.g. hoge C-m hoge C-m C-t C-t C-t ....
;;      10   C-m 11   C-m C-t C-t C-t ....
(when (require 'ndmacro nil t)
  (global-set-key (kbd "C-3") 'ndmacro)
  )

;; auto-highlight-symbol-mode.el
;; https://github.com/mhayashi1120/auto-highlight-symbol-mode
;; http://d.hatena.ne.jp/yuheiomori0718/20111222/1324562208
;; http://d.hatena.ne.jp/syohex/20110126/1296048465
(when (require 'auto-highlight-symbol nil t)
  (global-auto-highlight-symbol-mode t)
  (ahs-set-idle-interval 5) ;ハイライトまでの待機時間 デフォルトは1秒
  )

;; pomodoro.el
;; https://github.com/baudtack/pomodoro.el
(when (require 'pomodoro nil t)
  (pomodoro-add-to-mode-line)
  )

;; fic-mode.el
;; https://github.com/lewang/fic-mode
;; highlight word is TODO or FIXME
(when (require 'fic-mode nil t))

(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start)
  )

(provide 'init-elisp)
