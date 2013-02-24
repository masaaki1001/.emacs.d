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
  (setq helm-samewindow nil)
  (push '("^\*anything .+\*$" :regexp t :height 20) popwin:special-display-config)
  (push '("^\*helm .+\*$" :regexp t :height 20) popwin:special-display-config)
  (push '("*Warnings*" :height 20) popwin:special-display-config)
  (push '("*Procces List*" :height 20) popwin:special-display-config)
  (push '("*Messages*" :height 20) popwin:special-display-config)
  (push '("*Backtrace*" :height 20) popwin:special-display-config)
  (push '("*Compile-Log*" :height 20) popwin:special-display-config)
  (push '("*Remember*" :height 20) popwin:special-display-config)
  (push '("*undo-tree*" :height 20) popwin:special-display-config)
  (push '("*All*" :height 20) popwin:special-display-config)
  (push '("*eshell*" :height 20) popwin:special-display-config)
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
(when (require 'moccur-edit nil t))

;; all-ext.el
(when (require 'all-ext nil t))

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
  (global-set-key (kbd ">") (smartchr '(">" " -> " " => " " -> '`!!''" " => '`!!''" " -> \"`!!'\"" " => \"`!!'\"")))
  (global-set-key (kbd "<") (smartchr '("<" " << ")))
  (global-set-key (kbd "&") (smartchr '("&" " && ")))
  (global-set-key (kbd "|") (smartchr '("|" " || ")))
  )

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
;; originalではなくid:moozの拡張版を利用
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js2-mode)) ;; for rails

;; js3-mode
;; https://github.com/thomblake/js3-mode
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js3-mode)) ;; for rails

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

;; sticky.el
;; 大文字入力を楽にする
(when (require 'sticky nil t)
  (use-sticky-key ";" sticky-alist:ja))

;; scratch-log.el
;; http://d.hatena.ne.jp/kitokitoki/20100612/p1
;; https://github.com/wakaran/scratch-log
(when (require 'scratch-log nil t)
  (setq sl-scratch-log-file "~/.emacs.d/resource/.scratch-log")
  (setq sl-prev-scratch-string-file "~/.emacs.d/resource/.scratch-log-prev")
  ;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
  (setq sl-restore-scratch-p t)
  ;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
  ;; (setq sl-prohibit-kill-scratch-buffer-p nil)
  )

;; multiverse.el
;; ファイルのスナップショットを取得する
(when (require 'multiverse nil t))

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

  (require 'js2-refactor)
  (define-key js2-mode-map (kbd "C-c C-r") 'js2-rename-var)
  (require 'inline-string-rectangle)
  (global-set-key (kbd "C-x r t") 'inline-string-rectangle)
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
(when (require 'wgrep nil t))

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
  ;; Ruby編集時もソースを隠したり、表示したり
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

;; volatile-highlights.el
(when (require 'volatile-highlights nil t)
  (volatile-highlights-mode t)
  )

;; smooth-scroll.el
;;(require 'smooth-scroll)
;;(smooth-scroll-mode t)

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

;; minimap.el
;; http://www.randomsample.de/minimap.el
(require 'minimap nil t)

;; zlc.el
;; http://d.hatena.ne.jp/mooz/20101003/p1
;; https://github.com/mooz/emacs-zlc/
(when (require 'zlc nil t)
;;(setq zlc-select-completion-immediately t)
  )

;; *Completions*バッファを，使用後に消してくれる
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part11
(when (require 'lcomp nil t)
  (lcomp-install))

;; maximize.el
;; https://github.com/izawa/maximize
(when (require 'maximize nil t)
  ;; (global-set-key [(f12)] 'maximize-toggle-frame-vmax)
  ;; (global-set-key [(shift f12)] 'maximize-toggle-frame-hmax)
  (global-set-key [(f12)] 'maximize-frame)
  )

(when (require 'maxframe nil t)
  (add-hook 'window-setup-hook 'maximize-frame t))

;; iy-go-to-char.el
(when (require 'iy-go-to-char nil t)
  (global-set-key (kbd "C-c f") 'iy-go-to-char)
  (global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
  (global-set-key (kbd "C-c ;") 'iy-go-to-char-continue)
  (global-set-key (kbd "C-c ,") 'iy-go-to-char-continue-backward)
  )

;; jaunte.el
;; http://kawaguchi.posterous.com/emacshit-a-hint
;; https://github.com/kawaguchi/jaunte.el
(when (require 'jaunte nil t)
  (global-set-key (kbd "C-c C-j") 'jaunte)
  (setq jaunte-hint-unit 'word) ;default
  ;;(setq jaunte-global-hint-unit 'symbol)
  )

;; ace-jump-mode.el
;; http://d.hatena.ne.jp/syohex/20120304/1330822993
;; https://github.com/winterTTr/ace-jump-mode
(when (require 'ace-jump-mode nil t)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  (global-set-key (kbd "C-.") 'ace-jump-mode)
  )

;; jump-char.el
;; https://github.com/lewang/jump-char
(require 'jump-char)
(global-set-key [(meta m)] 'jump-char-forward)
(global-set-key [(shift meta m)] 'jump-char-backward)

;; pomodoro.el
;; https://github.com/baudtack/pomodoro.el
(when (require 'pomodoro nil t)
  (pomodoro-add-to-mode-line)
  )

;; diminish.el
(when (require 'diminish nil t)
  (diminish 'undo-tree-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'view-mode)
  )

;; fic-mode.el
;; https://github.com/lewang/fic-mode
;; highlight word is TODO or FIXME
(when (require 'fic-mode nil t))

;; fcopy.el
(autoload 'fcopy-mode "fcopy" "copy lines or region without editing." t)

;; rainbow-mode.el
(when (require 'rainbow-mode nil t)
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'scss-mode-hook 'rainbow-mode)
  )

;; drag-stuff.el
;; https://github.com/rejeep/drag-stuff
(when (require 'drag-stuff nil t)
  (drag-stuff-mode t))

;; https://github.com/TeMPOraL/nyan-mode
(when (require 'nyan-mode nil t))

;; duplicate-thing.el
;; https://github.com/ongaeshi/duplicate-thing
;; http://d.hatena.ne.jp/syohex/20120325/1332641491
(when (require 'duplicate-thing nil t)
  (global-set-key (kbd "C-M-y") 'duplicate-thing))

;; powerline
;; (require 'powerline nil t)

(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start)
  )

;; redo+
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-M-/") 'redo)
  (setq undo-no-redo t) ; 過去のundoがredoされないようにする
  (setq undo-limit 600000)
  (setq undo-strong-limit 900000))

;; yagist.el
(when (require 'yagist nil t))

(when (require 'ack-and-a-half nil t)
  ;; Create shorter aliases
  (defalias 'ack 'ack-and-a-half)
  (defalias 'ack-same 'ack-and-a-half-same)
  (defalias 'ack-find-file 'ack-and-a-half-find-file)
  (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
  )

(provide 'init-elisp)
