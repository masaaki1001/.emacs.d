(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
;; undo-tree
(global-undo-tree-mode)
(global-set-key (kbd "C-M-/") 'undo-tree-redo)

;; undohist
(require 'undohist)
(undohist-initialize)
(setq undohist-ignored-files '("COMMIT_EDITMSG"))

(provide 'init-undo)
