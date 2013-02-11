; -*- mode: lisp; coding: utf-8 -*-
;;(eval-when-compile (require 'cl))
(require 'helm-config)
(require 'helm-command)

;; (let ((key-and-func
;;        `((,(kbd "M-s")   helm-occur)
;;          (,(kbd "M-x")   helm-M-x)
;;          (,(kbd "M-y")   helm-show-kill-ring)
;;          (,(kbd "M-z")   helm-do-grep)
;;          )))
;;   (loop for (key func) in key-and-func
;;         do (global-set-key key func)))

;; (helm-mode 1)

(defun helm-mini ()
  "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
  (interactive)
  (helm-other-buffer '(helm-c-source-buffers-list
                       helm-c-source-recentf
                       helm-c-source-files-in-current-dir
                       helm-c-source-buffer-not-found
                       )
                     "*helm mini*"))

(defun helm-c-source-emacs-commands (&optional default)
  `((name . "Commands")
    (init . (lambda ()
              (helm-c-apropos-init 'commandp ,default)))
    (persistent-action . helm-lisp-completion-persistent-action)
    (persistent-help . "Show brief doc in mode-line")
    (candidates-in-buffer)
    (action . (lambda (candidate)
                (describe-function (intern candidate))))))

(defun my-helm-apropos ()
  (interactive)
  (require 'helm-elisp)
  (require 'helm-misc)
  (let ((default (thing-at-point 'symbol)))
    (helm
     :prompt "Info about: "
     :candidate-number-limit 15
     :sources
     (append '(helm-c-source-buffers-list
               helm-c-source-recentf
               helm-c-source-files-in-current-dir
               )
             (mapcar (lambda (func)
                       (funcall func default))
                     '(helm-c-source-emacs-commands
                       ))
             ))))
(global-set-key (kbd "C-;") 'my-helm-apropos)

(when (require 'helm-c-moccur nil t)
  (global-set-key (kbd "C-o") 'helm-c-moccur-occur-by-moccur)
  (global-set-key (kbd "C-M-o") 'helm-c-moccur-dmoccur)
  (add-hook 'dired-mode-hook
            '(lambda ()
               (local-set-key (kbd "O") 'helm-c-moccur-dired-do-moccur-by-moccur)))
  (global-set-key (kbd "C-M-s") 'helm-c-moccur-isearch-forward)
  (global-set-key (kbd "C-M-r") 'helm-c-moccur-isearch-backward)
  )

(when (require 'helm-git nil t)
  ;; (global-set-key (kbd "C-:") 'helm-git-find-files)
  (global-set-key (kbd "C-c :") 'helm-git-find-files)
  )

(setq session-save-print-spec '(t nil nil))

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-z") 'helm-do-grep)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-c i") 'helm-imenu)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

(provide 'init-helm)
