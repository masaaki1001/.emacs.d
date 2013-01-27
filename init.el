; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; load-path
;;----------------------------------------------------------------------------
;;http://d.hatena.ne.jp/omochist/20070207/1170872589
(setq load-path (append '("~/.emacs.d"
                          "~/.emacs.d/elisp"
                          "~/.emacs.d/config"
                          "~/.emacs.d/auto-install"
                          "~/.emacs.d/scala-mode"
                          "~/.emacs.d/ddskk/elisp"
                          )
                        load-path))

;; 再帰的に指定ディレクトリ以下をload-pathに追加する
;; (let ((default-directory "~/.emacs.d/color-theme/"))
;;   (setq load-path (cons default-directory load-path))
;;   (normal-top-level-add-subdirs-to-load-path))

;; function add to load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; load-path
;; e.g. (add-to-load-path "elisp" "xxx" "xxx")
;;(add-to-load-path "repositories" "color-theme")
(add-to-load-path "repositories")

;;----------------------------------------------------------------------------
;; emacsclient
;;----------------------------------------------------------------------------
(server-start t)

;;----------------------------------------------------------------------------
;; encoding
;;----------------------------------------------------------------------------
;; 日本語に設定
(set-language-environment 'Japanese)
;; UTF-8に設定
;(require 'ucs-normalize) ;; Mac用
(prefer-coding-system           'utf-8)
(set-buffer-file-coding-system  'utf-8)
(set-terminal-coding-system     'utf-8)
(set-keyboard-coding-system     'utf-8)
(set-clipboard-coding-system    'utf-8)
(setq file-name-coding-system   'utf-8)
(setq locale-coding-system      'utf-8)

;;----------------------------------------------------------------------------
;; Mac用設定
;;----------------------------------------------------------------------------
(require 'init-mac nil t)

;;----------------------------------------------------------------------------
;; elpa, marmalade, melpa, auto-install etc...
;;----------------------------------------------------------------------------
(require 'init-elpa nil t)

;;----------------------------------------------------------------------------
;; keybind
;;----------------------------------------------------------------------------
(require 'init-keybind nil t)

;;----------------------------------------------------------------------------
;; Window設定
;;----------------------------------------------------------------------------
;; 半透明にする
;; パラメータは、順に通常のフレーム、アクティブでないフレーム、移動中のフレームの透明度を表す
(modify-all-frames-parameters
 (list (cons 'alpha  '(nil 80 50 30)))) ;; 直近
 ;; (list (cons 'alpha  '(nil 70 50 30))))
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
;;  (create-fontset-from-ascii-font "Inconsolata-12:weight=normal:slant=normal" nil "Inconsolata") ;;フォントをInconsolateにする
;;  (set-default-font "Inconsolata-12")
;;  (set-fontset-font (frame-parameter nil 'font)
;;                    'japanese-jisx0208
;;                    '("Hiragino Kaku Gothic ProN" . "unicode-bmp"))
  ))

;;----------------------------------------------------------------------------
;; color-theme
;;----------------------------------------------------------------------------
(require 'init-theme nil t)

;;----------------------------------------------------------------------------
;; 表示
;;----------------------------------------------------------------------------
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
;; ;;(set-face-background 'hl-line "DarkSlateBlue")
;; (defface my-hl-line-face
;;   '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
;;      (:background "DarkSlateBlue" t))   ; 背景を黒に.
;;     (((class color) (background light)) ; カラーかつ, 背景が light ならば,
;;      (:background "ForestGreen" t))     ; 背景を ForestGreen に.
;;     (t (:bold t)))
;;   "hl-line's my face")
;; (setq hl-line-face 'my-hl-line-face)

;; カーソルの点滅を止める
(blink-cursor-mode 0)
;; カーソルの位置が何文字目かを表示する
(column-number-mode t)
;; カーソルの位置が何行目かを表示する
(line-number-mode t)
;; カーソルの場所を保存する
(when (require 'saveplace nil t)
  (setq save-place-file "~/.emacs.d/resource/.emacs-places"))

(setq-default save-place t)
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

;; 置換時に大文字小文字を区別する
;; (setq case-replace nil)
;; 検索時に大文字小文字を区別する
;; (setq case-fold-search nil)

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

;; multi-term
;; terminal soft
;; (when (require 'multi-term nil t)
;;   (setq multi-term-program "/bin/bash"))

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
;;(setq-default line-spacing 0)

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

(add-to-list 'auto-mode-alist '("\\(?:\\.gitconfig\\|\\.gitmodules\\|config\\)\\'" . conf-mode))

;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;;----------------------------------------------------------------------------
;; filecache
;;----------------------------------------------------------------------------
(require 'init-filecache nil t)

;;----------------------------------------------------------------------------
;; dired
;;----------------------------------------------------------------------------
(require 'init-dired nil t)

;;----------------------------------------------------------------------------
;; recentf
;;----------------------------------------------------------------------------
(require 'init-recentf nil t)

;;----------------------------------------------------------------------------
;; 各種elisp
;;----------------------------------------------------------------------------
(require 'init-elisp nil t)

;;----------------------------------------------------------------------------
;; bm.el
;;----------------------------------------------------------------------------
(require 'init-bm nil t)

;;----------------------------------------------------------------------------
;; twittering-mode.el
;; http://www.emacswiki.org/emacs/TwitteringMode-ja
;; http://www.kototone.jp/com/how_to_use_twittering-mode.html
;;----------------------------------------------------------------------------
(when (require 'twittering-mode nil t)
  (setq twittering-use-master-password t)
  (setq twittering-private-info-file "~/.emacs.d/resource/twittering-mode.gpg")
  (setq twittering-icon-mode t)
  ;; (setq twittering-status-format "%i @%s %S %p: \n %T  [%@]%r %R %f%L\n -------------------------------------------")
  )

;;----------------------------------------------------------------------------
;; migemo.el
;;----------------------------------------------------------------------------
(require 'init-migemo nil t)

;;----------------------------------------------------------------------------
;; calfw.el
;; http://d.hatena.ne.jp/kiwanami/20110723/1311434175
;;----------------------------------------------------------------------------
(when (require 'calfw nil t)
  ;;(cfw:open-calendar-buffer) ; カレンダー表示
  ;; calfw-org.el
  (require 'calfw-org nil t)
  ;; ;; 月
  ;; (setq calendar-month-name-array
  ;;   ["January" "February" "March"     "April"   "May"      "June"
  ;;    "July"    "August"   "September" "October" "November" "December"])

  ;; ;; 曜日
  ;; (setq calendar-day-name-array
  ;;       ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"])

  ;; ;; 週の先頭の曜日
  (setq calendar-week-start-day 0) ; 日曜日は0, 月曜日は1
  )

;; (require 'calendar)
;; (setq  number-of-diary-entries 31)
;; (define-key calendar-mode-map "f" 'calendar-forward-day)
;; (define-key calendar-mode-map "n" 'calendar-forward-day)
;; (define-key calendar-mode-map "b" 'calendar-backward-day)
;; (setq mark-holidays-in-calendar t)
;; (require 'japanese-holidays)
;; (setq calendar-holidays
;;       (append japanese-holidays local-holidays other-holidays))
;; (setq calendar-weekend-marker 'diary)
;; (add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
;; (add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)

;;----------------------------------------------------------------------------
;; smartrep.el
;;----------------------------------------------------------------------------
(require 'init-smartrep nil t)

;;----------------------------------------------------------------------------
;; view-mode
;; Emacs mail magazine
;;----------------------------------------------------------------------------
(require 'init-view nil t)

;;----------------------------------------------------------------------------
;; Buffer関連
;;----------------------------------------------------------------------------
(require 'init-buffer nil t)

;;----------------------------------------------------------------------------
;; auto-complete
;;----------------------------------------------------------------------------
(require 'init-auto-complete nil t)

;;----------------------------------------------------------------------------
;; org-mode
;;----------------------------------------------------------------------------
(require 'init-org nil t)

;;----------------------------------------------------------------------------
;; ruby
;;----------------------------------------------------------------------------
(require 'init-ruby nil t)

;;----------------------------------------------------------------------------
;; scala
;;----------------------------------------------------------------------------
(require 'init-scala nil t)

;;----------------------------------------------------------------------------
;; flymake
;;----------------------------------------------------------------------------
(require 'init-flymake nil t)

;;----------------------------------------------------------------------------
;; anything.el
;;----------------------------------------------------------------------------
(require 'init-anything nil t)

;;---------------------------------------------------------
;; Eshell
;;---------------------------------------------------------
(require 'init-eshell nil t)

;;---------------------------------------------------------
;; moz.el
;;---------------------------------------------------------
(require 'init-moz nil t)

;;---------------------------------------------------------
;; magit.el
;;---------------------------------------------------------
(require 'init-magit nil t)

;;---------------------------------------------------------
;; Google Chrome edit with emacs
;;---------------------------------------------------------
(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start)
  )

;;---------------------------------------------------------
;; ddskk
;;---------------------------------------------------------
(require 'init-ddskk nil t)

;;---------------------------------------------------------
;; yasnippet
;;---------------------------------------------------------
(require 'init-yasnippet nil t)

;;---------------------------------------------------------
;; defun
;;---------------------------------------------------------
(require 'init-defun nil t)

;;---------------------------------------------------------
;; hatena-mode
;;---------------------------------------------------------
(require 'init-hatena nil t)

;;---------------------------------------------------------
;; slime
;;---------------------------------------------------------
(require 'init-slime nil t)

;;----------------------------------------------------------------------------
;; revive.el
;; 前回emacsを終了したときの状態を復元してくれる (resume)を実行すれば復元してくれるが、
;; そのためには各モードの設定を読み込んでいる必要があるので、一番最後に書いてある。
;; http://d.hatena.ne.jp/gan2/20080203/1202032426
;; http://tech.kayac.com/archive/emacs.html
;;----------------------------------------------------------------------------
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(setq revive:configuration-file "~/.emacs.d/resource/.revive.el")
(define-key ctl-x-map "F" 'resume)                        ; C-x F で復元
(define-key ctl-x-map "K" 'wipe)                          ; C-x K で Kill
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に保存
(resume) ; 起動時に復元
