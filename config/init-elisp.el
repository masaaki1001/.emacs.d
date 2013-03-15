;;----------------------------------------------------------------------------
;; 各種elisp
;;----------------------------------------------------------------------------
;; popwin.el
;; http://d.hatena.ne.jp/m2ym/20110120
(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  ;; (push '("^\*anything .+\*$" :regexp t :height 20) popwin:special-display-config)
  ;; (push '("^\*helm .+\*$" :regexp t :height 20) popwin:special-display-config)
  (push '("*helm*" :height 20) popwin:special-display-config)
  (push '("*helm M-x*" :height 20) popwin:special-display-config)
  (push '("*Warnings*" :height 20) popwin:special-display-config)
  (push '("*Procces List*" :height 20) popwin:special-display-config)
  (push '("*Messages*" :height 20) popwin:special-display-config)
  (push '("*Backtrace*" :height 20) popwin:special-display-config)
  (push '("*Compile-Log*" :height 20 :noselect t) popwin:special-display-config)
  (push '("*Remember*" :height 20) popwin:special-display-config)
  (push '("*undo-tree*" :height 20) popwin:special-display-config)
  (push '("*All*" :height 20) popwin:special-display-config)
  ;; (push '("*eshell*" :height 20) popwin:special-display-config)
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
(when (require 'jump-char nil t)
  (global-set-key (kbd "C-c f") 'jump-char-forward)
  (global-set-key (kbd "C-c F") 'jump-char-backward)
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

;; redo+
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-M-/") 'redo)
  (setq undo-no-redo t) ; 過去のundoがredoされないようにする
  (setq undo-limit 600000)
  (setq undo-strong-limit 900000))

(when (require 'ack-and-a-half nil t)
  ;; Create shorter aliases
  (defalias 'ack 'ack-and-a-half)
  (defalias 'ack-same 'ack-and-a-half-same)
  (defalias 'ack-find-file 'ack-and-a-half-find-file)
  (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
  )

(provide 'init-elisp)
