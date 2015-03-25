(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
;; undo-tree
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `((".*" . ,(expand-file-name "undo-tree" resource-dir))))
(global-set-key (kbd "C-M-/") 'undo-tree-redo)

;; undohist
(require 'undohist)
(undohist-initialize)
(setq undohist-ignored-files '("COMMIT_EDITMSG"))
(setq undohist-directory (expand-file-name "undohist" resource-dir))

(provide 'init-undo)
