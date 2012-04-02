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
(require 'init-mac nil t)

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
(require 'init-keybind nil t)

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
  (setq save-place-file "~/.emacs.d/.emacs-places"))

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
  (setq save-kill-file-name "~/.emacs.d/resource/kill-ring-saved.el"))

;; quickrun.el
;; https://github.com/syohex/emacs-quickrun
(when (require 'quickrun nil t)
  (global-set-key [(f9)] 'quickrun))

;; redmine.el
;; http://e-arrows.sakura.ne.jp/2010/03/released-redmine-el.html
;; (when (require 'redmine nil t)
;;   (setq redmine-project-alist
;;         '(("hoge" "http://hogehoge" "hoge")))
;;   )

;; sticky.el
;; 大文字入力を楽にする
(when (require 'sticky nil t)
  (use-sticky-key ";" sticky-alist:ja))

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
  (setq ipa-file "~/.emacs.d/resource/.ipa"))

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
  (setq color-grep-sync-kill-buffer t))

;; goto-chg.el
;; Emacs tech book p117
(when (require 'goto-chg nil t)
  (define-key global-map (kbd "<f8>") 'goto-last-change)
  (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse))

;; key-chord.el
;; http://d.hatena.ne.jp/rubikitch/20081104/1225745862
(when (require 'key-chord nil t)
  (setq key-chord-two-keys-delay 0.04) ;; 同時押しとみなす間隔
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'view-mode)
  (key-chord-define-global "kl" 'jaunte)
  (key-chord-define-global "ij" 'iy-go-to-char)
  (key-chord-define-global "bg" 'iy-go-to-char-backward)
  (key-chord-define-global "oj" 'ace-jump-mode))


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
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; ctags-update.el
;; from marmalede.el
;; http://marmalade-repo.org/packages/ctags-update
(when (require 'ctags-update nil t)
  (ctags-update-minor-mode 1))

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

;; flex-autopair.el
;; http://d.hatena.ne.jp/uk-ar/20120401
;; https://github.com/uk-ar/flex-autopair/
;; https://raw.github.com/uk-ar/flex-autopair/master/flex-autopair.el
(when (require 'flex-autopair nil t)
  (flex-autopair-mode -1))

;; acp.el
;; http://d.hatena.ne.jp/buzztaiki/20061204/1165207521
;; http://d.hatena.ne.jp/kitokitoki/20090823/p1
(when (require 'acp nil t)

  (add-hook 'emacs-lisp-mode-hook 'acp-mode)
  (add-hook 'lisp-mode-hook 'acp-mode)

  (setq acp-paren-alist
        '((?( . ?))
          (?[ . ?])))

  (setq acp-insertion-functions
        '((mark-active . acp-surround-with-paren)
          ((thing-at-point 'symbol) . acp-surround-symbol-with-paren)
          (t . acp-insert-paren)))

  (defun acp-surround-symbol-with-paren (n)
    (save-excursion
      (save-restriction
        (narrow-to-region (car (bounds-of-thing-at-point 'symbol)) (cdr (bounds-of-thing-at-point 'symbol)))
        (goto-char (point-min))
        (insert-char (car (acp-current-pair)) n)
        (goto-char (point-max))
        (insert-char (cdr (acp-current-pair)) n))))
  )

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
;; flymake
;;----------------------------------------------------------------------------
(require 'init-flymake nil t)

;;----------------------------------------------------------------------------
;; anything.el
;;----------------------------------------------------------------------------
(require 'init-anything nil t)
;;---------------------------------------------------------
;; eshell
;;---------------------------------------------------------
(require 'init-eshell nil t)

;;---------------------------------------------------------
;; moz.el
;;---------------------------------------------------------
(require 'init-moz nil t)

;;---------------------------------------------------------
;; Google Chrome edit with emacs
;;---------------------------------------------------------
(when (require 'edit-server nil t)
  (edit-server-start))

;; (if (locate-library "edit-server")
;;     (progn
;;       (require 'edit-server)
;;       (setq edit-server-new-frame nil)
;;       (edit-server-start)))

;;---------------------------------------------------------
;; ddskk
;;---------------------------------------------------------
(require 'init-ddskk nil t)

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
