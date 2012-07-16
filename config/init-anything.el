; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; anything.el
;;----------------------------------------------------------------------------
(when (require 'anything-startup nil t)
  (when (require 'anything-config nil t))
  ;;(add-to-list 'anything-sources 'anything-c-source-file-cache)

  ;; https://bitbucket.org/kshimo69/dot_emacs.d/src/33ceff9c8095/conf/init-anything.el
  ;; (defun my-anything ()
  ;;   (interactive)
  ;;   (anything-other-buffer
  ;;    '(anything-c-source-buffers+
  ;;      anything-c-source-recentf
  ;;      anything-c-source-files-in-current-dir
  ;;      anything-c-source-bm-global
  ;;      anything-c-source-emacs-commands
  ;;      anything-c-source-yaetags-select)
  ;;    " *my-anything*"))
  ;; (global-set-key (kbd "C-;") 'my-anything)

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

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rspec-use-rake-flag nil)
 '(safe-local-variable-values (quote ((encoding . utf-8) (encoding . UTF-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; anything-replace-string.el
;; http://emacs.g.hatena.ne.jp/k1LoW/20110107/1294408979
(require 'anything-replace-string nil t)

;; anything-advent-calendar.el (期間限定)
;; http://gongo.hatenablog.com/entry/2011/12/12/000301
(require 'anything-advent-calendar nil t)

;; anything-c-kill-ring
;; yankをpopupで表示する
;; http://www.flatz.jp/archives/2172
;;anything で対象とするkill-ring の要素の長さの最小値.
;;(setq anything-kill-ring-threshold 5) ;;デフォルトは 10.
;;(global-set-key (kbd "M-y") 'anything-show-kill-ring)

;; split-root.el
;; anythingを常に下部に表示する設定
;; http://emacs.g.hatena.ne.jp/k1LoW/20090713/1247496970
;; (require 'split-root)
;; (defvar anything-compilation-window-height-percent 50.0)
;; (defun anything-compilation-window-root (buf)
;;   (setq anything-compilation-window
;;         (split-root-window (truncate (* (window-height)
;;                                         (/ anything-compilation-window-height-percent
;;                                            100.0)))))
;;   (set-window-buffer anything-compilation-window buf))
;; (setq anything-display-function 'anything-compilation-window-root)

;; anythingで正規表現のかわりにglobを使えるようにする
;; http://d.hatena.ne.jp/buzztaiki/20110123
;;(require 'amp-glob)
;;(amp-glob-mode 1)

;; anything-project.el
;; http://d.hatena.ne.jp/yuheiomori0718/20111226/1324902529
(when (require 'anything-project nil t)
;(global-set-key (kbd "C-c C-f") 'anything-project)
  (global-set-key (kbd "C-:") 'anything-project)
  (ap:add-project
   :name 'hoge
   :look-for '("Rakefile")
   :include-regexp '("\\.rb$" "\\.html$" "\\.erb$" "\\.js$" "\\.yml$" "\\.css$" "\\Gemfile$")
   ;:exclude-regexp "/test_files" ; can be regexp or list of regexp
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
                                  "????-??-??-??????*.*"))))
(defvar anything-c-source-junk-files
  '((name . "Junk Files")
    (candidates . junk-file-list)
    (type . file)))
(defun anything-open-junk-file ()
  (interactive)
  (anything-other-buffer 'anything-c-source-junk-files "*anything for junk file"))
(global-set-key (kbd "C-x M-j") 'anything-open-junk-file)


(provide 'init-anything)