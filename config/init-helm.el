;;;; helm
(require 'helm-config)
(require 'helm-command)
(require 'helm-descbinds)

(setq helm-idle-delay 0.1
      helm-input-idle-delay 0
      helm-candidate-number-limit 300
      helm-samewindow nil
      helm-quick-update t
      helm-delete-minibuffer-contents-from-point t
      ;; helm-move-to-line-cycle-in-source t
      ;; helm-ff-transformer-show-only-basename nil
      )

(helm-descbinds-mode)
(helm-match-plugin-mode)

;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
(defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
  "Emulate `kill-line' in helm minibuffer"
  (kill-new (buffer-substring (point) (field-end))))

(defvar helm-source-emacs-commands
  '((name . "Emacs Commands")
    (candidates . (lambda ()
                    (let (commands)
                      (mapatoms (lambda (a)
                                  (if (commandp a)
                                      (push (symbol-name a)
                                            commands))))
                      (sort commands 'string-lessp))))
    (type . command)
    (requires-pattern . 2)))

(defun my-helm ()
  (interactive)
  (let ((default (thing-at-point 'symbol)))
    (helm
     :prompt "pattern: "
     :sources
     (append '(helm-source-buffers-list
               helm-source-recentf
               helm-source-files-in-current-dir
               helm-source-emacs-commands
               helm-source-pp-bookmarks
               helm-source-buffer-not-found
               )
             ))))
(global-set-key (kbd "C-;") 'my-helm)

(when (require 'helm-swoop nil t)
  (custom-set-faces
   '(helm-swoop-target-line-block-face ((t (:background "dark olive green"))))
   '(helm-swoop-target-line-face ((t (:background "dark olive green"))))
   '(helm-swoop-target-word-face ((t nil))))
  (global-set-key (kbd "C-c C-o") 'helm-swoop)
  )

(define-key isearch-mode-map (kbd "M-o") 'helm-occur-from-isearch)
(define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur)

(when (require 'helm-ls-git nil t)
  (setq helm-ls-git-show-abs-or-relative 'relative)
  (global-set-key (kbd "C-c :") 'helm-ls-git-ls)
  )

(require 'helm-git-files nil t)

;; helm-project.el
;; http://d.hatena.ne.jp/yuheiomori0718/20111226/1324902529
(when (require 'helm-project nil t)
  (global-set-key (kbd "C-:") 'helm-project)
  (hp:add-project
   :name 'project
   :look-for '(".git")
   :include-regexp '("\\.scala$" "\\.html$" "\\.conf$" "\\.properties$" "\\.sbt$" "\\.sql$" "\\routes$" "\\.js$")
   :exclude-regexp "/target*"
   )
  ;; 候補にディレクトリが含まれないようにする
  ;; http://d.hatena.ne.jp/IMAKADO/20090823/1250963119
  (setq hp:project-files-filters
        (list
         (lambda (files)
           (remove-if 'file-directory-p files))))
  )

(when (require 'helm-projectile)
  (global-set-key (kbd "C-c C-p") 'helm-projectile)
  )

;; helm-c-yasnippet.el
(when (require 'helm-c-yasnippet nil t)
  (setq helm-c-yas-space-match-any-greedy t)
  (global-set-key (kbd "C-c y") 'helm-c-yas-complete)
  )

(require 'helm-ag nil t)
(require 'helm-rails nil t)
(require 'imenu-anywhere nil t)

(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-m") 'helm-M-x)
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

(provide 'init-helm)
