;; 半透明にする
;; パラメータは、順に通常のフレーム、アクティブでないフレーム、移動中のフレームの透明度を表す
(modify-all-frames-parameters
 (list (cons 'alpha  '(nil 80 50 30))))
;; Scrollを１行毎に
(setq scroll-step 1)
;; Widow設定
;; http://d.hatena.ne.jp/mizchi/20100828/1282940866
(if window-system (progn
  (set-background-color "Black")
  (set-foreground-color "White")
  (set-frame-height (selected-frame) 49) ;; 全画面表示用 縦
  (set-frame-width (selected-frame) 179) ;; 全画面表示用 横
  (set-cursor-color "Gray")
  (menu-bar-mode -1) ;; メニューバーを消す
  (tool-bar-mode -1) ;; ツールバーを消す
  (toggle-scroll-bar nil) ;; スクロールバーを消す
  ))

;; *scratch*の初期表示メッセージを消す
;; http://d.hatena.ne.jp/mooz/20100318/p1
(setq initial-scratch-message "")
;; tabは4文字分、改行後に自動インデント
(setq-default tab-width 4 indent-tabs-mode nil)
;; 行末の空白を表示
(setq-default show-trailing-whitespace t)

;; 現在行を目立たせる
;; http://d.hatena.ne.jp/khyiker/20070409/emacs_hl_line
(global-hl-line-mode) ;デフォルトはこの行だけでOK

;; カーソルの点滅を止める
(blink-cursor-mode 0)
;; カーソルの位置が何文字目かを表示する
(column-number-mode t)
;; カーソルの位置が何行目かを表示する
(line-number-mode t)
;; カーソルの場所を保存する
(when (require 'saveplace nil t)
  (setq save-place-file "~/.emacs.d/resource/.emacs-places")
  (setq-default save-place t))
;; スクロール時のカーソル位置維持
(setq scroll-preserve-screen-position t)
;; 対応する括弧を光らせる。
(show-paren-mode t)
;; 対応する括弧内も光らせる
;;(setq show-paren-style 'expression)
;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)
;; バックアップファイルを作らない
(setq backup-inhibited t)
;; オートセーブファイルを作らない
(setq make-backup-files nil)
(setq auto-save-default nil)
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;; find-fileのファイル名補完時に大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)
(setq completion-ignore-case t)
;; C-a の挙動を変える
;;(global-set-key "\C-a" '(lambda (arg)
;;			  (interactive "^p")
;;			  (cond
;;			   ((bolp)
;;			    (call-interactively 'back-to-indentation))
;;			   (t
;;			    (move-beginning-of-line arg)))))

;; cua-mode 矩形選択 C-RETで起動 M-x cua-modeでenabledにする
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html
(cua-mode t)
(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止

;; 現在の関数名を表示
(which-function-mode 1)
;; 選択範囲を色付け
(transient-mark-mode 1)
;; 起動時のメッセージを消す
(setq inhibit-startup-message t)
;;"yes or no"を"y or n"にする
(fset 'yes-or-no-p 'y-or-n-p)
;; M-x を補完
(when (require 'mcomplete nil t)
  (turn-on-mcomplete-mode))

;; メニューバーにファイルパスを表示する
(setq frame-title-format
      ;(format "%%f - Emacs@%s" (system-name)))
      (format "%%f - Emacs" (system-name)))

;; 一行が 80 字以上になった時には自動改行する
(setq fill-column 80)
(setq-default auto-fill-mode t)
;; 画面端で折り返さない
;; http://valvallow.blogspot.jp/2010/04/emacs.html
;; (setq truncate-lines t)
;; (setq truncate-partial-width-windows t)
;; (defun togle-truncate-line ()
;;   (interactive)
;;   (let ((p (null truncate-lines)))
;;     (setq truncate-lines p)
;;     (setq truncate-partial-width-windows p)
;;     p))

;; 行間を開く
(setq-default line-spacing 0.1) ;my setting

;; モードラインに時間を表示する
(setq display-time-24hr-format t)
;; 以下の書式に従ってモードラインに日付 時刻を表示する
(setq display-time-string-forms
      '((format "%s/%s/%s(%s) %s:%s"
          year month day
          dayname
          24-hours minutes)))
(setq display-time-day-and-date t)
(display-time)

;; モードラインに行番号、桁番号を表示
(line-number-mode t)
(column-number-mode t)
;; パーセント表示ではなくて総行数で表示
;; http://d.hatena.ne.jp/sandai/20120307/p1
;;(setcar mode-line-position
;;        '(:eval (format "%d" (count-lines (point-max) (point-min)))))
;; beepを消す
(setq ring-bell-function 'ignore)

;; uniquify.el (デフォルトで入っている)
;; http://d.hatena.ne.jp/yuheiomori0718/20111214/1323864339
(require 'uniquify)
;; filename<dir>形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; *で囲まれたバッファ名は対象外にする
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; 終了時にプロセスをkillしていいか聞いてこないようにする
;; http://d.hatena.ne.jp/kitokitoki/20101029/p3
(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
  (when (process-list)
    (dolist (p (process-list))
      (set-process-query-on-exit-flag p nil))))

;; ダイアログボックスを使わないようにする
;; Emacs tech book p59
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;; find file (or url) at point
;; C-x C-f
(ffap-bindings)

(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(provide 'init-global)
