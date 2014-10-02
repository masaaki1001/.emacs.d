;;;; Git
(require 'magit)

;; 72文字折り返しを無効化
(add-hook 'git-commit-mode-hook 'turn-off-auto-fill)

;; disable vc-mode
(setq vc-handled-backends '())
(with-eval-after-load "vc"
  (remove-hook 'find-file-hooks 'vc-find-file-hook))

(setq magit-save-some-buffers nil
      magit-unstage-all-confirm nil)

(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c C-c g") 'magit-blame-mode)
(global-set-key (kbd "C-c C-c C-g") 'git-timemachine)

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

;; 確認を行なう
(defun my/magit-commit-extend ()
  (interactive)
  (when (yes-or-no-p "execute 'git commit --amend --no-edit' ?")
    (magit-commit-extend)))

(defun my/magit-reset-soft-head ()
  (interactive)
  (when (yes-or-no-p "execute 'git reset --soft HEAD^' ?")
    (magit-reset-head "HEAD^")))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)
(define-key magit-status-mode-map (kbd "C-c a") 'my/magit-commit-extend)
(define-key magit-status-mode-map (kbd "C-c r") 'magit-interactive-rebase) ;; default keybind 'E'
(define-key magit-status-mode-map (kbd "C-c C-r") 'my/magit-reset-soft-head)

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
  ;; (set-face-attribute 'diff-refine-change nil
  ;;                     :foreground nil :background nil
  ;;                     :weight 'bold :inverse-video t)
  )
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
  (set-face-background 'magit-item-highlight nil))
(add-hook 'magit-mode-hook 'magit-setup-diff)

;; Add an extra newline to separate commit message from git commentary
(defun magit-commit-mode-init ()
  (when (looking-at "\n")
    (open-line 1)))
(add-hook 'git-commit-mode-hook 'magit-commit-mode-init)
;; close popup when commiting
(defadvice git-commit-commit (after move-to-magit-buffer activate)
  (delete-window))

(when is-mac
  (setq magit-emacsclient-executable "/usr/local/Cellar/emacs/24.3/bin/emacsclient"))

(provide 'init-git)
