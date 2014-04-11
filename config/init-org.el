;;;; org-mode
;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html
(when (require 'org-install nil t)
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (setq org-use-fast-todo-selection t)
  (setq org-directory "~/.emacs.d/org-mode/")

  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)

  (setq org-agenda-files '("~/.emacs.d/org-mode/todo.org"))
  (setq org-log-done 'time)

  ;; org-tree-slide.el
  ;; http://pastelwill.jp/wiki/doku.php?id=emacs:org-tree-slide
  ;; https://github.com/takaxp/org-tree-slide
  (when (require 'org-tree-slide nil t)
    (global-set-key (kbd "<f6>") 'org-tree-slide-mode)
    (global-set-key (kbd "S-<f6>") 'org-tree-slide-skip-done-toggle)
    ;; エフェクト無効化
    (org-tree-slide-simple-profile)
    )
  )

(provide 'init-org)
