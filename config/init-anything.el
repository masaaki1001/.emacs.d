; -*- mode: lisp; coding: utf-8 -*-
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
          anything-c-source-yaetags-select
          ))

  (setq anything-candidate-number-limit 300) ; 表示する最大候補数。デフォルトで 50

  ;; anything 起動
  ;; http://d.hatena.ne.jp/tomoya/20090423/1240456834
  (define-key global-map (kbd "C-;") 'anything) ; そのお隣り
  ;; anything 2重起動エラー対応
  ;; http://d.hatena.ne.jp/yuheiomori0718/20120119/1326976493
  (define-key anything-map (kbd "C-;") 'abort-recursive-edit)
  )

;; anything-c-moccur.el
;; http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
(when (require 'anything-c-moccur nil t)
  ;;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
  (setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
        anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
        anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
        anything-c-moccur-enable-initial-pattern nil) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

;;; キーバインドの割当(好みに合わせて設定してください)
  (global-set-key (kbd "C-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
  (add-hook 'dired-mode-hook ;dired
            '(lambda ()
               (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
  )

;; anything-replace-string.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20110107/1294408979
(require 'anything-replace-string nil t)

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
   :name 'Ripple
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

;; anything-css.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20120110/1326198461
(require 'anything-css nil t)

;; anything-imenu起動
;;(define-key global-map (kbd "<f12>") 'anything-imenu)
(define-key global-map (kbd "C-c i") 'anything-imenu)

;; anything-exuberant-ctags.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20110809/1312896254
(when (require 'anything-exuberant-ctags nil t)
  (setq anything-exuberant-ctags-enable-tag-file-dir-cache t)
  (setq anything-exuberant-ctags-cache-tag-file-dir "~/Workspace/hoge/")
  )

;; anything-yaetags.el
(when (require 'anything-yaetags nil t)
  ;;(add-to-list 'anything-sources 'anything-c-source-yaetags-select)
  (global-set-key (kbd "M-.") 'anything-yaetags-find-tag)
  )

;; anything-migemo.el
(require 'anything-migemo nil t)

;; anything-dired-tree.el
;; https://gist.github.com/2271938

;; anything-c-source-junk-files
;; http://qiita.com/items/eba6bc64f66d278f0032
(require 'em-glob)
(defvar junk-file-dir "~/.emacs.d/junk/")
(defvar junk-file-list
  (reverse (eshell-extended-glob (concat
                                  (file-name-as-directory junk-file-dir)
                                  "*"))))
(defvar anything-c-source-junk-files
  '((name . "Junk Files")
    (candidates . junk-file-list)
    (type . file)))
(defun anything-open-junk-file ()
  (interactive)
  (anything-other-buffer 'anything-c-source-junk-files "*anything for junk file"))
(global-set-key (kbd "C-x M-j") 'anything-open-junk-file)

(defun anything-for-elscreen ()
  "preconfigured `anything' for anything-for-elscreen"
  (interactive)
  (anything anything-c-source-elscreen
	    nil nil nil nil "*anything for elscreen*"))
(define-key global-map (kbd "C-c e") 'anything-for-elscreen)

(provide 'init-anything)
