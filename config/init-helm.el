;;;; helm
(require 'helm-config)
(require 'helm-command)
(require 'helm-bm)

(setq helm-idle-delay 0.1
      helm-input-idle-delay 0
      helm-candidate-number-limit 300
      helm-quick-update t
      helm-delete-minibuffer-contents-from-point t
      helm-buffer-max-length 50
      ;; helm-move-to-line-cycle-in-source t
      ;; helm-ff-transformer-show-only-basename nil
      )

(helm-match-plugin-mode)

;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

(defun my/helm ()
  (interactive)
  (let ((default (thing-at-point 'symbol))
        (helm-ff-transformer-show-only-basename nil))
    (helm
     :sources
     (append '(helm-source-buffers-list
               helm-source-recentf
               helm-source-ls-git
               helm-source-files-in-current-dir
               ;; helm-source-bookmarks
               helm-source-bm
               helm-source-buffer-not-found
               )
             ))))
(global-set-key (kbd "C-;") 'my/helm)

(when (require 'helm-swoop nil t)
  (custom-set-faces
   '(helm-swoop-target-line-block-face ((t (:background "dark olive green"))))
   '(helm-swoop-target-line-face ((t (:background "dark olive green"))))
   '(helm-swoop-target-word-face ((t nil))))
  (global-set-key (kbd "C-c C-o") 'helm-swoop)
  )

(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
(define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur)

(when (require 'helm-ls-git nil t)
  (when (locate-library "magit")
    (setq helm-ls-git-status-command 'magit-status))
  (setq helm-ls-git-show-abs-or-relative 'relative)
  (global-set-key (kbd "C-c :") 'helm-ls-git-ls)
  )

(require 'helm-git-files nil t)

(when (require 'helm-projectile nil t)
  (global-set-key (kbd "C-c C-p") 'helm-projectile)
  ;; (setq projectile-require-project-root nil)
  )

;; helm-c-yasnippet.el
(when (require 'helm-c-yasnippet nil t)
  (setq helm-c-yas-space-match-any-greedy t)
  (global-set-key (kbd "C-c y") 'helm-c-yas-complete)
  )

(when (require 'helm-descbinds nil t)
  (helm-descbinds-mode))

(require 'helm-ag nil t)
(require 'helm-rails nil t)
(require 'imenu-anywhere nil t)

(global-set-key (kbd "C-c C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x C-m") 'helm-M-x)
(global-set-key [remap execute-extended-command] 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c b") 'helm-bm)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c I") 'helm-imenu-anywhere)
(global-set-key (kbd "C-c e") 'helm-elscreen)
(global-set-key (kbd "C-c C-s") 'helm-spaces)
(global-set-key (kbd "C-M-z") 'helm-resume)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
;; For find-file etc.
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; For helm-find-files etc.
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

(provide 'init-helm)
