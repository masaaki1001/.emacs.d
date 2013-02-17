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
  (org-remember-insinuate)
  (setq org-directory "~/.emacs.d/memo/")
  (setq org-default-notes-file (concat org-directory "agenda.org"))
  (setq org-agenda-files '("~/.emacs.d/memo/agenda.org" "~/.emacs.d/memo/code-reading.org"))
  (setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
        ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
        ))

  ;; org-remember-code-reading-mode
  ;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
  (defvar org-code-reading-software-name nil)
  ;; ~/memo/code-reading.org に記録する
  (defvar org-code-reading-file "~/.emacs.d/memo/code-reading.org")
  (defun org-code-reading-read-software-name ()
    (set (make-local-variable 'org-code-reading-software-name)
         (read-string "Code Reading Software: "
                      (or org-code-reading-software-name
                          (file-name-nondirectory
                           (buffer-file-name))))))
  (defun org-code-reading-get-prefix (lang)
    (concat "[" lang "]"
            "[" (org-code-reading-read-software-name) "]"))
  (defun org-remember-code-reading ()
    (interactive)
    (let* ((prefix (org-code-reading-get-prefix (substring (symbol-name major-mode) 0 -5)))
           (org-remember-templates
            `(("CodeReading" ?r "** %(identity prefix)%?\n   \n   %a\n   %t"
               ,org-code-reading-file "Memo"))))
      (org-remember)))

  ;; http://d.hatena.ne.jp/rubikitch/20090121/1232468026
  (defun org-next-visible-link ()
    "Move forward to the next link.
If the link is in hidden text, expose it."
    (interactive)
    (when (and org-link-search-failed (eq this-command last-command))
      (goto-char (point-min))
      (message "Link search wrapped back to beginning of buffer"))
    (setq org-link-search-failed nil)
    (let* ((pos (point))
           (ct (org-context))
           (a (assoc :link ct))
           srch)
      (if a (goto-char (nth 2 a)))
      (while (and (setq srch (re-search-forward org-any-link-re nil t))
                  (goto-char (match-beginning 0))
                  (prog1 (not (eq (org-invisible-p) 'org-link))
                    (goto-char (match-end 0)))))
      (if srch
          (goto-char (match-beginning 0))
        (goto-char pos)
        (setq org-link-search-failed t)
        (error "No further link found"))))
  
  (defun org-previous-visible-link ()
    "Move backward to the previous link.
If the link is in hidden text, expose it."
    (interactive)
    (when (and org-link-search-failed (eq this-command last-command))
      (goto-char (point-max))
      (message "Link search wrapped back to end of buffer"))
    (setq org-link-search-failed nil)
    (let* ((pos (point))
           (ct (org-context))
           (a (assoc :link ct))
           srch)
      (if a (goto-char (nth 1 a)))
      (while (and (setq srch (re-search-backward org-any-link-re nil t))
                  (goto-char (match-beginning 0))
                  (not (eq (org-invisible-p) 'org-link))))
      (if srch
          (goto-char (match-beginning 0))
        (goto-char pos)
        (setq org-link-search-failed t)
        (error "No further link found"))))
  (define-key org-mode-map "\M-n" 'org-next-visible-link)
  (define-key org-mode-map "\M-p" 'org-previous-visible-link)
  
  
  ;; M-x anything-org-agenda
  ;; http://d.hatena.ne.jp/r_takaishi/20101218/1292641216
  (when (require 'anything-org-mode nil t))
  
  ;; Emacs tech Book p282
  (setq org-use-fast-todo-selection t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE" "CANCEL(c)")
          (sequence "APPT(A)" "|" "DONE(x)" "CANCEL(c)")))
  (setq org-log-done 'time)
)

;; org-tree-slide.el
;; http://pastelwill.jp/wiki/doku.php?id=emacs:org-tree-slide
;; https://github.com/takaxp/org-tree-slide
;; https://raw.github.com/takaxp/org-tree-slide/master/org-tree-slide.el
(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f6>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f6>") 'org-tree-slide-skip-done-toggle)
  ;; エフェクト無効化
  (org-tree-slide-simple-profile)
  )

(provide 'init-org)
