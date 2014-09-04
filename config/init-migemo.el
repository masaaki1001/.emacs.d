;;;; migemo.el
;; http://gist.github.com/457761
;; http://d.hatena.ne.jp/samurai20000/20100907/1283791433
(when (and (executable-find "cmigemo")
           (locate-library "migemo"))
  ;; デフォルトではmigemoを無効にする
  ;; http://www.meadowy.org/meadow/netinstall/wiki/PkgMigemo#a.emacs
  (setq migemo-isearch-enable-p nil)
  ;; http://d.hatena.ne.jp/ground256/20111008/1318063872
  (setq migemo-command "/usr/local/bin/cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))

(provide 'init-migemo)
