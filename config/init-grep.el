;; color-moccur
;; http://www.bookshelf.jp/soft/meadow_50.html#SEC746
(setq moccur-split-word t)

;; moccur-edit
;; http://www.bookshelf.jp/elc/moccur-edit.el
(require 'moccur-edit)

;; wgrep-ag
(with-eval-after-load "ag"
  (custom-set-variables
    '(ag-highlight-search t))
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  ;; agの検索結果バッファで"r"で編集モードに。
  ;; C-x C-sで保存して終了、C-x C-kで保存せずに終了
  (define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode))

(provide 'init-grep)
