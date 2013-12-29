;;----------------------------------------------------------------------------
;; bm.el
;; http://d.hatena.ne.jp/kenkov/20110507/1304754238
;; http://d.hatena.ne.jp/peccu/20100402
;; https://github.com/joodland/bm/blob/master/bm.el
;;----------------------------------------------------------------------------
(when (require 'bm nil t)
  ;; マークのセーブ
  (setq-default bm-buffer-persistence t)
  (setq bm-repository-file "~/.emacs.d/resource/.bm-repository")
  ;; 起動時に設定のロード
  (setq bm-restore-repository-on-load t)
  (add-hook 'after-init-hook 'bm-repository-load)
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  ;; 設定ファイルのセーブ
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'auto-save-hook 'bm-buffer-save)
  (add-hook 'after-save-hook 'bm-buffer-save)
  (add-hook 'vc-before-checkin-hook 'bm-buffer-save)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  (global-set-key (kbd "<M-f2>") 'bm-toggle)
  (global-set-key (kbd "M-[") 'bm-previous)
  (global-set-key (kbd "M-]") 'bm-next)
  ;Saving the repository to file when on exit.
  ;kill-buffer-hook is not called when emacs is killed, so we
  ;must save all bookmarks first.
  (add-hook 'kill-emacs-hook '(lambda nil
                                (bm-buffer-save-all)
                                (bm-repository-save)))
  (setq bm-marker 'bm-marker-right)
  (setq bm-cycle-all-buffers t)
  )

(provide 'init-bm)
