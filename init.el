; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; load-path
;;----------------------------------------------------------------------------
;;http://d.hatena.ne.jp/omochist/20070207/1170872589
(setq load-path (append '("~/.emacs.d/"
                          "~/.emacs.d/elisp"
                          "~/.emacs.d/auto-install/"
                          "~/.emacs.d/yasnippet/"
                          "~/.emacs.d/auto-complete/")
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
(add-to-load-path "repositories" "color-theme")

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
(defun mac-os-p ()
  (member window-system '(mac ns)))
(defun linuxp ()
  (eq window-system 'x))

(when (mac-os-p)
;; Command-Key and Option-Key
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil))

;; フォント設定
;; http://weboo-returns.com/blog/inconsolata-as-a-programming-font/?utm_source=twitterfeed&utm_medium=twitter
;;(set-face-attribute 'default nil
;;                    :family "inconsolata"
;;                    :height 140)

;;----------------------------------------------------------------------------
;; auto-install.el
;;----------------------------------------------------------------------------
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/auto-install/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)             ; 互換性確保

  ;; auto-installのバッファ削除
  (require 'cl)
  (defun my-erase-auto-install-buffer ()
    ;;(interactive)
    (dolist (buf (buffer-list))
      (if (eq (string-match "^\\*auto-install " (buffer-name buf)) 0)
          (progn
            ;; (print "ok")
            (kill-buffer buf)))))
  ;;実行する
  (my-erase-auto-install-buffer)
  )

;;----------------------------------------------------------------------------
;; package.el(marmalade) ちなみにEmacs24からは標準搭載
;; http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el
;;----------------------------------------------------------------------------
(when (require 'package nil t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize)

  ;; marmalade.el
  ;; http://sheephead.homelinux.org/2011/06/17/6724/
  (load "~/.emacs.d/elpa/marmalade-0.0.4/marmalade.el")
  )

;;----------------------------------------------------------------------------
;; keybind
;;----------------------------------------------------------------------------
;;(define-key global-map "\C-h" 'delete-backward-char) ; 削除
(global-set-key "\C-h" 'delete-backward-char) ; 削除
(global-set-key "\M-h" 'backward-kill-word)
(pc-selection-mode) ;; Shift + 矢印キーで範囲選択
(global-set-key "\C-z" 'undo) ;; undo
(setq kill-whole-line t) ;; C-k で改行を含め切り取り
;; 改行時にインデント
(global-set-key "\C-m" 'newline-and-indent)
;; 指定行へ移動
(global-set-key "\M-g" 'goto-line)

;; 単語削除で切り取りではなく削除になるようにする
;; http://d.hatena.ne.jp/syohex/20110329/
(defun delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  (interactive "p")
  (delete-word (- arg)))
(global-set-key (kbd "M-d") 'delete-word)
(global-set-key [C-backspace] 'backward-delete-word)

;; http://openlab.dino.co.jp/2007/09/25/23251372.html
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat)
  (terminal-init-bobcat))

;; 対応する括弧に移動(C-M-f/p相当)
;; http://www23.atwiki.jp/selflearn/pages/41.html
(global-set-key [?\C-{] 'backward-list)
(global-set-key [?\C-}] 'forward-list)

;; enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC ...
;; http://d.hatena.ne.jp/kbkbkbkb1/20111205/1322988550
(setq set-mark-command-repeat-pop t)

;; 一行複製
;; https://gist.github.com/1708398
;; https://gist.github.com/897494
;; (defun duplicate-line()
;;   (interactive)
;;   (save-excursion
;;     (move-beginning-of-line 1)
;;     (kill-line)
;;     (yank)
;;     (yank)))
;; (global-set-key (kbd "C-M-y") 'duplicate-line)

;; duplicate-thing.el
;; https://github.com/ongaeshi/duplicate-thing
;; https://raw.github.com/ongaeshi/duplicate-thing/master/duplicate-thing.el
;; http://d.hatena.ne.jp/syohex/20120325/1332641491
;; 上の自作よりリージョンの複製とかできて便利
(require 'duplicate-thing)
(global-set-key (kbd "C-M-y") 'duplicate-thing)

;; emacsのc-u-c-uを8回繰り返しにする
;; http://d.akinori.org/2010/03/05/emacsのc-u-c-uを8回繰り返しにする/
(defadvice universal-argument-more
  (before stop-by-eight-before-sixteen (arg) activate)
  "Stop by eight before sixteen."
  (let ((num (car arg)))
    (if (> 16 num) (ad-set-arg 0 (list (/ num 2))))))

;; バックスラッシュ
(define-key global-map (kbd "M-|") "\\")

;; http://d.hatena.ne.jp/kbkbkbkb1/20111205/1322988550
;; enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC ...
(setq set-mark-command-repeat-pop t)

;;----------------------------------------------------------------------------
;; Window設定
;;----------------------------------------------------------------------------
;; 半透明にする
;; パラメータは、順に通常のフレーム、アクティブでないフレーム、移動中のフレームの透明度を表す
;; (modify-all-frames-parameters
;;  (list (cons 'alpha  '(nil 80 50 30)))) ;; 直近
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
  (create-fontset-from-ascii-font "Inconsolata-16:weight=normal:slant=normal" nil "Inconsolata") ;;フォントをInconsolateにする
  (set-default-font "Inconsolata-13")
  ;;(set-default-font "Inconsolata-16")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("Hiragino Kaku Gothic ProN" . "unicode-bmp"))
  ))

;;----------------------------------------------------------------------------
;; color-theme
;;----------------------------------------------------------------------------
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (require 'color-theme-solarized nil t)
  (require 'color-theme-sanityinc-tomorrow nil t)
  (require 'color-theme-tangotango nil t)
  (require 'zenburn nil t)
  )

;;(require 'color-theme-railscasts)
;;(color-theme-railscasts)
;;(color-theme-subtle-blue)
;;(color-theme-Gnome2)

;; 取得元
;; https://github.com/sellout/emacs-color-theme-solarized
;; https://github.com/purcell/color-theme-sanityinc-tomorrow
;; https://github.com/olegshaldybin/color-theme-railscasts
;; https://github.com/juba/color-theme-tangotango
;; https://github.com/credmp/color-theme-zenburn

;;----------------------------------------------------------------------------
;; Power Line for Emacs
;; from EmacsWiki
;; http://www.emacswiki.org/emacs-en/PowerLinen
;;----------------------------------------------------------------------------
;;(require 'powerline)

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

;; カーソルの形を指定
;; http://homepage.mac.com/zenitani/elisp-j.html#modeline
;;(add-to-list 'default-frame-alist '(cursor-type . 'box)) ;; ボックス型カーソル
;; カーソルの点滅を止める
(blink-cursor-mode 0)
;; カーソルの位置が何文字目かを表示する
(column-number-mode t)
;; カーソルの位置が何行目かを表示する
(line-number-mode t)
;; カーソルの場所を保存する
(when (require 'saveplace nil t)
  (setq save-place-file "~/.emacs.d/.emacs-places")
  )

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
  (turn-on-mcomplete-mode)
  )

;; メニューバーにファイルパスを表示する
(setq frame-title-format
      ;(format "%%f - Emacs@%s" (system-name)))
      (format "%%f - Emacs" (system-name)))

;; multti-term
;; terminal soft
(when (require 'multi-term nil t)
  (setq multi-term-program "/bin/bash"))

;; 一行が 80 字以上になった時には自動改行する
(setq fill-column 80)
(setq-default auto-fill-mode t)
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

;; 縦分割と横分割を切り替える M-x window-toggle-divisionでできるようにする
;; http://d.hatena.ne.jp/himadatanode/20061011/p2
(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)

    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )
    (switch-to-buffer-other-window other-buf)
    (other-window -1)))

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

;;----------------------------------------------------------------------------
;; filecache
;;----------------------------------------------------------------------------
(require 'filecache)
;;(file-cache-add-directory-list
;;  (list "~" "~/.emacs.d/")) ;; ディレクトリを追加

(file-cache-add-directory-using-find "~/Workspace/hoge")
(define-key minibuffer-local-completion-map "\C-c\C-i"
  'file-cache-minibuffer-complete)

(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     (file-cache-add-directory-using-find "~/Workspace/hoge")
     ;;(file-cache-add-directory-list load-path)
     ))

(defun file-cache-save-cache-to-file (file)
  "Save contents of `file-cache-alist' to FILE.
For later retrieval using `file-cache-read-cache-from-file'"
  (interactive "FFile: ")
  (with-temp-file (expand-file-name file)
    (prin1 file-cache-alist (current-buffer))))

(defun file-cache-read-cache-from-file (file)
  "Clear `file-cache-alist' and read cache from FILE.
The file cache can be saved to a file using
`file-cache-save-cache-to-file'."
  (interactive "fFile: ")
  (file-cache-clear-cache)
  (let ((buf (find-file-noselect file)))
    (setq file-cache-alist (read buf))
    (kill-buffer buf)))

(defvar anything-source-file-cache
  '((name . "File Cache")
    (candidates . file-cache-files)
    (type . file)))

;;----------------------------------------------------------------------------
;; dired
;;----------------------------------------------------------------------------
;; emacs wiki
;; http://xahlee.org/emacs/emacs_diredplus_mode.html
;;(require 'dired+)
;; diredで今日変更したファイル色付け
;; http://masutaka.net/chalow/2011-12-17-1.html
(defface dired-todays-face '((t (:foreground "forest green"))) nil)
(defvar dired-todays-face 'dired-todays-face)

(defconst month-name-alist
  '(("1"  . "Jan") ("2"  . "Feb") ("3"  . "Mar") ("4"  . "Apr")
    ("5"  . "May") ("6"  . "Jun") ("7"  . "Jul") ("8"  . "Aug")
    ("9"  . "Sep") ("10" . "Oct") ("11" . "Nov") ("12" . "Dec")))

(defun dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (let ((month-name
	  (cdr (assoc (format-time-string "%b") month-name-alist))))
     (if month-name
	 (format
	  (format-time-string
	   "\\(%Y-%m-%d\\|%b %e\\|%%s %e\\) [0-9]....") month-name)
       (format-time-string
	"\\(%Y-%m-%d\\|%b %e\\) [0-9]....")))
   arg t))

(eval-after-load "dired"
  '(font-lock-add-keywords
    'dired-mode
    (list '(dired-today-search . dired-todays-face))))

;; s を何回か入力すると，拡張子やサイズによる並び換えもできる
(load "sorter")
;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)
;; ディレクトリ内のファイル名を編集できるようにする
;; Emacs tech book p102
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;; 削除したらごみ箱行き
(setq delete-by-moving-to-trash t)

;; direx.el
;; http://cx4a.blogspot.com/2011/12/popwineldirexel.html
;; https://github.com/m2ym/direx-el/
;; https://raw.github.com/m2ym/direx-el/master/direx.el
(require 'direx nil t)
;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
;;(push '(direx:direx-mode :position left :width 25 :dedicated t)
;;      popwin:special-display-config)
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
;;(setq direx:leaf-icon "  "
;;      direx:open-icon "▾ "
;;      direx:closed-icon "▸ ")

;; joseph-single-dired.el
;; diredのバッファが増えないようにする
;; Emacs mail magazine
;; https://github.com/jixiuf/joseph-single-dired
;; https://raw.github.com/jixiuf/joseph-single-dired/master/joseph-single-dired.el
(when (require 'joseph-single-dired nil t)
  (eval-after-load 'dired '(require 'joseph-single-dired))
  )

;; dired-filetype-face.el
;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
;; Emacs mail magazine
(require 'dired-filetype-face nil t)

;; マークしたファイルを引数にeshellを起動する
;; Emacs mail magazine
(defun dired-start-eshell (arg)
  "diredで選択されたファイル名がペーストされた状態で、eshellを起動する。"
  (interactive "P")
  (let ((files (mapconcat 'shell-quote-argument
                          (dired-get-marked-files (not arg))
                          " ")))
    (if (fboundp 'shell-pop) (shell-pop) (eshell t))
    (save-excursion (insert " " files))))
(define-key dired-mode-map [remap dired-do-shell-command] 'dired-start-eshell)

;; diredでマークをつけたファイルを開く
;; http://d.hatena.ne.jp/oh_cannot_angel/20101216/1292506110
;; (eval-after-load "dired"
;;   '(progn
;;      (define-key dired-mode-map (kbd "F") 'my-dired-find-marked-files)
;;      (defun my-dired-find-marked-files (&optional arg)
;;        "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
;;        (interactive "P")
;;        (let* ((fn-list (dired-get-marked-files nil arg)))
;;          (mapc 'find-file fn-list)))))

;; diredでマークをつけたファイルをviewモードで開く
;; http://d.hatena.ne.jp/oh_cannot_angel/20101216/1292506110
;; (eval-after-load "dired"
;;   '(progn
;;      (define-key dired-mode-map (kbd "V") 'my-dired-view-marked-files)
;;      (defun my-dired-view-marked-files (&optional arg)
;;        "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
;;        (interactive "P")
;;        (let* ((fn-list (dired-get-marked-files nil arg)))
;;          (mapc 'view-file fn-list)))))

;;----------------------------------------------------------------------------
;; recentf
;;----------------------------------------------------------------------------
;; 最近使ったファイル M-x recentf-open-files　を有効化
(when (require 'recentf nil t)
  (setq recentf-exclude '("~/.emacs.d/resource/.recentf"))
  (setq recentf-save-file (expand-file-name "~/.emacs.d/resource/.recentf" user-emacs-directory))
  (setq recentf-max-saved-items 2000)
  (setq recentf-auto-cleanup 10)
  (run-with-idle-timer 30 t 'recentf-save-list)
  (recentf-mode 1)
  )
;;(recentf-mode 1)
;; 最近使ったファイル500件を履歴として保存する
;;(setq recentf-max-saved-items 500)
;; .recentfを自動保存する
;; http://d.hatena.ne.jp/tomoya/20110217/1297928222
; (when (require 'recentf nil t)
;;   (setq recentf-max-saved-items 2000)
;;  (setq recentf-exclude '(".recentf"))
;; (setq recentf-auto-cleanup 10)
;; (setq recentf-auto-save-timer
;;       (run-with-idle-timer 30 t 'recentf-save-list))
;; (recentf-mode 1))

;; recentf-ext.el
;; http://d.hatena.ne.jp/rubikitch/20091224/recentf
(when (require 'recentf-ext nil t))

;; C-@ で最近使ったファイルを表示
;;(define-key global-map "\C-@" 'recentf-open-files)

;; こんな設定もできる。
;; http://masutaka.net/chalow/2011-10-30-2.html
(require 'cl)
(defvar my-recentf-list-prev nil)
(defadvice recentf-save-list
  (around no-message activate)
  "If `recentf-list' and previous recentf-list are equal,
do nothing. And suppress the output from `message' and
`write-file' to minibuffer."
  (unless (equal recentf-list my-recentf-list-prev)
    (flet ((message (format-string &rest args)
		    (eval `(format ,format-string ,@args)))
	   (write-file (file &optional confirm)
		       (let ((str (buffer-string)))
			 (with-temp-file file
			   (insert str)))))
      ad-do-it
      (setq my-recentf-list-prev recentf-list))))

(defadvice recentf-cleanup
  (around no-message activate)
  "suppress the output from `message' to minibuffer"
  (flet ((message (format-string &rest args)
		  (eval `(format ,format-string ,@args))))
    ad-do-it))

;;----------------------------------------------------------------------------
;; 各種elisp
;;----------------------------------------------------------------------------
;; switch-window.el
;; http://d.hatena.ne.jp/tomoya/20100807/1281150227
(when (require 'switch-window nil t) ; C-x o が dim:switch-window になる
  (define-key global-map (kbd "C-t") 'other-window) ; C-t に other-window
  )

;; popwin.el
;; http://d.hatena.ne.jp/m2ym/20110120
(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  (setq anything-samewindow nil)
  (push '("*anything*" :height 20) popwin:special-display-config)
  (push '("*Warnings*" :height 20) popwin:special-display-config)
  (push '("*anything complete*" :height 20) popwin:special-display-config)
  (push '("*MozRepl*" :height 20) popwin:special-display-config)
  (push '("*MozRepl Error*" :height 20) popwin:special-display-config)
  (push '("*Procces List*" :height 20) popwin:special-display-config)
  (push '("*Messages*" :height 20) popwin:special-display-config)
  (push '("*Backtrace*" :height 20) popwin:special-display-config)
  (push '("*Compile-Log*" :height 20) popwin:special-display-config)
  ;; http://valvallow.blogspot.com/2011/03/emacs-popwinel.html
  (push '("*Remember*" :height 20) popwin:special-display-config)
  ;(push '("*Selection Ring: `kill-ring'*" :height 20) popwin:special-display-config)
  (push '("*undo-tree*" :height 20) popwin:special-display-config)
  )

;; color-moccur.el
;; http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
;; anythingとの連携あり
;; http://www.bookshelf.jp/soft/meadow_50.html#SEC746
;; http://www.bookshelf.jp/elc/color-moccur.el
(when (require 'color-moccur nil t)
  (setq moccur-split-word t)
  ;; http://fkmn.exblog.jp/7311776/
  (setq dmoccur-exclusion-mask
        (append '("\\~$" "\\.svn\\/\*") dmoccur-exclusion-mask))
  (setq dmoccur-exclusion-mask
        (append '("\\~$" "\\.jpg\\/\*") dmoccur-exclusion-mask))
  (setq dmoccur-exclusion-mask
        (append '("\\~$" "\\.gif\\/\*") dmoccur-exclusion-mask))
  (setq dmoccur-exclusion-mask
        (append '("\\~$" "\\.tsv\\/\*") dmoccur-exclusion-mask))
  (setq dmoccur-exclusion-mask
        (append '("\\~$" "\\.log\\/\*") dmoccur-exclusion-mask))
  )

;; moccur-edit.el
;; http://www.bookshelf.jp/elc/moccur-edit.el
(require 'moccur-edit nil t)

;; undo-tree.el
;; http://d.hatena.ne.jp/khiker/20100123/undo_tree
;; http://www.dr-qubit.org/undo-tree/undo-tree.el
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; undohist.el
(when (require 'undohist nil t)
  (undohist-initialize))

;; point-undo.el
;; こんな対応が必要らしい http://randd.kwappa.net/2011/03/10/258
(when (require 'point-undo nil t)
  (define-key global-map (kbd "<f7>") 'point-undo)
  (define-key global-map (kbd "S-<f7>") 'point-redo))

;; redo+.el
;; (when (require 'redo+ nil t)
;;   (define-key global-map (kbd "C-_") 'redo))

;; sequential-command.el C-a C-e の挙動変更
;; http://emacs.g.hatena.ne.jp/k1LoW/20101211/1292046538
(when (require 'sequential-command nil t)
  (define-sequential-command seq-home
    back-to-indentation  beginning-of-line beginning-of-buffer seq-return)
  (global-set-key "\C-a" 'seq-home)
  (define-sequential-command seq-end
    end-of-line end-of-buffer seq-return)
  (global-set-key "\C-e" 'seq-end)
  ;; (require 'sequential-command-config)
  ;; (sequential-command-setup-keys)
  )

;; smartchr.el =文字列まとめ
;; http://tech.kayac.com/archive/emacs-tips-smartchr.html
(when (require 'smartchr nil t)
  (global-set-key (kbd "=") (smartchr '("=" " = " " == " " === ")))
  (global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
  (global-set-key (kbd "<") (smartchr '("<" " << ")))
  (global-set-key (kbd "&") (smartchr '("&" " && ")))
  (global-set-key (kbd "|") (smartchr '("|" " || ")))
  )

;; key-combo.el
;; smartchr.elとsequential-command.el両方行ける
;; http://d.hatena.ne.jp/uk-ar/searchdiary?word=%2A%5BKey-combo%5D
;; https://github.com/uk-ar/key-combo/
;; https://github.com/uk-ar/key-combo/raw/177bf94345c532e3dc4c29388a4f160b5241e818/key-combo.el
;;(require 'key-combo)
;;(key-combo-load-default)

;; e2wm.el
;; http://d.hatena.ne.jp/kiwanami/20100528/1275038929
;; https://github.com/kiwanami/emacs-window-manager
;; 最小の e2wm 設定例
(when (require 'e2wm nil t)
  (global-set-key (kbd "M-+") 'e2wm:start-management)
  (e2wm:add-keymap e2wm:pst-minor-mode-keymap '(("prefix v" . e2wm:dp-svn)) e2wm:prefix-key)
  ;; 終了する場合は「C-c ; Q」だけどsticky.elの影響でだめ
  )

;; dsvn.el
;; Subversion用の設定 (psvn.elとdsvn.elを併用)
;; http://d.hatena.ne.jp/hamaco/20090218/1234962837
;; http://www23.atwiki.jp/selflearn/pages/41.html
;; (require 'psvn)
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(setq process-coding-system-alist '(("svn" . utf-8)))
(setq default-file-name-coding-system 'utf-8)
(setq svn-status-svn-file-coding-system 'utf-8)
(setq svn-status-svn-process-coding-system 'utf-8)
(add-hook 'diff-mode-hook
          (lambda ()
            (set-face-foreground 'diff-context-face "grey50")
            (set-face-background 'diff-header-face "black")
            (set-face-underline-p 'diff-header-face t)
            (set-face-foreground 'diff-file-header-face "MediumSeaGreen")
            (set-face-background 'diff-file-header-face "black")
            (set-face-foreground 'diff-index-face "MediumSeaGreen")
            (set-face-background 'diff-index-face "black")
            (set-face-foreground 'diff-hunk-header-face "plum")
            (set-face-background 'diff-hunk-header-face"black")
            (set-face-foreground 'diff-removed-face "pink")
            (set-face-background 'diff-removed-face "gray5")
            (set-face-foreground 'diff-added-face "light green")
            (set-face-foreground 'diff-added-face "white")
            (set-face-background 'diff-added-face "SaddleBrown")
            (set-face-foreground 'diff-changed-face "DeepSkyBlue1")))

;; js2-mode
;; https://github.com/mooz/js2-mode
;; https://raw.github.com/mooz/js2-mode/04fbc13b5be66bf9876560e3be33dfd486e9fa56/js2-mode.el
;; originalではなくid:moozの拡張版を利用
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode)) ;; for rails

;; session.el
;; http://maruta.be/intfloat_staff/101
(when (require 'session nil t)
  (add-hook 'after-init-hook 'session-initialize)
  (setq session-save-file "~/.emacs.d/resource/.session")
  ;;(setq history-length 200) ;; そもそものミニバッファ履歴リストの最大長
  ;;(setq session-initialize '(de-saveplace session keys menus places)
  ;;      session-globals-include '((kill-ring 50)             ;; kill-ring の保存件数
  ;;                                (session-file-alist 50 t)  ;; カーソル位置を保存する件数
  ;;                                (file-name-history 200)))  ;; ファイルを開いた履歴を保存する件数
  )

;; savekill.el
;; http://d.hatena.ne.jp/rubikitch/20110226/
(when (require 'savekill nil t)
  (setq save-kill-file-name "~/.emacs.d/resource/kill-ring-saved.el")
  )

;; quickrun.el
;; https://github.com/syohex/emacs-quickrun
(when (require 'quickrun nil t)
  (global-set-key [(f9)] 'quickrun)
  )

;; redmine.el
;; http://e-arrows.sakura.ne.jp/2010/03/released-redmine-el.html
;; (when (require 'redmine nil t)
;;   (setq redmine-project-alist
;;         '(("hoge" "http://hogehoge" "hoge")))
;;   )

;; sticky.el
;; 大文字入力を楽にする
(when (require 'sticky nil t)
  (use-sticky-key ";" sticky-alist:ja)
  )

;; google
(load "google2")

;; suggest-restart.el
;; Emacsでメモリ使用量から再起動をおすすめする
;; http://d.hatena.ne.jp/hitode909/20111223
;; https://gist.github.com/1513345
;;(require 'suggest-restart)
;;(suggest-restart t)

;; 鬼軍曹.el
;; https://github.com/k1LoW/emacs-drill-instructor/wiki
;;(require 'drill-instructor)
;;(setq drill-instructor-global t) ;; コメントアウト時はCtrl-hの設定を復活させる

;; scratch-log.el
;; http://d.hatena.ne.jp/kitokitoki/20100612/p1
;; https://github.com/wakaran/scratch-log
;; https://raw.github.com/wakaran/scratch-log/master/scratch-log.el
(when (require 'scratch-log nil t)
  (setq sl-scratch-log-file "~/.emacs.d/resource/.scratch-log")
  (setq sl-prev-scratch-string-file "~/.emacs.d/resource/.scratch-log-prev")
  ;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
  (setq sl-restore-scratch-p t)
  ;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
  ;; (setq sl-prohibit-kill-scratch-buffer-p nil)
  )

;; scratch-ext.el
;; https://github.com/kyanagi/scratch-ext-el
;; https://raw.github.com/kyanagi/scratch-ext-el/master/scratch-ext.el
;; (when (require 'scratch-ext nil t)
;;   (setq scratch-ext-log-directory "~/.emacs.d/.scratch-ext")
;;   )

;; multiverse.el
;; ファイルのスナップショットを取得する
(require 'multiverse nil t)

;; ipa.el
(when (require 'ipa nil t)
  (setq ipa-file "~/.emacs.d/resource/.ipa")
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

  ;;(require 'rename-sgml-tag)
  ;;(define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)
  ;; githubから持ってきただけだとエラーになる．作者のinit.elから設定を拝借
  (add-hook 'sgml-mode-hook
            (lambda ()
              (require 'rename-sgml-tag)
              (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)))
  ;;(require 'js2-rename-var)
  ;;(define-key js2-mode-map (kbd "C-c C-r") 'js2-rename-var)
  ;;(require 'inline-string-rectangle)
  ;;(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

  ;;http://d.hatena.ne.jp/kitokitoki/20120326
  ;; (add-hook 'ruby-mode-hook
  ;;           (lambda ()
  ;;             (modify-syntax-entry ?@ "_" ruby-mode-syntax-table)
  ;;             (modify-syntax-entry ?: "_" ruby-mode-syntax-table)
  ;;             (modify-syntax-entry ?! "_" ruby-mode-syntax-table)))
  )


;; mark-multiple.el
;; https://github.com/magnars/mark-multiple.el
;; http://d.hatena.ne.jp/syohex/20120206/1328540927
(when (require 'mark-more-like-this nil t)
  (global-set-key (kbd "C-<") 'mark-previous-like-this)
  (global-set-key (kbd "C->") 'mark-next-like-this)
  (global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
  )

;; Experimental multiple-cursors
(when (require 'multiple-cursors nil t)
  ;; (global-set-key (kbd "C-S-c C-S-c") 'mc/add-multiple-cursors-to-region-lines)
  ;; (global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
  ;; (global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)
  )

;; grep-a-lot.el
;; Emacs tech book p162
;;(require 'grep-a-lot)
;;(grep-a-lot-setup-keys)

;; http://d.hatena.ne.jp/kitokitoki/20110213/p1
(defvar my-grep-a-lot-search-word nil)
;;上書き
(defun grep-a-lot-buffer-name (position)
  "Return name of grep-a-lot buffer at POSITION."
  (concat "*grep*<" my-grep-a-lot-search-word ">"))

(defadvice rgrep (before my-rgrep (regexp &optional files dir) activate)
  (setq my-grep-a-lot-search-word regexp))

(defadvice lgrep (before my-lgrep (regexp &optional files dir) activate)
  (setq my-grep-a-lot-search-word regexp))

;; grep-edit.el
;; Emacs tech book p163
;;(require 'grep-edit) ; wgrep.elに移行

;; wgrep.el
;; https://github.com/mhayashi1120/Emacs-wgrep
;; https://raw.github.com/mhayashi1120/Emacs-wgrep/master/wgrep.el
(require 'wgrep nil t)

;; color-grep.el
;; http://www.bookshelf.jp/soft/meadow_51.html#SEC778
;; http://www.bookshelf.jp/elc/color-grep.el
(when (require 'color-grep nil t)
  ;; grep バッファを kill 時に，開いたバッファを消す
  (setq color-grep-sync-kill-buffer t)
  )

;; goto-chg.el
;; Emacs tech book p117
(when (require 'goto-chg nil t)
  (define-key global-map (kbd "<f8>") 'goto-last-change)
  (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)
  )

;; key-chord.el
;; http://d.hatena.ne.jp/rubikitch/20081104/1225745862
(when (require 'key-chord nil t)
  (setq key-chord-two-keys-delay 0.04) ;; 同時押しとみなす間隔
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'view-mode)
  (key-chord-define-global "kl" 'jaunte)
  (key-chord-define-global "ij" 'iy-go-to-char)
  (key-chord-define-global "bg" 'iy-go-to-char-backward)
  (key-chord-define-global "oj" 'ace-jump-mode)
  )


;; deferred.el
;; inertial-scroll.el
;; 慣性スクロールする(Mac風)
(when (require 'deferred nil t)
;; (require 'inertial-scroll)
;; (setq inertias-global-minor-mode-map
;;       (inertias-define-keymap
;;        '(
;;          ("<next>"  . inertias-up)
;;          ("<prior>" . inertias-down)
;;          ("C-v"     . inertias-up)
;;          ("M-v"     . inertias-down)
;;          ) inertias-prefix-key))

;; (inertias-global-minor-mode t)
;; (setq inertias-initial-velocity 50) ; 初速（大きいほど一気にスクロールする）
;; (setq inertias-friction 120)        ; 摩擦抵抗（大きいほどすぐ止まる）
;; (setq inertias-rest-coef 0)         ; 画面端でのバウンド量（0はバウンドしない。1.0で弾性反発）
;; (setq inertias-update-time 60)      ; 画面描画のwait時間（msec）
  )

;; github-search.el
;; https://github.com/wakaran/github-search
;; https://raw.github.com/wakaran/github-search/master/github-search.el
(require 'github-search nil t)
;; (defalias 'g 'gs:code-search)
;; (defalias 'ga 'gs:all-search)
;; (defalias 'gu 'gs:user-search)
;; (defalias 'gr 'gs:repositories-search)

;; Evil.el
;; (require 'evil)
;; (evil-mode nil)

;; yaml-mode.el
;; https://github.com/yoshiki/yaml-mode
;; https://raw.github.com/yoshiki/yaml-mode/master/yaml-mode.el
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  )

;; ctags-update.el
;; from marmalede.el
;; http://marmalade-repo.org/packages/ctags-update
(when (require 'ctags-update nil t)
  (ctags-update-minor-mode 1)
  )

;; windows.el
;;(require 'windows)

(when (require 'fold-dwim nil t)
  ;; http://www.bookshelf.jp/pukiwiki/pukiwiki.php?cmd=read&page=Elisp%2Fhideshow.el
  ;; Ruby編集時もソースを隠したり、表示したり・・・
  (add-hook 'ruby-mode-hook
            '(lambda()
               (hs-minor-mode 1)))
  (let ((ruby-mode-hs-info
         '( ruby-mode
            "class\\|module\\|def\\|if\\|unless\\|case\\|while\\|until\\|for\\|begin\\|do"
            "end"
            "#"
            ruby-move-to-block
            nil)))
    (if (not (member ruby-mode-hs-info hs-special-modes-alist))
        (setq hs-special-modes-alist
              (cons ruby-mode-hs-info hs-special-modes-alist))))
  )

;; hiwin.el
;; http://d.hatena.ne.jp/ksugita0510/20111223/p1
;;(require 'hiwin)
;;(hiwin-activate)                           ;; hiwin-modeを有効化
;;(set-face-background 'hiwin-face "gray80") ;; 非アクティブウィンドウの背景色を設定

;; fsvn.el
;;(require 'fsvn)

;; yafastnav.el
;; https://github.com/tm8st/emacs-yafastnav
;; https://raw.github.com/tm8st/emacs-yafastnav/master/yafastnav.el
(when (require 'yafastnav nil t)
  ;;(global-set-key (kbd "C-l C-c") 'yafastnav-jump-to-current-screen)
  ;;(global-set-key (kbd "C-l C-f") 'yafastnav-jump-to-forward)
  ;;(global-set-key (kbd "C-l C-r") 'yafastnav-jump-to-backward)
  )

;; jaunte.el
;; http://kawaguchi.posterous.com/emacshit-a-hint
;; https://github.com/kawaguchi/jaunte.el
;; https://raw.github.com/kawaguchi/jaunte.el/master/jaunte.el
(when (require 'jaunte nil t)
  (global-set-key (kbd "C-c C-j") 'jaunte)
  (setq jaunte-hint-unit 'word);default
  ;;(setq jaunte-global-hint-unit 'symbol)
  )

;; volatile-highlights.el
;; from marmalade
(when (require 'volatile-highlights nil t)
  (volatile-highlights-mode t)
  )

;; smooth-scroll.el
;; from marmalade
;;(require 'smooth-scroll)
;;(smooth-scroll-mode t)

;; iy-go-to-char.el
;; from marmalade
(when (require 'iy-go-to-char nil t)
  (global-set-key (kbd "C-c f") 'iy-go-to-char)
  (global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
  (global-set-key (kbd "C-c ;") 'iy-go-to-char-continue)
  (global-set-key (kbd "C-c ,") 'iy-go-to-char-continue-backward)
  )

;; wrap-region.el sticky.elと競合するのでコメントアウト
;; https://github.com/rejeep/wrap-region
;; http://d.hatena.ne.jp/syohex/20120207/1328629972
;; (when (require 'wrap-region nil t)
;;   ;;グローバルに有効。個別の場合は (wrap-region-mode t)
;;   (wrap-region-global-mode t)
;;   (wrap-region-add-wrapper "$" "$")
;;   (wrap-region-add-wrapper "{-" "-}" "#")
;;   (wrap-region-add-wrapper "/" "/" nil 'ruby-mode)
;;   (wrap-region-add-wrapper "/* " " */" "#" '(java-mode javascript-mode css-mode))
;;   (wrap-region-add-wrapper "`" "`" nil '(markdown-mode ruby-mode))
;;   paredit.elで同様の機能があるため、念の為
;;   (add-to-list 'wrap-region-except-modes 'emacs-lisp-mode)
;;   (add-to-list 'wrap-region-except-modes 'scheme-mode)
;;   (add-to-list 'wrap-region-except-modes 'lisp-mode)
;;   (add-to-list 'wrap-region-except-modes 'clojure-mode)
;;   )

;; open-junk-file.el
(when (require 'open-junk-file nil t)
  (setq open-junk-file-format "~/.emacs.d/junk/%Y-%m-%d-%H%M%S.")
  )

;; ndmacro.el
;; https://github.com/snj14/ndmacro.el
;; https://raw.github.com/snj14/ndmacro.el/master/ndmacro.el
;; e.g. hoge C-m hoge C-m C-t C-t C-t ....
;;      10   C-m 11   C-m C-t C-t C-t ....
(when (require 'ndmacro nil t)
  (global-set-key (kbd "C-3") 'ndmacro)
  )

;; Highlighting indentation for Emacs
;; https://github.com/antonj/Highlight-Indentation-for-Emacs
;; https://raw.github.com/antonj/Highlight-Indentation-for-Emacs/master/highlight-indentation.el
(when (require 'highlight-indentation nil t)
  (set-face-background 'highlight-indentation-face "#e3e3d3")
  (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
  )

;; auto-highlight-symbol-mode.el
;; https://github.com/mitsuo-saito/auto-highlight-symbol-mode
;; https://raw.github.com/mitsuo-saito/auto-highlight-symbol-mode/master/auto-highlight-symbol.el
;; https://github.com/mhayashi1120/auto-highlight-symbol-mode
;; https://raw.github.com/mhayashi1120/auto-highlight-symbol-mode/master/auto-highlight-symbol.el
;; http://d.hatena.ne.jp/yuheiomori0718/20111222/1324562208
;; http://d.hatena.ne.jp/syohex/20110126/1296048465
(when (require 'auto-highlight-symbol nil t)
  (global-auto-highlight-symbol-mode t)
  (ahs-set-idle-interval 5) ;ハイライトまでの待機時間 デフォルトは1秒
  )

(when (require 'image+ nil t)
  (imagex-auto-adjust-mode 1)
  )

;; minimap.el
;; emacs wiki
(require 'minimap nil t)

;; zlc.el
;; http://d.hatena.ne.jp/mooz/20101003/p1
;; https://github.com/mooz/emacs-zlc/
;; https://raw.github.com/mooz/emacs-zlc/master/zlc.el
(when (require 'zlc nil t)
;;(setq zlc-select-completion-immediately t)
  )

;; browse-kill-ring+.el
;; from emacs wiki
(when (require 'browse-kill-ring+ nil t)
  ;; C-g で終了
  ;; http://d.hatena.ne.jp/gan2/20070928/1190989859
  (add-hook 'browse-kill-ring-hook
            (lambda ()
              (define-key browse-kill-ring-mode-map (kbd "\C-g") 'browse-kill-ring-quit)))
  )

;; quick-jump.el
;; https://github.com/jixiuf/quick-jump
;; https://raw.github.com/jixiuf/quick-jump/master/quick-jump.el
;; bm.elがあれば不要かも？
(require 'quick-jump nil t)

;; *Completions*バッファを，使用後に消してくれる
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part11
(when (require 'lcomp nil t)
  (lcomp-install)
  )

;; maximize.el
;; https://github.com/izawa/maximize
;; https://raw.github.com/izawa/maximize/master/maximize.el
(when (require 'maximize nil t)
  (global-set-key [(f12)] 'maximize-toggle-frame-vmax)
  (global-set-key [(shift f12)] 'maximize-toggle-frame-hmax)
  )

;; ace-jump-mode.el
;; http://d.hatena.ne.jp/syohex/20120304/1330822993
;; https://github.com/winterTTr/ace-jump-mode
;; https://raw.github.com/winterTTr/ace-jump-mode/master/ace-jump-mode.el
(when (require 'ace-jump-mode nil t)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  )

;; file-column-indicator.el
;; https://github.com/alpaker/Fill-Column-Indicator
(when (require 'fill-column-indicator nil t)
  (setq fci-rule-column 160)
  )

;; pomodoro.el
;; https://github.com/docgnome/pomodoro.el
;; https://raw.github.com/docgnome/pomodoro.el/master/pomodoro.el
(require 'pomodoro nil t)
;; 別の作者。違いは要確認
;; https://github.com/vderyagin/pomodoro.el

;; diminish.el
;; (when (require 'diminish nil t)
;;   (diminish 'undo-tree-mode)
;;   (diminish 'yas/minor-mode)
;;   (diminish 'volatile-highlights-mode)
;;   )

;; fic-mode.el
;; https://github.com/lewang/fic-mode
;; highlight word is TODO or FIXME
(require 'fic-mode nil t)

;; 自動コンパイル
;; http://www.emacswiki.org/emacs/auto-async-byte-compile.el
(when (require 'auto-async-byte-compile nil t)
  ;; 自動コンパイルを無効にするファイル名の正規表現
  (setq auto-async-byte-compile-exclude-files-regexp "init.el")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
  )

;; fcopy.el
;; https://aw.github.com/ataka/fcopy/master/fcopy.el
;; https://raw.github.com/ataka/fcopy/master/fcopy.el
(autoload 'fcopy-mode "fcopy" "copy lines or region without editing." t)

;; rainbow-mode.el
(require 'rainbow-mode nil t)

;;----------------------------------------------------------------------------
;; bm.el
;; from marmalade
;; Emacs tech Book p116
;; http://d.hatena.ne.jp/kenkov/20110507/1304754238
;; http://d.hatena.ne.jp/peccu/20100402
;; https://github.com/joodland/bm/blob/master/bm.el
;;----------------------------------------------------------------------------
(when (require 'bm nil t)
  ;; マークのセーブ
  (setq-default bm-buffer-persistence t)
  (setq bm-repository-file "~/.emacs.d/resource/.bm-repository")
  ;; 起動時に設定のロード
  (setq bm-restore-repository-on-load t)
  (add-hook 'after-init-hook 'bm-repository-load)
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  ;; 設定ファイルのセーブ
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'auto-save-hook 'bm-buffer-save)
  (add-hook 'after-save-hook 'bm-buffer-save)
  (add-hook 'vc-before-checkin-hook 'bm-buffer-save)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  (global-set-key (kbd "<M-f2>") 'bm-toggle)
  (global-set-key (kbd "M-[") 'bm-previous)
  (global-set-key (kbd "M-]") 'bm-next)
  ;Saving the repository to file when on exit.
  ;kill-buffer-hook is not called when emacs is killed, so we
  ;must save all bookmarks first.
  (add-hook 'kill-emacs-hook '(lambda nil
                                (bm-buffer-save-all)
                                (bm-repository-save)))

  ;; http://d.hatena.ne.jp/peccu/20100402/bmglobal
  (defvar anything-c-source-bm-global-use-candidates-in-buffer
    '((name . "Global Bookmarks")
      (init . anything-c-bm-global-init)
      (candidates-in-buffer)
      (type . file-line))
    "show global bookmarks list.
Global means All bookmarks exist in `bm-repository'.

Needs bm.el.
http://www.nongnu.org/bm/")
  )
;; (anything 'anything-c-source-bm-global-use-candidates-in-buffer)
(defvaralias 'anything-c-source-bm-global 'anything-c-source-bm-global-use-candidates-in-buffer)
;; (anything 'anything-c-source-bm-global)

(defun anything-c-bm-global-init ()
  "Init function for `anything-c-source-bm-global'."
  (when (require 'bm nil t)
    (with-no-warnings
      (let ((files bm-repository)
            (buf (anything-candidate-buffer 'global)))
        (dolist (file files)            ;ブックマークされてるファイルリストから，1つ取り出す
          (dolist (bookmark (cdr (assoc 'bookmarks (cdr file)))) ;1つのファイルに対して複数のブックマークがあるので
            (let ((position (cdr (assoc 'position bookmark))) ;position
                  (annotation (cdr (assoc 'annotation bookmark))) ;annotation
                  (file (car file))                               ;file名を取り出す
                  line
                  str)
              (setq str (with-temp-buffer (insert-file-contents-literally file) ;anything用の文字列にformat
                               (goto-char position)
                               (beginning-of-line)
                               (unless annotation
                                   (setq annotation ""))
                               (if (string= "" line)
                                   (setq line  "<EMPTY LINE>")
                                 (setq line (car (split-string (thing-at-point 'line) "[\n\r]"))))
                               (format "%s:%d: [%s]: %s\n" file (line-number-at-pos) annotation line)))
              (with-current-buffer buf (insert str)))))))))

;;----------------------------------------------------------------------------
;; twittering-mode.el
;; http://www.emacswiki.org/emacs/TwitteringMode-ja
;;----------------------------------------------------------------------------
(when (require 'twittering-mode nil t)
  ;;(setq twittering-use-master-password t)
  (setq twittering-icon-mode nil)
  )

;;----------------------------------------------------------------------------
;; migemo.el
;; http://gist.github.com/457761
;;----------------------------------------------------------------------------
;; cmigemoを使用
;; migemoのon/offはM-mで切り替え可能
;; インストール方法
;; WEB + DB press vol.58 ← 今回はこちら
;; http://d.hatena.ne.jp/samurai20000/20100907/1283791433
;; 設定(2パターン)
;; http://d.hatena.ne.jp/samurai20000/20100907/1283791433
;; migemo-commandの部分は下記参照
;; http://d.hatena.ne.jp/ground256/20111008/1318063872
(when (require 'migemo nil t)
  ;; デフォルトではmigemoを無効にする
  ;; http://www.meadowy.org/meadow/netinstall/wiki/PkgMigemo#a.emacs
  (setq migemo-isearch-enable-p nil)

  (setq migemo-command "/usr/local/bin/cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  ;; WEB + DB Press vol.58
  ;; (when (and (executable-find "cmigemo")
  ;;            (require 'migemo nil t))
  ;;            (setq migemo-command "/usr/local/bin/cmigemo")
  ;;            (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  ;;            (setq migemo-dictionary
  ;;                  "/usr/local/share/migemo/utf-8/migemo-dict")
  ;;            (setq migemo-use-dictionary nil)
  ;;            (setq migemo-regex-dictionary nil)
  ;;            (setq migemo-use-pattern-alist t)
  ;;            (setq migemo-use-frequent-pattern-alist t)
  ;;            (setq migemo-pattern-alist-length 1000)
  ;;            (setq migemo-coding-system 'utf-8-unix)
  ;;            (migemo-init))
  )

;;----------------------------------------------------------------------------
;; calfw.el
;; http://d.hatena.ne.jp/kiwanami/20110723/1311434175
;;----------------------------------------------------------------------------
(when (require 'calfw nil t) ; 初回一度だけ
  (cfw:open-calendar-buffer) ; カレンダー表示
  )

;; calfw-org.el
(require 'calfw-org nil t)

;; japanese-holiday.el
(add-hook 'calendar-load-hook
          (lambda ()
            (when (require 'japanese-holidays nil t)
              (setq calendar-holidays
                    (append japanese-holidays local-holidays other-holidays)))))

;; 月
(setq calendar-month-name-array
  ["January" "February" "March"     "April"   "May"      "June"
   "July"    "August"   "September" "October" "November" "December"])

;; 曜日
(setq calendar-day-name-array
      ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"])

;; 週の先頭の曜日
(setq calendar-week-start-day 0) ; 日曜日は0, 月曜日は1

;;----------------------------------------------------------------------------
;; Smartrep.el
;; http://sheephead.homelinux.org/2011/12/19/6930/
;; https://github.com/myuhe/smartrep.el
;; https://raw.github.com/tkf/smartrep.el/master/smartrep.el
;;----------------------------------------------------------------------------
(when (require 'smartrep nil t)
  (setq orig-binding (key-binding "\C-l")) ; default key bind backup
  (progn
    (global-set-key "\C-l" nil)
    (smartrep-define-key
        global-map "C-l"
      '(("SPC" . 'scroll-up)
        ("b" . 'scroll-down)
        ("l" . 'forward-char)
        ("h" . 'backward-char)
        ("j" . 'next-line)
        ("k" . 'previous-line)
        ("i" . 'keyboard-quit)))
    )
  (global-set-key "\C-l\C-l" 'recenter-top-bottom)
  ;;(global-set-key "\C-l" orig-binding) ; default key bind revert


  ;; mark-multiple
  (progn
    (smartrep-define-key
        global-map "C-l"
      '(("n" . 'mark-next-like-this)
        ("p" . 'mark-previous-like-this))))

  ;; org-mode
  (eval-after-load "org"
    '(progn
       (smartrep-define-key
           org-mode-map "C-c"
         ;; '(("C-n" . 'outline-next-visible-heading)
         ;;   ("C-p" . 'outline-previous-visible-heading)))))
         '(("n" . 'outline-next-visible-heading)
           ("p" . 'outline-previous-visible-heading)))))
  )

;;----------------------------------------------------------------------------
;; view-mode
;; Emacs mail magazine
;;----------------------------------------------------------------------------
;; f11でview-modeに
;; key-chord.elでjk同時押しも設定してある。
(progn
  (setq pager-keybind
        `( ;; vi-like
          ("h" . backward-char)
          ("l" . forward-char)
          ("j" . next-line)
          ("k" . previous-line)
          ("b" . scroll-down)
          (" " . scroll-up)
          ("w" . forward-word)
          ("e" . backward-word)
          ("J" . ,(lambda () (interactive) (scroll-up 1)))
          ("K" . ,(lambda () (interactive) (scroll-down 1)))
          ))
  (defun define-many-keys (keymap key-table &optional includes)
    (let (key cmd)
      (dolist (key-cmd key-table)
        (setq key (car key-cmd)
              cmd (cdr key-cmd))
        (if (or (not includes) (member key includes))
            (define-key keymap key cmd))))
    keymap)
  (defun view-mode-hook--pager ()
    (define-many-keys view-mode-map pager-keybind))
  (add-hook 'view-mode-hook 'view-mode-hook--pager)
  (global-set-key [f11] 'view-mode)
  )
;; 書き込み不能ファイルのバッファに対しては真赤
;; その他のview-modeバッファに対してはオレンジ
(progn
  (require 'viewer)
  (viewer-stay-in-setup)
  (setq viewer-modeline-color-unwritable "tomato"
        viewer-modeline-color-view "orange")
  (viewer-change-modeline-color-setup))

;; insert-mode
(defun my/view-insert ()
  (interactive)
  (toggle-read-only))
(define-key view-mode-map (kbd "i") 'my/view-insert)

(defun my/view-insert-bol ()
  (interactive)
  (back-to-indentation)
  (toggle-read-only))
(define-key view-mode-map (kbd "I") 'my/view-insert-bol)

(defun my/view-insert-after ()
  (interactive)
  (unless (eolp)
      (forward-char))
  (toggle-read-only))
(define-key view-mode-map (kbd "a") 'my/view-insert-after)

(defun my/view-insert-eol ()
  (interactive)
  (end-of-line)
  (toggle-read-only))
(define-key view-mode-map (kbd "A") 'my/view-insert-eol)

(defun my/view-insert-next-line ()
  (interactive)
  (toggle-read-only)
  (end-of-line)
  (newline-and-indent))
(define-key view-mode-map (kbd "o") 'my/view-insert-next-line)

(defun my/view-insert-prev-line ()
  (interactive)
  (beginning-of-line)
  (toggle-read-only)
  (save-excursion
    (newline)))
(define-key view-mode-map (kbd "O") 'my/view-insert-prev-line)

;; bm.elの設定
;; Emacs tech Book p218
(define-key view-mode-map (kbd "m") 'bm-toggle)
(define-key view-mode-map (kbd "[") 'bm-previous)
(define-key view-mode-map (kbd "]") 'bm-next)

;;----------------------------------------------------------------------------
;; Buffer関連
;;----------------------------------------------------------------------------
;; バッファ一覧を詳細に
(global-set-key "\C-x\C-b" 'bs-show)
;; ミニバッファの履歴を【C-r】でインクリメンタルサーチできるように
(require 'minibuf-isearch)

;; i-searchでのBS有効
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
;; isearch の終了時のカーソル位置を常に検索語の後ろにする
;; http://www.bookshelf.jp/soft/meadow_49.html#SEC716
(define-key isearch-mode-map "\M-m" 'isearch-exit)
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (cond
             ((eq last-input-char ?\C-m)
              (goto-char (match-end 0)))
             ((eq last-input-char ?\M-m)
              (goto-char (match-beginning 0))))))

;; iswitchb.el
;; Emacs本より
;;(iswitchb-mode t) ;; anythingがあるのでコメントアウト
;; バッファ読み取り関数を iswitchb にする
(setq read-buffer-function 'iswitchb-read-buffer)
;; 部分文字列の代わりに正規表現を使う場合はtに設定
(setq iswitchb-regexp nil)
;; 新しいバッファを作成するときにいちいち聞いてこない
(setq iswitchb-prompt-newbuffer nil)

;; バッファ移動を一瞬で行う
;; http://d.hatena.ne.jp/rubikitch/20111211/smalldisplay
;;; last-buffer
(defvar last-buffer-saved nil)
;; last-bufferで選択しないバッファを設定
(defvar last-buffer-exclude-name-regexp
  (rx (or "*mplayer*" "*Completions*" "*Org Export/Publishing Help*" "*Messages*" "*anything*" "*Warnings*" "*Packages*" "TAGS"
          (regexp "^ "))))
(defun record-last-buffer ()
  (when (and (one-window-p)
             (not (eq (window-buffer) (car last-buffer-saved)))
             (not (string-match last-buffer-exclude-name-regexp
                                (buffer-name (window-buffer)))))
    (setq last-buffer-saved
          (cons (window-buffer) (car last-buffer-saved)))))
(add-hook 'window-configuration-change-hook 'record-last-buffer)
(defun switch-to-last-buffer ()
  (interactive)
  (condition-case nil
      (switch-to-buffer (cdr last-buffer-saved))
    (error (switch-to-buffer (other-buffer)))))

(defun switch-to-last-buffer-or-other-window ()
  (interactive)
  (if (one-window-p t)
      (switch-to-last-buffer)
    (other-window 1)))
(global-set-key (kbd "\C-t") 'switch-to-last-buffer-or-other-window)

;; cycle-buffer.el
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=cyclebuf
(autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
(autoload 'cycle-buffer-backward
  "cycle-buffer" "Cycle backward." t)
(autoload 'cycle-buffer-permissive
  "cycle-buffer" "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive
  "cycle-buffer" "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting
  "cycle-buffer" "Toggle if this buffer will be considered." t)
(global-set-key [(f9)]        'cycle-buffer-backward)
(global-set-key [(f10)]       'cycle-buffer)
(global-set-key [(shift f9)]  'cycle-buffer-backward-permissive)
(global-set-key [(shift f10)] 'cycle-buffer-permissive)

;;----------------------------------------------------------------------------
;; auto-complete
;; http://cx4a.org/software/auto-complete/manual.ja.html
;;----------------------------------------------------------------------------
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
  (ac-config-default)
  ;; (add-hook 'auto-complete-mode-hook
  ;;           (lambda ()
  ;;             (define-key ac-completing-map (kbd "C-n") 'ac-next)
  ;;             (define-key ac-completing-map (kbd "C-p") 'ac-previous)))
)

;; auto-complete-ruby.el
;; http://d.hatena.ne.jp/tkng/20090207/1234020003
(add-to-list 'load-path (expand-file-name "~/.rvm/gems/jruby-1.6.5/gems/rcodetools-0.8.5.0"))
(when (require 'auto-complete nil t)
  (when (require 'auto-complete-config nil t))
  (when (require 'auto-complete-ruby nil t))
  (setq ac-comphist-file "~/.emacs.d/resource/auto-complete/ac-comphist.dat")
  (global-auto-complete-mode t)
  (setq ac-dwim nil)
  (set-face-background 'ac-selection-face "steelblue")
  (setq ac-auto-start t)
  (global-set-key "\M-q" 'ac-start)
  (setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
  (add-hook 'ruby-mode-hook
            (lambda ()
              (when (require 'rcodetools nil t))
              (when (require 'auto-complete-ruby nil t))
              (make-local-variable 'ac-omni-completion-sources)
              (setq ac-omni-completion-sources '(("\\.\\=" . (ac-source-rcodetools))))))

  ;; C-n/C-p で候補を選択
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (setq ac-delay 0.5)
  )

;;----------------------------------------------------------------------------
;; org-mode
;;----------------------------------------------------------------------------
;; Emacsでメモ・TODO管理
;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html

(when (require 'org-install nil t)
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cr" 'org-remember)
  (define-key global-map "\C-cc" 'org-remember-code-reading)
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (org-remember-insinuate)
  (setq org-directory "~/.emacs.d/memo/")
  (setq org-default-notes-file (concat org-directory "agenda.org"))
  (setq org-agenda-files '("~/.emacs.d/memo/agenda.org" "~/.emacs.d/memo/code-reading.org"))
  (setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
        ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
        ))

  ;; org-remember-code-reading-mode
  ;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
  (defvar org-code-reading-software-name nil)
  ;; ~/memo/code-reading.org に記録する
  (defvar org-code-reading-file "~/.emacs.d/memo/code-reading.org")
  (defun org-code-reading-read-software-name ()
    (set (make-local-variable 'org-code-reading-software-name)
         (read-string "Code Reading Software: "
                      (or org-code-reading-software-name
                          (file-name-nondirectory
                           (buffer-file-name))))))
  (defun org-code-reading-get-prefix (lang)
    (concat "[" lang "]"
            "[" (org-code-reading-read-software-name) "]"))
  (defun org-remember-code-reading ()
    (interactive)
    (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
           (org-remember-templates
            `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
               ,org-code-reading-file "Memo"))))
      (org-remember)))

  ;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
  (defun org-next-visible-link ()
    "Move forward to the next link.
If the link is in hidden text, expose it."
    (interactive)
    (when (and org-link-search-failed (eq this-command last-command))
      (goto-char (point-min))
      (message "Link search wrapped back to beginning of buffer"))
    (setq org-link-search-failed nil)
    (let* ((pos (point))
           (ct (org-context))
           (a (assoc :link ct))
           srch)
      (if a (goto-char (nth 2 a)))
      (while (and (setq srch (re-search-forward org-any-link-re nil t))
                  (goto-char (match-beginning 0))
                  (prog1 (not (eq (org-invisible-p) 'org-link))
                    (goto-char (match-end 0)))))
      (if srch
          (goto-char (match-beginning 0))
        (goto-char pos)
        (setq org-link-search-failed t)
        (error "No further link found"))))
  
  (defun org-previous-visible-link ()
    "Move backward to the previous link.
If the link is in hidden text, expose it."
    (interactive)
    (when (and org-link-search-failed (eq this-command last-command))
      (goto-char (point-max))
      (message "Link search wrapped back to end of buffer"))
    (setq org-link-search-failed nil)
    (let* ((pos (point))
           (ct (org-context))
           (a (assoc :link ct))
           srch)
      (if a (goto-char (nth 1 a)))
      (while (and (setq srch (re-search-backward org-any-link-re nil t))
                  (goto-char (match-beginning 0))
                  (not (eq (org-invisible-p) 'org-link))))
      (if srch
          (goto-char (match-beginning 0))
        (goto-char pos)
        (setq org-link-search-failed t)
        (error "No further link found"))))
  (define-key org-mode-map "\M-n" 'org-next-visible-link)
  (define-key org-mode-map "\M-p" 'org-previous-visible-link)
  
  
  ;; M-x anything-org-agenda
  ;; http://d.hatena.ne.jp/r_takaishi/20101218/1292641216
  (when (require 'anything-org-mode nil t))
  
  ;; Emacs tech Book p282
  (setq org-use-fast-todo-selection t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE" "CANCEL(c)")
          (sequence "APPT(A)" "|" "DONE(x)" "CANCEL(c)")))
  (setq org-log-done 'time)
)

;; org-tree-slide.el
;; http://pastelwill.jp/wiki/doku.php?id=emacs:org-tree-slide
;; https://github.com/takaxp/org-tree-slide
;; https://raw.github.com/takaxp/org-tree-slide/master/org-tree-slide.el
(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f6>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f6>") 'org-tree-slide-skip-done-toggle)
  ;; エフェクト無効化
  (org-tree-slide-simple-profile)
  )

;;----------------------------------------------------------------------------
;; ruby
;;----------------------------------------------------------------------------
;; ruby-mode.el
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)))

;; http://d.hatena.ne.jp/odz/20071222/1198288746
;; 最終行に空白行を挿入しないようにする
;;(add-hook 'ruby-mode-hook '(lambda () (setq require-final-newline nil)))

;; ruby-electric.el
(when (require 'ruby-electric nil t)
  (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
  )

;; ruby-block.el
(when (require 'ruby-block nil t)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)
  )

;; ruby-indent
(setq ruby-indent-level 2)
(setq ruby-indent-tabs-mode nil)

;; Interactively Do Things (highly recommended, but not strictly required)
;;(require 'ido)
;;(ido-mode t)
;; Rinari
;; https://github.com/eschulte/rinari
(require 'rinari nil t)
;; yasnippet
(when (require 'yasnippet nil t) ;; not yasnippet-bundle
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/snippets")
  ;; rails-snippets
  (yas/load-directory "~/.emacs.d/yasnippets-rails/rails-snippets")
  )
;; anything-c-yasnjppet.el
;; http://d.hatena.ne.jp/shiba_yu36/20100615/1276612642
;; http://d.hatena.ne.jp/sugyan/20120111/1326288445
(when (require 'anything-c-yasnippet nil t)
  (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
  (global-set-key (kbd "C-c y") 'anything-c-yas-complete) ;C-c yで起動
  )



;; yasnippetのインデント
;; http://d.hatena.ne.jp/rubikitch/20080420/1208697562
(defun yas/indent-snippet ()
  (indent-region yas/snippet-beg yas/snippet-end)
  (indent-according-to-mode))
(add-hook 'yas/after-exit-snippet-hook 'yas/indent-snippet)

;; rvm.el
(when (require 'rvm nil t)
  (rvm-use-default) ;; use rvm's default ruby for the current Emacs session
  (defcustom rspec-use-rvm nil
    "t when RVM in is in use. (Requires rvm.el)"
    :type 'boolean
    :group 'rspec-mode)
  (defun rspec-compile ()
    ;; some code.....
    (if rspec-use-rvm
        (rvm-activate-corresponding-ruby))
    ;; more code ..
    )
  )

;; rspec-mode
(when (require 'rspec-mode nil t)
  (custom-set-variables '(rspec-use-rake-flag nil))
  )

;; rhtml-mode.el
;; http://d.hatena.ne.jp/willnet/20090110/1231595231
(when (require 'rhtml-mode nil t)
  (add-hook 'rhtml-mode-hook
            (lambda () (rinari-launch)))
  )

;; anything-rdefs.el
;; http://openlab.dino.co.jp/2011/05/23/184501727.html
(when (require 'anything-rdefs nil t)
  (setq ar:command "~/.emacs.d/script/rdefs.rb")
  (add-hook 'ruby-mode-hook
            (lambda ()
              (define-key ruby-mode-map (kbd "C-@") 'anything-rdefs)))
  )

;; yarm.el (Yet Another Ruby on Rails Minor Mode)
;; https://github.com/k1LoW/emacs-yarm
;; 依存パッケージ historyf.el
;; https://github.com/k1LoW/emacs-historyf
;; https://raw.github.com/k1LoW/emacs-historyf/master/historyf.el
(when (require 'yarm nil t)
;;(global-yarm t)
  )


;; http://d.hatena.ne.jp/kitokitoki/20120310/p1
(defun ffap-ruby-mode (name)
  (shell-command-to-string
   (format "ruby -e 'require %%[rubygems];require %%[devel/which];require %%[%s];
print (which_library (%%[%%s]))'" name name)))

(defun find-ruby-lib (name)
  (interactive "sRuby library name: ")
  (find-file (ffap-ruby-mode name)))

;ffap
(when (require 'ffap nil t)
  (add-to-list 'ffap-alist '(ruby-mode . ffap-ruby-mode))
  )

;;----------------------------------------------------------------------------
;; flymake
;;----------------------------------------------------------------------------
(when (require 'flymake nil t)
  ;; GUIの警告は表示しない
  (setq flymake-gui-warnings-enabled nil)
  ;; I don't like the default colors :)
  (set-face-background 'flymake-errline "red4")
  (set-face-background 'flymake-warnline "dark slate blue")

  ;; Invoke ruby with '-c' to get syntax checking
  ;; http://d.hatena.ne.jp/gan2/20080702/1214972962
  ;; ruby での設定
  (defun flymake-ruby-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list "ruby" (list "-c" local-file))))
  (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
  (add-hook 'ruby-mode-hook
            '(lambda ()

 	     ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
 	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
 		 (flymake-mode)))
          ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
          (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf))

  ;; flymakeのエラー/警告表示をミニバッファで
  ;; http://d.hatena.ne.jp/khiker/20070720/emacs_flymake
  ;; http://quantumfluctuation.blogspot.com/2011/05/flymake.html
  ;; miniBuffer にエラーを出力
  (defun credmp/flymake-display-err-minibuf ()
    ;;   "Displays the error/warning for the current line in the minibuffer"
   (interactive)
   (let* ((line-no             (flymake-current-line-no))
          (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
          (count               (length line-err-info-list))
          )
     (while (> count 0)
       (when line-err-info-list
         (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
                (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                (text (flymake-ler-text (nth (1- count) line-err-info-list))) ;
                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
           (message "[%s] %s" line text)
           )
         )
       (setq count (1- count)))))
  ;;  (defun flymake-show-and-sit ()
  ;;   "Displays the error/warning for the current line in the minibuffer"
  ;;   (interactive)
  ;;   (progn
  ;;     (let* ((line-no (flymake-current-line-no) )
  ;;            (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
  ;;            (count (length line-err-info-list)))
  ;;       (while (> count 0)
  ;;         (when line-err-info-list
  ;;           (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
  ;;                  (full-file
  ;;                   (flymake-ler-full-file (nth (1- count) line-err-info-list)))
  ;;                  (text (flymake-ler-text (nth (1- count) line-err-info-list)))
  ;;                  (line (flymake-ler-line (nth (1- count) line-err-info-list))))
  ;;             (message "[%s] %s" line text)))
  ;;         (setq count (1- count)))))
  ;;   (sit-for 60.0))

  ;; http://d.hatena.ne.jp/sugyan/20100705
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
)

;;----------------------------------------------------------------------------
;; anything.el
;;----------------------------------------------------------------------------
(when (require 'anything-startup nil t)
  (when (require 'anything-config nil t))
  ;;(add-to-list 'anything-sources 'anything-c-source-file-cache)

  ;; https://bitbucket.org/kshimo69/dot_emacs.d/src/33ceff9c8095/conf/init-anything.el
  ;;(defun my-anything ()
  ;;   (interactive)
  ;;   (anything-other-buffer
  ;;    '(anything-c-source-buffers+
  ;;      anything-c-source-recentf
  ;;      anything-c-source-files-in-current-dir
  ;;      anything-c-source-bm-global
  ;;      anything-c-source-emacs-commands
  ;;      anything-c-source-yaetags-)
  ;;    " *my-anything*"))
  ;;(global-set-key (kbd "C-;") 'my-anything)

  (setq anything-sources
        '(anything-c-source-buffers+
          anything-c-source-recentf
          ;;anything-c-source-file-name-history;; 追加
          ;;anything-c-source-locate;; 追加
          ;;anything-c-source-imenu;; 追加
          ;;anything-c-source-emacs-functions
          anything-c-source-files-in-current-dir
          ;;anything-c-source-file-cache
          anything-c-source-bm-global
          anything-c-source-emacs-commands
          anything-c-source-yaetags-select
          ))

  (setq anything-candidate-number-limit 300) ; 表示する最大候補数。デフォルトで 50

  ;; anything 起動
  ;; http://d.hatena.ne.jp/tomoya/20090423/1240456834
  (define-key global-map (kbd "C-;") 'anything) ; そのお隣り
  ;; anything 2重起動エラー対応
  ;; http://d.hatena.ne.jp/yuheiomori0718/20120119/1326976493
  (define-key anything-map (kbd "C-;") 'abort-recursive-edit)
  )

;; anything-c-moccur.el
;; http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
(when (require 'anything-c-moccur nil t)
  ;;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
  (setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
        anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
        anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
        anything-c-moccur-enable-initial-pattern nil) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

;;; キーバインドの割当(好みに合わせて設定してください)
  (global-set-key (kbd "C-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
  (add-hook 'dired-mode-hook ;dired
            '(lambda ()
               (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
  )

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rspec-use-rake-flag nil)
 '(safe-local-variable-values (quote ((encoding . utf-8) (encoding . UTF-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; anything-replace-string.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20110107/1294408979
(require 'anything-replace-string nil t)

;; anything-advent-calendar.el (期間限定)
;; http://gongo.hatenablog.com/entry/2011/12/12/000301
(require 'anything-advent-calendar nil t)

;; anything-c-kill-ring
;; yankをpopupで表示する
;; http://www.flatz.jp/archives/2172
;;anything で対象とするkill-ring の要素の長さの最小値.
;;(setq anything-kill-ring-threshold 5) ;;デフォルトは 10.
;;(global-set-key (kbd "M-y") 'anything-show-kill-ring)

;; split-root.el
;; anythingを常に下部に表示する設定
;; http://emacs.g.hatena.ne.jp/k1LoW/20090713/1247496970
;; (require 'split-root)
;; (defvar anything-compilation-window-height-percent 50.0)
;; (defun anything-compilation-window-root (buf)
;;   (setq anything-compilation-window
;;         (split-root-window (truncate (* (window-height)
;;                                         (/ anything-compilation-window-height-percent
;;                                            100.0)))))
;;   (set-window-buffer anything-compilation-window buf))
;; (setq anything-display-function 'anything-compilation-window-root)

;; anythingで正規表現のかわりにglobを使えるようにする
;; http://d.hatena.ne.jp/buzztaiki/20110123
;;(require 'amp-glob)
;;(amp-glob-mode 1)

;; anything-project.el
;; http://d.hatena.ne.jp/yuheiomori0718/20111226/1324902529
(when (require 'anything-project nil t)
;(global-set-key (kbd "C-c C-f") 'anything-project)
  (global-set-key (kbd "C-:") 'anything-project)
  (ap:add-project
   :name 'hoge
   :look-for '("Rakefile")
   :include-regexp '("\\.rb$" "\\.html$" "\\.erb$" "\\.js$" "\\.yml$" "\\Gemfile$")
   ;:exclude-regexp "/test_files" ; can be regexp or list of regexp
   )
  ;; 候補にディレクトリが含まれないようにする
  ;; http://d.hatena.ne.jp/IMAKADO/20090823/1250963119
  (setq ap:project-files-filters
        (list
         (lambda (files)
           (remove-if 'file-directory-p files))))
  )

;; anything-css.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20120110/1326198461
(require 'anything-css nil t)

;; anything-imenu起動
;;(define-key global-map (kbd "<f12>") 'anything-imenu)
(define-key global-map (kbd "C-c i") 'anything-imenu)

;; anything-exuberant-ctags.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20110809/1312896254
(when (require 'anything-exuberant-ctags nil t)
  (setq anything-exuberant-ctags-enable-tag-file-dir-cache t)
  (setq anything-exuberant-ctags-cache-tag-file-dir "~/Workspace/hoge/")
  )

;; anything-yaetags.el
(when (require 'anything-yaetags nil t)
  ;;(add-to-list 'anything-sources 'anything-c-source-yaetags-select)
  (global-set-key (kbd "M-.") 'anything-yaetags-find-tag)
  )

;; anything-migemo.el
(require 'anything-migemo nil t)

;;---------------------------------------------------------
;; eshell
;;---------------------------------------------------------
;; esh-myparser.el
;; コマンド解釈乗っ取り
;; Emacs mail magazine
(when (require 'esh-myparser nil t)
  (defun eshell-parser/b (str) (eshell-parser/b str "bash"))
  )

;; esh-cmdline-stack.el
;; eshellでコマンドラインスタック機能を実現する
;; Emacs mail magazine
(require 'esh-cmdline-stack nil t)

;; eshellでの実行をbashなどのシェルを利用するように変更
;; Emacs mail magazines
(progn
  (defmacro eval-after-load* (name &rest body)
    (declare (indent 1))
    `(eval-after-load ,name '(progn ,@body)))
  (defun eshell-disable-unix-command-emulation ()
    (eval-after-load* "em-ls"
      (fmakunbound 'eshell/ls))
    (eval-after-load* "em-unix"
      (mapc 'fmakunbound '(eshell/agrep
                           eshell/basename
                           eshell/cat
                           eshell/cp
                           eshell/date
                           eshell/diff
                           eshell/dirname
                           eshell/du
                           eshell/egrep
                           eshell/fgrep
                           eshell/glimpse
                           eshell/grep
                           eshell/info
                           eshell/ln
                           eshell/locate
                           eshell/make
                           eshell/man
                           eshell/mkdir
                           eshell/mv
                           eshell/occur
                           eshell/rm
                           eshell/rmdir
                           eshell/su
                           eshell/sudo
                           eshell/git
                           eshell/time
                           eshell/rake
                           eshell/rspec))))
  (eshell-disable-unix-command-emulation))

;; shell-pop.el and eshell-pop.el
;; Emacs mail magazine
(when (require 'shell-pop nil t)
  (when (require 'eshell-pop nil t)
    (global-set-key (kbd "C-x C-z") 'shell-pop)
    (setq shell-pop-window-height 50) ;; eshell popup window size
    ))

;; キーバインドをshellらしくする
(progn
(defun eshell-in-command-line-p ()
  (<= eshell-last-output-end (point)))
(defmacro defun-eshell-cmdline (key &rest body)
  (let ((cmd (intern (format "eshell-cmdline/%s" key))))
    `(progn
       (add-hook 'eshell-mode-hook
                 (lambda () (define-key eshell-mode-map
(read-kbd-macro ,key) ',cmd)))
       (defun ,cmd ()
         (interactive)
         (if (not (eshell-in-command-line-p))
             (call-interactively (lookup-key (current-global-map)
(read-kbd-macro ,key)))
           ,@body)))))
(defun eshell-history-and-bol (func)
  (delete-region eshell-last-output-end (point-max))
  (funcall func 1)
  (goto-char eshell-last-output-end)))
;; 範囲指定していないとき、C-wで前の単語を削除
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))
;; 前のコマンドの履歴取得
(defun-eshell-cmdline "C-p"
(let ((last-command 'eshell-previous-matching-input-from-input))
  (eshell-history-and-bol 'eshell-previous-matching-input-from-input)))
;; 次のコマンドの履歴取得
(defun-eshell-cmdline "C-n"
(let ((last-command 'eshell-previous-matching-input-from-input))
  (eshell-history-and-bol 'eshell-next-input)))
;; 直前の履歴を取得
(defadvice eshell-send-input (after history-position activate)
(setq eshell-history-index -1))

;;---------------------------------------------------------
;; moz.el
;; Firefoxを操作する
;; http://skalldan.wordpress.com/2011/06/26/firefox-%E3%81%A8-emacs-%E3%81%AE%E4%BC%9A%E8%A9%B1/
;;---------------------------------------------------------
;; (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
;; (moz-minor-mode t)

;; (defun moz-send-message (moz-command)
;;   (comint-send-string
;;    (inferior-moz-process)
;;    (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
;;            moz-repl-name ".setenv('inputMode', 'line'); "
;;            moz-repl-name ".setenv('printPrompt', false); undefined; "))
;;   (comint-send-string
;;    (inferior-moz-process)
;;    (concat moz-command
;;            moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n")))

;; (defun moz-scrolldown ()
;;   (interactive)
;;    (moz-send-message "goDoCommand('cmd_scrollLineDown');\n")) ; 下スクロール
;; (global-set-key (kbd "M-n") 'moz-scrolldown)

;; (defun moz-scrollup ()
;;   (interactive)
;;    (moz-send-message "goDoCommand('cmd_scrollLineUp');\n")) ; 上スクロール
;; (global-set-key (kbd "M-p") 'moz-scrollup)

;; ;; http://blog.livedoor.jp/k1LoW/archives/65023888.html
;; (defun moz-send-reload ()
;;   (interactive)
;;   (comint-send-string (inferior-moz-process)
;;                       (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
;;                               moz-repl-name ".setenv('inputMode', 'line'); "
;;                               moz-repl-name ".setenv('printPrompt', false); undefined; "))
;;   (comint-send-string (inferior-moz-process)
;;                       (concat "content.location.reload();\n"
;;                               moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n"))
;; )

;; (defun reload-moz()
;; (if (string-match "\.\\(css\\|js\\|rb\\|erb\\)$" (buffer-file-name))
;; (moz-send-reload)))
;; (add-hook 'after-save-hook 'reload-moz)

;; ;; ... (適宜追加) ...

;;---------------------------------------------------------
;; Google Chrome edit with emacs
;;---------------------------------------------------------
(when (require 'edit-server nil t)
  (edit-server-start)
  )

;; (if (locate-library "edit-server")
;;     (progn
;;       (require 'edit-server)
;;       (setq edit-server-new-frame nil)
;;       (edit-server-start)))

;;---------------------------------------------------------
;; ddskk
;; http://openlab.ring.gr.jp/skk/index-j.html
;; http://quruli.ivory.ne.jp/document/ddskk_14.2/skk_toc.html#SEC_Contents
;; http://www.bookshelf.jp/texi/skk/skk_4.html#SEC15
;;---------------------------------------------------------
;; http://sheephead.homelinux.org/2010/06/18/1894/
(setq load-path (cons "~/.emacs.d/elisp/skk/" load-path))
(setq skk-user-directory "~/.emacs.d/ddskk/") ; ディレクトリ指定
(setq skk-large-jisyo "~/.emacs.d/ddskk/SKK-JISYO.L")

;; skk用にshift-stickyを";"に設定する
(setq skk-sticky-key ";")

(when (require 'skk-autoloads nil t)
  ;; C-x C-j で skk モードを起動
  (define-key global-map (kbd "C-x j") 'skk-mode)
  ;; .skk を自動的にバイトコンパイル
  (setq skk-byte-compile-init-file t))
(require 'info)
(add-to-list 'Info-additional-directory-list "~/.emacs.d/info")
;;(global-set-key [?\S- ] 'skk-mode)
;;チュートリアルの場所設定
(setq skk-tut-file "~/.emacs.d/ddskk-14.2/etc/SKK.tut")
;; メッセージを日本語で通知する
(setq skk-japanese-message-and-error t)
;; メニューを英語で表示する
(setq skk-show-japanese-menu t)
;; 変換時に注釈 (annotation) を表示する
(setq skk-show-annotation t)
;; 変換候補一覧と注釈 (annotation) を GUI ぽく表示する
(setq skk-show-tooltip t)
;; 変換候補をインラインに表示する
(setq skk-show-inline t)
;; Enter キーを押したときには確定する
(setq skk-egg-like-newline t)
;; 対応する閉括弧を自動的に挿入する
(setq skk-auto-insert-paren t)
;; 句読点を動的に決定する
;; (add-hook 'skk-mode-hook
;;           (lambda ()
;;             (save-excursion
;;               (goto-char 0)
;;               (make-local-variable 'skk-kutouten-type)
;;               (if (re-search-forward "。" 10000 t)
;;                   (setq skk-kutouten-type 'en)
;;                 (setq skk-kutouten-type 'jp)))))
;; 送り仮名が厳密に正しい候補を優先して表示する
(setq skk-henkan-strict-okuri-precedence t)
;; 辞書登録のとき、余計な送り仮名を送らないようにする
(setq skk-check-okurigana-on-touroku 'auto)
;; 変換の学習
(require 'skk-study)
;;単漢字検索のキーを!にする
(setq skk-tankan-search-key ?!)
;; モード表示の色を設定する
(setq skk-indicator-use-cursor-color nil)
(setq skk-emacs-hiragana-face "LimeGreen")
;; 動的補完の可否を判定するより高度な設定例
(setq skk-dcomp-activate
      #'(lambda ()
          (and
           ;; -nw では動的補完をしない。
           window-system
           ;; 基本的に行末のときのみ補完する。ただし行末でなくても現在の
           ;; ポイントから行末までの文字が空白のみだったら補完する。
           (or (eolp)
               (looking-at "[ \t]+$")))))
;; 動的補完で候補を複数表示する
(setq skk-dcomp-multiple-activate t)

;;---------------------------------------------------------
;; Filer
;;---------------------------------------------------------
;; Emacs-nav
;; http://d.hatena.ne.jp/jkbb/20090322/1237698777
(require 'nav nil t)

;;---------------------------------------------------------
;; joke
;;---------------------------------------------------------
;; slコマンド
;; http://d.hatena.ne.jp/khiker/20111222/emacs_sl
(require 'sl nil t)

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
(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'downcase-region 'disabled nil)
