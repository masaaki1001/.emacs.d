;;;; log
;; session.el
;; http://maruta.be/intfloat_staff/101
(when (require 'session nil t)
  (add-hook 'after-init-hook 'session-initialize)
  (setq session-save-file (expand-file-name ".session" resource-dir))
  (setq session-save-print-spec '(t nil nil)))

;; savekill.el
;; http://d.hatena.ne.jp/rubikitch/20110226/
(when (require 'savekill nil t)
  (setq save-kill-file-name (expand-file-name "kill-ring-saved.el" resource-dir)))

;; scratch-log.el
;; http://d.hatena.ne.jp/kitokitoki/20100612/p1
;; https://github.com/wakaran/scratch-log
(when (require 'scratch-log nil t)
  (setq sl-scratch-log-file (expand-file-name ".scratch-log" resource-dir))
  (setq sl-prev-scratch-string-file (expand-file-name ".scratch-log-prev" resource-dir))
  (setq sl-restore-scratch-p t))

;; open-junk-file.el
(when (require 'open-junk-file nil t)
  (global-set-key (kbd "C-x M-j") 'open-junk-file)
  (setq open-junk-file-find-file-function 'find-file)
  (setq open-junk-file-format
        (expand-file-name "%Y-%m-%d-%H%M%S."
                          (concat user-emacs-directory "junk"))))

(provide 'init-log)
