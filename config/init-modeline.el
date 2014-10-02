;;;; diminish
(with-eval-after-load "auto-complete" (diminish 'auto-complete-mode))
(with-eval-after-load "yasnippet" (diminish 'yas-minor-mode))
(with-eval-after-load "undo-tree" (diminish 'undo-tree-mode))
(with-eval-after-load "volatile-highlights" (diminish 'volatile-highlights-mode))
(with-eval-after-load "view" (diminish 'view-mode))
(with-eval-after-load "elisp-slime-nav" (diminish 'elisp-slime-nav-mode))
(with-eval-after-load "eldoc" (diminish 'eldoc-mode))
(with-eval-after-load "anzu"(diminish 'anzu-mode))
(with-eval-after-load "smartparens" (diminish 'smartparens-mode))
(with-eval-after-load "magit" (diminish 'magit-auto-revert-mode))
(with-eval-after-load "highlight-symbol" (diminish 'highlight-symbol-mode))

;; http://d.hatena.ne.jp/syohex/20130201/1359731697
(let ((cell (or (memq 'mode-line-position mode-line-format)
                (memq 'mode-line-buffer-identification mode-line-format)))
      (newcdr '(:eval (my/update-git-branch-mode-line))))
  (unless (member newcdr mode-line-format)
    (setcdr cell (cons newcdr (cdr cell)))))

(defun my/update-git-branch-mode-line ()
  (let* ((branch (replace-regexp-in-string
                  "[\r\n]+\\'" ""
                  (shell-command-to-string "git symbolic-ref -q HEAD")))
         (mode-line-str (if (string-match "^refs/heads/" branch)
                            (format "[Git:%s]" (substring branch 11))
                          "[Not Repo]")))
    (propertize mode-line-str
                'face '((:foreground "black" :weight normal)))))

(provide 'init-modeline)
