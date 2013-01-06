; -*- mode: lisp; coding: utf-8 -*-
;;(eval-when-compile (require 'cl))
(require 'helm-config)
;; (require 'helm-command)

;; (let ((key-and-func
;;        `((,(kbd "M-s")   helm-occur)
;;          (,(kbd "M-x")   helm-M-x)
;;          (,(kbd "M-y")   helm-show-kill-ring)
;;          (,(kbd "M-z")   helm-do-grep)
;;          )))
;;   (loop for (key func) in key-and-func
;;         do (global-set-key key func)))

;; (global-set-key (kbd "C-;") 'helm-mini)
;; (helm-mode 1)
;; (defun helm-mini ()
;;   "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
;;   (interactive)
;;   (helm-other-buffer '(helm-c-source-buffers-list
;;                        helm-c-source-recentf
;;                        helm-c-source-files-in-current-dir
;;                        )
;;                      "*helm mini*"))
;; (defun my-helm-apropos ()
;;   (interactive)
;;   (let ((default (thing-at-point 'symbol)))
;;     (helm
;;      :prompt "Info about: "
;;      :candidate-number-limit 15
;;      :sources
;;      (append '(helm-c-source-buffers-list
;;                helm-c-source-recentf
;;                helm-c-source-files-in-current-dir
;;                )
;;              (mapcar (lambda (func)
;;                        (funcall func default))
;;                      '(helm-c-source-emacs-commands
;;                        ))
;;              ))))
;; (global-set-key (kbd "C-;") 'my-helm-apropos)

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
  (global-set-key (kbd "C-:") 'helm-git-find-files))


(provide 'init-helm)
