;;;; basic setting
;; 日本語に設定
(set-language-environment 'Japanese)
;; UTF-8に設定
(prefer-coding-system           'utf-8)
(set-buffer-file-coding-system  'utf-8)
(set-terminal-coding-system     'utf-8)
(set-keyboard-coding-system     'utf-8)
(set-clipboard-coding-system    'utf-8)
(setq file-name-coding-system   'utf-8)
(setq locale-coding-system      'utf-8)
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
  (set-cursor-color "Gray")
  (menu-bar-mode -1) ;; メニューバーを消す
  (tool-bar-mode -1) ;; ツールバーを消す
  (toggle-scroll-bar nil) ;; スクロールバーを消す

  (when (require 'maxframe nil t)
    (add-hook 'window-setup-hook 'maximize-frame t))
  ))

;; *scratch*の初期表示メッセージを消す
;; http://d.hatena.ne.jp/mooz/20100318/p1
(setq initial-scratch-message "")
;; tabは2文字分、改行後に自動インデント
(setq-default tab-width 2 indent-tabs-mode nil)
;; 行末の空白を表示
(setq-default show-trailing-whitespace t)
;; 現在行を目立たせる
;; http://d.hatena.ne.jp/khyiker/20070409/emacs_hl_line
(global-hl-line-mode) ;デフォルトはこの行だけでOK
(set-face-background hl-line-face "#222222")

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
;; 削除したらゴミ箱に
(setq delete-by-moving-to-trash t)
;; 終了時にオートセーブファイルを消す
;; (setq delete-auto-save-files t)
;; find-fileのファイル名補完時に大文字小文字を区別しない
(setq read-file-name-completion-ignore-case t)
(setq completion-ignore-case t)
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
;; *Completions*バッファを，使用後に消してくれる
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part11
(when (require 'lcomp nil t)
  (lcomp-install))

;; メニューバーにファイルパスを表示する
(setq frame-title-format
      ;(format "%%f - Emacs@%s" (system-name)))
      (format "%%f - Emacs" (system-name)))

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
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;; find file (or url) at point
(ffap-bindings)

(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(electric-indent-mode -1)

(require 'tramp)

(require 'server)
(if (not (server-running-p))
    (server-start))

(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start)
  )

(provide 'init-basic)
