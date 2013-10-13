;;----------------------------------------------------------------------------
;; anything.el
;;----------------------------------------------------------------------------
(when (require 'anything-config nil t)
  ;; (setq anything-sources
  ;;       '(anything-c-source-buffers+
  ;;         anything-c-source-recentf
  ;;         anything-c-source-files-in-current-dir
  ;;         anything-c-source-emacs-commands
  ;;         ))

  (setq anything-samewindow nil)
  (setq anything-candidate-number-limit 300) ; 表示する最大候補数。デフォルトで 50

  (define-key anything-map (kbd "C-p")   'anything-previous-line)
  (define-key anything-map (kbd "C-n")   'anything-next-line)

  ;; anything 起動
  ;; http://d.hatena.ne.jp/tomoya/20090423/1240456834
  ;; (define-key global-map (kbd "C-;") 'anything) ; そのお隣り
  ;; anything 2重起動エラー対応
  ;; http://d.hatena.ne.jp/yuheiomori0718/20120119/1326976493
  ;; (define-key anything-map (kbd "C-;") 'abort-recursive-edit)

  (require 'anything-git-files nil t)
  )

(provide 'init-anything)
