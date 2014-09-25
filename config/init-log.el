;;;; log
;; session
;; http://maruta.be/intfloat_staff/101
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq session-save-file (expand-file-name ".session" resource-dir))
(setq session-save-print-spec '(t nil nil))

;; savekill
;; http://d.hatena.ne.jp/rubikitch/20110226/
(require 'savekill)
(setq save-kill-file-name (expand-file-name "kill-ring-saved.el" resource-dir))

;; scratch-log
;; http://d.hatena.ne.jp/kitokitoki/20100612/p1
;; https://github.com/wakaran/scratch-log
(require 'scratch-log)
(setq sl-scratch-log-file (expand-file-name ".scratch-log" resource-dir))
(setq sl-prev-scratch-string-file (expand-file-name ".scratch-log-prev" resource-dir))
(setq sl-restore-scratch-p t)

(provide 'init-log)
