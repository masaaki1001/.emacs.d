;; 最近使ったファイル M-x recentf-open-files　を有効化
;; .recentfを自動保存する
;; http://d.hatena.ne.jp/tomoya/20110217/1297928222
(setq recentf-exclude '("/.recentf" ".revive" "/elpa/" "/snippets/" "COMMIT_EDITMSG"))
(setq recentf-save-file (expand-file-name ".recentf" resource-dir))
(setq recentf-max-saved-items 2000)
(recentf-mode 1)

;; recentf-ext
;; http://d.hatena.ne.jp/rubikitch/20091224/recentf
(require 'recentf-ext)

(provide 'init-recentf)
