;;;; undo
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
;; undo-tree.el
;; http://www.dr-qubit.org/undo-tree/undo-tree.el
(require 'undo-tree)
(global-undo-tree-mode)

;; undohist.el
(require 'undohist)
(undohist-initialize)
(setq undohist-ignored-files '("COMMIT_EDITMSG"))

;; redo+
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)

(provide 'init-undo)
