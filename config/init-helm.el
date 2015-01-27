(require 'helm-bm)
(require 'helm-ls-git)

(setq helm-idle-delay 0.1
      helm-input-idle-delay 0
      helm-exit-idle-delay 0
      helm-candidate-number-limit 300
      helm-delete-minibuffer-contents-from-point t
      helm-ff-file-name-history-use-recentf t
      helm-samewindow nil
      helm-buffer-max-length 50
      helm-M-x-fuzzy-match t)

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
       ,(helm-make-source "Git files status" 'helm-ls-git-status-source)
       ,(helm-make-source "Git files" 'helm-ls-git-source)
       helm-source-files-in-current-dir
       helm-source-bm
       helm-source-buffer-not-found))))

;; helm-swoop
(setq helm-swoop-pre-input-function 'ignore
      helm-swoop-speed-or-color t
      helm-swoop-use-line-number-face t)

(define-key isearch-mode-map (kbd "C-o") 'helm-swoop-from-isearch)

;; helm-ag
(setq helm-ag-insert-at-point 'symbol)

;; helm-bm
;; http://rubikitch.com/2014/11/22/helm-bm/
(setq helm-source-bm (delete '(multiline) helm-source-bm))

(global-set-key (kbd "C-;") 'my/helm)
(global-set-key (kbd "C-c C-o") 'helm-swoop)
(global-set-key (kbd "C-c ;") 'helm-ls-git-ls)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(global-set-key (kbd "C-c C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
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

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(with-eval-after-load 'helm-files
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action))

(with-eval-after-load 'helm
  (helm-descbinds-mode)
  (helm-match-plugin-mode))

(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

(provide 'init-helm)
