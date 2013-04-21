;;----------------------------------------------------------------------------
;; anything.el
;;----------------------------------------------------------------------------
(when (require 'anything-startup nil t)
  (require 'anything-config nil t)
  (setq anything-sources
        '(anything-c-source-buffers+
          anything-c-source-recentf
          anything-c-source-files-in-current-dir
          anything-c-source-emacs-commands
          ))

  (setq anything-samewindow nil)
  (setq anything-candidate-number-limit 300) ; 表示する最大候補数。デフォルトで 50
  (anything-read-string-mode 1)

  ;; anything 起動
  ;; http://d.hatena.ne.jp/tomoya/20090423/1240456834
  (define-key global-map (kbd "C-;") 'anything) ; そのお隣り
  ;; anything 2重起動エラー対応
  ;; http://d.hatena.ne.jp/yuheiomori0718/20120119/1326976493
  (define-key anything-map (kbd "C-;") 'abort-recursive-edit)
  )

;; anything-project.el
;; http://d.hatena.ne.jp/yuheiomori0718/20111226/1324902529
;; (when (require 'anything-project nil t)
;; ;(global-set-key (kbd "C-c C-f") 'anything-project)
;;   (global-set-key (kbd "C-:") 'anything-project)
;;   (ap:add-project
;;    ;; templete
;;    ;; :name 'hoge
;;    ;; :look-for '("Rakefile")
;;    ;; :include-regexp '("\\.rb$" "\\.html$" "\\.erb$" "\\.js$" "\\.yml$" "\\.css$" "\\Gemfile$")
;;    ;:exclude-regexp "/test_files" ; can be regexp or list of regexp
;;    :name 'project
;;    :look-for '(".gitignore")
;;    :include-regexp '("\\.scala$" "\\.html$" "\\.conf$" "\\.properties$" "\\.sbt$" "\\.sql$" "\\routes$")
;;    )
;;   ;; 候補にディレクトリが含まれないようにする
;;   ;; http://d.hatena.ne.jp/IMAKADO/20090823/1250963119
;;   (setq ap:project-files-filters
;;         (list
;;          (lambda (files)
;;            (remove-if 'file-directory-p files))))
;;   )

(provide 'init-anything)
