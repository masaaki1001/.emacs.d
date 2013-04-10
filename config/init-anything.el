;;----------------------------------------------------------------------------
;; anything.el
;;----------------------------------------------------------------------------
(when (require 'anything-startup nil t)
  (when (require 'anything-config nil t))
  (setq anything-sources
        '(anything-c-source-buffers+
          anything-c-source-recentf
          anything-c-source-files-in-current-dir
          anything-c-source-bm-global
          anything-c-source-emacs-commands
          ))

  (setq anything-samewindow nil)
  (setq anything-candidate-number-limit 300) ; 表示する最大候補数。デフォルトで 50

  ;; anything 起動
  ;; http://d.hatena.ne.jp/tomoya/20090423/1240456834
  (define-key global-map (kbd "C-;") 'anything) ; そのお隣り
  ;; anything 2重起動エラー対応
  ;; http://d.hatena.ne.jp/yuheiomori0718/20120119/1326976493
  (define-key anything-map (kbd "C-;") 'abort-recursive-edit)
  )

;; anything-project.el
;; http://d.hatena.ne.jp/yuheiomori0718/20111226/1324902529
(when (require 'anything-project nil t)
;(global-set-key (kbd "C-c C-f") 'anything-project)
  (global-set-key (kbd "C-:") 'anything-project)
  (ap:add-project
   ;; templete
   ;; :name 'hoge
   ;; :look-for '("Rakefile")
   ;; :include-regexp '("\\.rb$" "\\.html$" "\\.erb$" "\\.js$" "\\.yml$" "\\.css$" "\\Gemfile$")
   ;:exclude-regexp "/test_files" ; can be regexp or list of regexp
   :name 'project
   :look-for '(".gitignore")
   :include-regexp '("\\.scala$" "\\.html$" "\\.conf$" "\\.properties$" "\\.sbt$" "\\.sql$" "\\routes$")
   )
  ;; 候補にディレクトリが含まれないようにする
  ;; http://d.hatena.ne.jp/IMAKADO/20090823/1250963119
  (setq ap:project-files-filters
        (list
         (lambda (files)
           (remove-if 'file-directory-p files))))
  )

;; anything-imenu起動
;;(define-key global-map (kbd "<f12>") 'anything-imenu)
(define-key global-map (kbd "C-c i") 'anything-imenu)

;; anything-exuberant-ctags.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20110809/1312896254
(when (require 'anything-exuberant-ctags nil t)
  (setq anything-exuberant-ctags-enable-tag-file-dir-cache t)
  (setq anything-exuberant-ctags-cache-tag-file-dir "~/Workspace/hoge/")
  )

;; anything-migemo.el
(require 'anything-migemo nil t)

(provide 'init-anything)
