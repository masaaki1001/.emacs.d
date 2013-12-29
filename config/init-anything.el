;;;; anything.el
(when (require 'anything-config nil t)
  (setq anything-samewindow nil)
  (setq anything-candidate-number-limit 300) ; 表示する最大候補数。デフォルトで 50

  (define-key anything-map (kbd "C-p")   'anything-previous-line)
  (define-key anything-map (kbd "C-n")   'anything-next-line)

  (require 'anything-git-files nil t)
  )

(provide 'init-anything)
