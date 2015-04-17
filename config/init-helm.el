(require 'helm-bm)
(require 'helm-ls-git)

(custom-set-faces
 '(helm-match ((t (:inherit match))))
 '(helm-swoop-target-line-block-face ((t (:background "dark olive green"))))
 '(helm-swoop-target-line-face ((t (:background "dark olive green"))))
 '(helm-swoop-target-word-face ((t nil))))

(defun my/helm ()
  (interactive)
  (let ((default (thing-at-point 'symbol))
        (helm-ff-transformer-show-only-basename nil))
    (helm
     :sources
     `(,(helm-make-source "Buffers" 'helm-source-buffers)
       helm-source-recentf
       ,(helm-make-source "Git files" 'helm-ls-git-source)
       helm-source-files-in-current-dir
       helm-source-bm
       helm-source-buffer-not-found))))

;; helm-swoop
(with-eval-after-load 'helm-swoop
  (setq helm-swoop-pre-input-function 'ignore
        helm-swoop-speed-or-color t
        helm-swoop-use-line-number-face t))

(define-key isearch-mode-map (kbd "C-o") 'helm-swoop-from-isearch)

;; helm-ag
(with-eval-after-load 'helm-ag
  (setq helm-ag-insert-at-point 'symbol))


;; helm-bm
;; http://rubikitch.com/2014/11/22/helm-bm/
(with-eval-after-load 'helm-bm
  (setq helm-source-bm (delete '(multiline) helm-source-bm)))

(global-set-key (kbd "C-;") 'my/helm)
(global-set-key (kbd "C-c C-o") 'helm-swoop)
(global-set-key (kbd "C-c C-a") 'helm-ag)
(global-set-key (kbd "C-c ;") 'helm-ls-git-ls)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-m") 'helm-M-x)
;; (global-set-key [remap execute-extended-command] 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c b") 'helm-bm)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c e") 'helm-elscreen)
(global-set-key (kbd "C-M-z") 'helm-resume)
(global-set-key (kbd "C-c M-/") 'helm-dabbrev)
(global-set-key (kbd "C-c C-p") 'helm-projectile)
(global-set-key (kbd "C-c M-j") 'helm-open-junk-files)

(with-eval-after-load 'helm
  (fset 'helm-show-candidate-number 'ignore)
  (helm-descbinds-mode)

  (setq helm-idle-delay 0.1
        helm-input-idle-delay 0
        helm-exit-idle-delay 0
        helm-candidate-number-limit 100
        helm-delete-minibuffer-contents-from-point t
        helm-ff-file-name-history-use-recentf t
        helm-move-to-line-cycle-in-source nil
        helm-samewindow nil
        helm-buffer-max-length 50
        helm-M-x-fuzzy-match t
        helm-quick-update t)

  (define-key helm-map (kbd "C-p")   'helm-previous-line)
  (define-key helm-map (kbd "C-n")   'helm-next-line)
  (define-key helm-map (kbd "C-M-n") 'helm-next-source)
  (define-key helm-map (kbd "C-M-p") 'helm-previous-source)
  (define-key helm-map (kbd "C-'") 'ace-jump-helm-line-and-execute-action)

  (setq ace-jump-helm-line-use-avy-style nil)

  ;; http://rubikitch.com/2015/04/16/ace-jump-helm-line/
  (defun ace-jump-helm-line-and-execute-action ()
    "anything-select-with-prefix-shortcut互換"
    (interactive)
    (condition-case nil
        (progn (ace-jump-helm-line)
               (helm-exit-minibuffer))
      (error (ajhl--insert-last-char))))

  ;; http://rubikitch.com/2014/12/19/helm-buffers-sort-transformer/
  (defadvice helm-buffers-sort-transformer (around ignore activate)
    (setq ad-return-value (ad-get-arg 0)))

  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
    "Emulate `kill-line' in helm minibuffer"
    (kill-new (buffer-substring (point) (field-end)))))

(with-eval-after-load 'helm-files
  (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
    "Execute command only if CANDIDATE exists"
    (when (file-exists-p candidate)
      ad-do-it)))

(provide 'init-helm)
