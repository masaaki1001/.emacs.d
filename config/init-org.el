;;----------------------------------------------------------------------------
;; org-mode
;;----------------------------------------------------------------------------
;; Emacsでメモ・TODO管理
;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
;; http://e-arrows.sakura.ne.jp/2010/02/vim-to-emacs.html
(when (require 'org-install nil t)
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cr" 'org-remember)
  (define-key global-map "\C-cc" 'org-remember-code-reading)
  (define-key global-map "\C-cp" 'org-capture)
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-directory "~/.emacs.d/org-mode/")
  (setq org-default-notes-file (concat org-directory "agenda.org"))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE" "CANCEL(c)")
          (sequence "APPT(A)" "|" "DONE(x)" "CANCEL(c)")))
  (setq org-log-done 'time)
)

;; org-tree-slide.el
;; http://pastelwill.jp/wiki/doku.php?id=emacs:org-tree-slide
;; https://github.com/takaxp/org-tree-slide
(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f6>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f6>") 'org-tree-slide-skip-done-toggle)
  ;; エフェクト無効化
  (org-tree-slide-simple-profile)
  )

(provide 'init-org)
