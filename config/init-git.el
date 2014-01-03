;;;; Git
(when (require 'magit nil t)
  (setq-default
   magit-save-some-buffers nil)

  (global-set-key (kbd "C-c g") 'magit-status)

  (require 'magit-blame nil t)
  (require 'magit-svn nil t)

  ;; full screen magit-status
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defun magit-quit-session ()
    "Restores the previous window configuration and kills the magit buffer"
    (interactive)
    (kill-buffer)
    (jump-to-register :magit-fullscreen))

  (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

  ;; http://www.clear-code.com/blog/2012/4/3.html
  ;; diffの表示方法を変更
  (defun diff-mode-setup-faces ()
    ;; 追加された行は緑で表示
    (set-face-attribute 'diff-added nil
                        :foreground "white" :background "dark green")
    ;; 削除された行は赤で表示
    (set-face-attribute 'diff-removed nil
                        :foreground "white" :background "dark red")
    ;; 文字単位での変更箇所は色を反転して強調
    (set-face-attribute 'diff-refine-change nil
                        :foreground nil :background nil
                        :weight 'bold :inverse-video t))
  (add-hook 'magit-diff-mode-hook 'diff-mode-setup-faces)

  ;; diffを表示したらすぐに文字単位での強調表示も行う
  (defun diff-mode-refine-automatically ()
    (diff-auto-refine-mode t))
  (add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

  ;; diff関連の設定
  (defun magit-setup-diff ()
    ;; diffを表示しているときに文字単位での変更箇所も強調表示する
    ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
    (setq magit-diff-refine-hunk 'all)
    ;; diff用のfaceを設定する
    (diff-mode-setup-faces)
    ;; diffの表示設定が上書きされてしまうのでハイライトを無効にする
    (set-face-attribute 'magit-item-highlight nil :inherit nil)
    (set-face-background 'magit-item-highlight nil)
    )
  (add-hook 'magit-mode-hook 'magit-setup-diff)

  (defun magit-save-and-exit-commit-mode ()
    (interactive)
    (save-buffer)
    (server-edit)
    (delete-window))

  (defun magit-exit-commit-mode ()
    (interactive)
    (kill-buffer)
    (delete-window))

  (eval-after-load "git-commit-mode"
    '(define-key git-commit-mode-map (kbd "C-c C-k") 'magit-exit-commit-mode))

  ;; Add an extra newline to separate commit message from git commentary
  (defun magit-commit-mode-init ()
    (when (looking-at "\n")
      (open-line 1)))
  (add-hook 'git-commit-mode-hook 'magit-commit-mode-init)
  ;; close popup when commiting
  (defadvice git-commit-commit (after delete-window activate)
    (delete-window))

  (when is-mac
    (setq magit-emacsclient-executable "/usr/local/Cellar/emacs/24.3/bin/emacsclient"))

)

;; yagist.el
(require 'yagist nil t)

(when (require 'git-messenger)
  (global-set-key (kbd "C-x v p") 'git-messenger:popup-message))

(add-to-list 'auto-mode-alist '(".gitmodules"   . gitconfig-mode))

(provide 'init-git)
