; -*- mode: lisp; coding: utf-8 -*-
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
  (push '("*Procces List*" :height 20) popwin:special-display-config)
  (push '("*Messages*" :height 20) popwin:special-display-config)
  (push '("*Backtrace*" :height 20) popwin:special-display-config)
  (push '("*Compile-Log*" :height 20) popwin:special-display-config)
  ;; http://valvallow.blogspot.com/2011/03/emacs-popwinel.html
  (push '("*Remember*" :height 20) popwin:special-display-config)
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
  ;;(setq undo-tree-mode-lighter "")
  (global-undo-tree-mode))

;; undohist.el
(when (require 'undohist nil t)
  (undohist-initialize))

;; point-undo.el
;; こんな対応が必要らしい http://randd.kwappa.net/2011/03/10/258
(when (require 'point-undo nil t)
  (define-key global-map (kbd "<f7>") 'point-undo)
  (define-key global-map (kbd "S-<f7>") 'point-redo))

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
;; (when (require 'smartchr nil t)
;;   (global-set-key (kbd "=") (smartchr '("=" " = " " == " " === ")))
;;   (global-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
;;   (global-set-key (kbd "<") (smartchr '("<" " << ")))
;;   (global-set-key (kbd "&") (smartchr '("&" " && ")))
;;   (global-set-key (kbd "|") (smartchr '("|" " || ")))
;;   )

;; key-combo.el
;; smartchr.elとsequential-command.el両方行ける
;; http://d.hatena.ne.jp/uk-ar/searchdiary?word=%2A%5BKey-combo%5D
;; https://github.com/uk-ar/key-combo/
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
(setq exec-path (cons "/usr/local/bin/" exec-path))
;; http://d.hatena.ne.jp/yuto_sasaki/20120116/1326708562
(setenv "LC_ALL" "ja_JP.UTF-8") ;; svn log が文字化けする対策

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

;; sticky.el
;; 大文字入力を楽にする
(when (require 'sticky nil t)
  (use-sticky-key ";" sticky-alist:ja))

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

;; change-inner.el
;; https://github.com/magnars/change-inner.el
(when (require 'change-inner nil t)
  (global-set-key (kbd "M-i") 'change-inner)
  (global-set-key (kbd "M-o") 'change-outer)
  )

;; mark-multiple.el
;; https://github.com/magnars/mark-multiple.el
;; http://d.hatena.ne.jp/syohex/20120206/1328540927
;(when (require 'mark-more-like-this nil t)
  ;(global-set-key (kbd "C-<") 'mark-previous-like-this)
  ;(global-set-key (kbd "C->") 'mark-next-like-this)
  ;(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
;  )

;; Experimental multiple-cursors
(when (require 'multiple-cursors nil t)
  ;;(global-set-key (kbd "C-S-c C-S-c") 'mc/add-multiple-cursors-to-region-lines)
  ;; (global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
  ;; (global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

;; grep-a-lot.el
;; Emacs tech book p162
;; https://github.com/ZungBang/emacs-grep-a-lot
(when (require 'grep-a-lot nil t)
  (defvar my-grep-a-lot-search-word nil)
  ;;上書き
  (defun grep-a-lot-buffer-name (position)
    "Return name of grep-a-lot buffer at POSITION."
    (concat "*grep*<" my-grep-a-lot-search-word ">"))

  (defadvice rgrep (before my-rgrep (regexp &optional files dir) activate)
    (setq my-grep-a-lot-search-word regexp))

  (defadvice lgrep (before my-lgrep (regexp &optional files dir) activate)
    (setq my-grep-a-lot-search-word regexp))

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
  )

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
  ;; (key-chord-define-global "ij" 'iy-go-to-char)
  ;; (key-chord-define-global "bg" 'iy-go-to-char-backward)
  ;;(key-chord-define-global "oj" 'ace-jump-mode)
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

;; yaml-mode.el
;; https://github.com/yoshiki/yaml-mode
;; https://raw.github.com/yoshiki/yaml-mode/master/yaml-mode.el
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

  (global-set-key (kbd "C-(") 'hs-hide-block)
  (global-set-key (kbd "C-)") 'hs-show-block)
  )

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
(when (require 'volatile-highlights nil t)
  (volatile-highlights-mode t)
  )

;; smooth-scroll.el
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
;; https://github.com/mhayashi1120/auto-highlight-symbol-mode
;; http://d.hatena.ne.jp/yuheiomori0718/20111222/1324562208
;; http://d.hatena.ne.jp/syohex/20110126/1296048465
(when (require 'auto-highlight-symbol nil t)
  (global-auto-highlight-symbol-mode t)
  (ahs-set-idle-interval 5) ;ハイライトまでの待機時間 デフォルトは1秒
  )

;; minimap.el
;; http://www.randomsample.de/minimap.el
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

;; *Completions*バッファを，使用後に消してくれる
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part11
(when (require 'lcomp nil t)
  (lcomp-install))

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
  (global-set-key (kbd "C-.") 'ace-jump-mode)
  )

;; jump-char.el
;; https://github.com/lewang/jump-char
(require 'jump-char)
(global-set-key [(meta m)] 'jump-char-forward)
(global-set-key [(shift meta m)] 'jump-char-backward)

;; file-column-indicator.el
;; https://github.com/alpaker/Fill-Column-Indicator
;; (when (require 'fill-column-indicator nil t)
;;   (setq fci-rule-column 160))

;; pomodoro.el
;; https://github.com/baudtack/pomodoro.el
(when (require 'pomodoro nil t)
  (pomodoro-add-to-mode-line)
  )

;; diminish.el
(when (require 'diminish nil t)
  (diminish 'undo-tree-mode)
  (diminish 'yas/minor-mode)
  (diminish 'volatile-highlights-mode)
  )

;; fic-mode.el
;; https://github.com/lewang/fic-mode
;; highlight word is TODO or FIXME
(require 'fic-mode nil t)

;; fcopy.el
;; https://raw.github.com/ataka/fcopy/master/fcopy.el
(autoload 'fcopy-mode "fcopy" "copy lines or region without editing." t)

;; rainbow-mode.el
;; elpa
(require 'rainbow-mode nil t)

;; drag-stuff.el
;; https://github.com/rejeep/drag-stuff
(when (require 'drag-stuff nil t)
  (drag-stuff-mode t))

;; 全てのバッファを閉じる
(defun close-all-buffers ()
  (interactive)
  (loop for buffer being the buffers
     do (kill-buffer buffer)))

;; https://github.com/TeMPOraL/nyan-mode
(require 'nyan-mode nil t)

;; grep-o-matic.el
;; https://github.com/ZungBang/emacs-grep-o-matic
(require 'grep-o-matic nil t)

;; duplicate-thing.el
;; https://github.com/ongaeshi/duplicate-thing
;; https://raw.github.com/ongaeshi/duplicate-thing/master/duplicate-thing.el
;; http://d.hatena.ne.jp/syohex/20120325/1332641491
(when (require 'duplicate-thing nil t)
  (global-set-key (kbd "C-M-y") 'duplicate-thing))

;; http://d.hatena.ne.jp/kitokitoki/20091129/p1
(defun sqlf (start end)
  "リージョンのSQLを整形する"
  (interactive "r")
  (let ((case-fold-search t))
    (let* ((s (buffer-substring-no-properties start end))
           (s (replace-regexp-in-string "\\(select \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(update \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(insert into \\)\\(fuga\\)\\(fuga\\)" "\n\\2\n  " s))
           (s (replace-regexp-in-string "\\(delete from \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(create table \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(alter table \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(drop constraint \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(from \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(exists \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(where \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(values \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(order by \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(group by \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(having \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(left join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(left outer join )\\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(right join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(right outer join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(inner join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(cross join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(union join \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(and \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(or \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(any \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update restrict \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update cascade \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update set null \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on update no action \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete restrict \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete cascade \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete set null \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(on delete no action \\)" "\n\\1\n  " s))
           (s (replace-regexp-in-string "\\(,\\)" "\\1\n  " s)))
    (save-excursion
      (insert s)))))

;; powerline
;; (require 'powerline nil t)

;; scss-mode
(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; git-gutter.el
;; https://github.com/syohex/emacs-git-gutter
;; (require 'fringe-helper)
;; (when (require 'git-gutter nil t)
;;   (add-hook 'after-save-hook
;;           (lambda ()
;;             (if (zerop (call-process-shell-command "git rev-parse --show-toplevel"))
;;                 (git-gutter))))
;;   )

(provide 'init-elisp)
