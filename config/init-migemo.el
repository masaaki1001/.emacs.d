; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; migemo.el
;; http://gist.github.com/457761
;;----------------------------------------------------------------------------
;; cmigemoを使用
;; migemoのon/offはM-mで切り替え可能
;; インストール方法
;; WEB + DB press vol.58 ← 今回はこちら
;; http://d.hatena.ne.jp/samurai20000/20100907/1283791433
;; 設定(2パターン)
;; http://d.hatena.ne.jp/samurai20000/20100907/1283791433
;; migemo-commandの部分は下記参照
;; http://d.hatena.ne.jp/ground256/20111008/1318063872
(when (require 'migemo nil t)
  ;; デフォルトではmigemoを無効にする
  ;; http://www.meadowy.org/meadow/netinstall/wiki/PkgMigemo#a.emacs
  (setq migemo-isearch-enable-p nil)

  (setq migemo-command "/usr/local/bin/cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  ;; WEB + DB Press vol.58
  ;; (when (and (executable-find "cmigemo")
  ;;            (require 'migemo nil t))
  ;;            (setq migemo-command "/usr/local/bin/cmigemo")
  ;;            (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  ;;            (setq migemo-dictionary
  ;;                  "/usr/local/share/migemo/utf-8/migemo-dict")
  ;;            (setq migemo-use-dictionary nil)
  ;;            (setq migemo-regex-dictionary nil)
  ;;            (setq migemo-use-pattern-alist t)
  ;;            (setq migemo-use-frequent-pattern-alist t)
  ;;            (setq migemo-pattern-alist-length 1000)
  ;;            (setq migemo-coding-system 'utf-8-unix)
  ;;            (migemo-init))
  )

(provide 'init-migemo)
