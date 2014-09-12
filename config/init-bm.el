;;;; bm.el
;; http://d.hatena.ne.jp/kenkov/20110507/1304754238
;; http://d.hatena.ne.jp/peccu/20100402
(require 'bm)
;; マークのセーブ
(setq-default bm-buffer-persistence t)
;; 起動時に設定のロード
(setq bm-repository-file (expand-file-name ".bm-repository" resource-dir)
      bm-restore-repository-on-load t
      bm-highlight-style 'bm-highlight-only-fringe
      bm-marker 'bm-marker-right
      bm-cycle-all-buffers t)

(dolist (hook '(kill-buffer-hook
                auto-save-hook
                after-save-hook
                vc-before-checkin-hook))
  (add-hook hook 'bm-buffer-save))

(dolist (hook '(find-file-hooks
                after-revert-hook
                after-revert-hook))
  (add-hook hook 'bm-buffer-restore))

(defun my/bm-after-init-hook ()
  (bm-load-and-restore)
  (message "Load and Restore bookmarks...done"))
(add-hook 'after-init-hook 'my/bm-after-init-hook)

(defun my/bm-kill-emacs-hook ()
  (bm-save)
  (message "Save bookmarks...done"))
(add-hook 'kill-emacs-hook 'my/bm-kill-emacs-hook)

(global-set-key (kbd "<M-f2>") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)

(provide 'init-bm)
