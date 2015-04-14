;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html
(with-eval-after-load 'org
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (setq org-use-fast-todo-selection t)
  (setq org-directory (expand-file-name "org-mode" user-emacs-directory))
  ;; org-modeでexpand-regionを有効にするためorg-cycle-agenda-filesキーバインドを無効化
  (define-key org-mode-map (kbd "C-,") nil)

  ;; (setq org-agenda-files '("~/.emacs.d/org-mode/todo.org"))
  (setq org-agenda-files (list (expand-file-name "todo.org" org-directory)))
  (setq org-log-done 'time))

;; (require 'org)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

(defun my/org-note ()
  "Open a new note entry in my notes file."
  (interactive)
  (find-file (expand-file-name "note.org" org-directory))
  (goto-char (point-min))
  (org-insert-heading)
  (insert (concat "<" (format-time-string "%Y-%m-%dT%H:%M:%S%z") "> ")))

(provide 'init-org)
