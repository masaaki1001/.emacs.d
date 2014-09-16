;;;; grep
;; color-moccur.el
;; http://www.bookshelf.jp/soft/meadow_50.html#SEC746
(require 'color-moccur)
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

;; moccur-edit.el
;; http://www.bookshelf.jp/elc/moccur-edit.el
(require 'moccur-edit)

;; all-ext.el
(require 'all-ext)

;; grep-a-lot.el
;; https://github.com/ZungBang/emacs-grep-a-lot
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

;; wgrep.el
;; https://github.com/mhayashi1120/Emacs-wgrep
(require 'wgrep)

;; wgrep-ag.el
(eval-after-load "ag"
  '(progn
     (require 'wgrep-ag)
     (custom-set-variables
      '(ag-highlight-search t))
     (autoload 'wgrep-ag-setup "wgrep-ag")
     (add-hook 'ag-mode-hook 'wgrep-ag-setup)
     ;; agの検索結果バッファで"r"で編集モードに。
     ;; C-x C-sで保存して終了、C-x C-kで保存せずに終了
     (define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode)))

(provide 'init-grep)
