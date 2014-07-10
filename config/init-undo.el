;;;; undo
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)
;; undo-tree.el
;; http://www.dr-qubit.org/undo-tree/undo-tree.el
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; undohist.el
(when (require 'undohist nil t)
  (undohist-initialize)
  (setq undohist-ignored-files '("COMMIT_EDITMSG")))

;; redo+
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-M-/") 'redo))

(provide 'init-undo)
