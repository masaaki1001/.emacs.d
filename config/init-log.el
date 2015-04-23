;; savekill
;; http://d.hatena.ne.jp/rubikitch/20110226/
(require 'savekill)
(setq save-kill-file-name (expand-file-name "kill-ring-saved.el" resource-dir))

;; scratch-log
;; http://d.hatena.ne.jp/kitokitoki/20100612/p1
(require 'scratch-log)
(setq sl-scratch-log-file (expand-file-name ".scratch-log" resource-dir))
(setq sl-prev-scratch-string-file (expand-file-name ".scratch-log-prev" resource-dir))
(setq sl-restore-scratch-p t)

;; saveplace
(require 'saveplace)
(setq save-place-file (expand-file-name ".emacs-places" resource-dir))
(setq-default save-place t)

;; revive.el
;; http://d.hatena.ne.jp/gan2/20080203/1202032426
;; http://tech.kayac.com/archive/emacs.html
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(setq revive:configuration-file (expand-file-name ".revive.el" resource-dir))
(define-key ctl-x-map "F" 'resume)                        ; C-x F で復元
(define-key ctl-x-map "K" 'wipe)                          ; C-x K で Kill
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に保存

(provide 'init-log)
