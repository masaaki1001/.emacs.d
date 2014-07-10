;;;; grep
;; color-moccur.el
;; http://www.bookshelf.jp/soft/meadow_50.html#SEC746
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
        (append '("\\~$" "\\.log\\/\*") dmoccur-exclusion-mask)))

;; moccur-edit.el
;; http://www.bookshelf.jp/elc/moccur-edit.el
(require 'moccur-edit nil t)

;; all-ext.el
(require 'all-ext nil t)

;; grep-a-lot.el
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
    (setq my-grep-a-lot-search-word regexp)))

;; wgrep.el
;; https://github.com/mhayashi1120/Emacs-wgrep
(require 'wgrep nil t)

;; wgrep-ag.el
(when (and (executable-find "ag")
           (require 'ag nil t))
  (require 'wgrep-ag nil t)
  (custom-set-variables
   '(ag-highlight-search t)   ; 検索結果の中の検索語をハイライトする
   '(ag-reuse-window 'nil)    ; 現在のウィンドウを検索結果表示に使う
   '(ag-reuse-buffers 'nil))  ; 現在のバッファを検索結果表示に使う
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  ;; agの検索結果バッファで"r"で編集モードに。
  ;; C-x C-sで保存して終了、C-x C-kで保存せずに終了
  (define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode))

;; color-grep.el
;; http://www.bookshelf.jp/soft/meadow_51.html#SEC778
(when (require 'color-grep nil t)
  ;; grep バッファを kill 時に，開いたバッファを消す
  (setq color-grep-sync-kill-buffer t))

(provide 'init-grep)
