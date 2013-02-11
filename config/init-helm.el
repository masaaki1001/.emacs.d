; -*- mode: lisp; coding: utf-8 -*-
;;(eval-when-compile (require 'cl))
(require 'helm-config)
(require 'helm-command)
(require 'helm-elisp)
(require 'helm-misc)

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
                       helm-c-source-emacs-commands
                       ;; helm-c-source-elscreen
                       helm-c-source-bookmarks-local
                       helm-c-source-buffer-not-found
                       )
                     "*helm mini*"))

;; (defun helm-c-source-emacs-commands (&optional default)
;;   `((name . "Commands")
;;     (init . (lambda ()
;;               (helm-c-apropos-init 'commandp ,default)))
;;     (persistent-action . helm-lisp-completion-persistent-action)
;;     (persistent-help . "Show brief doc in mode-line")
;;     (candidates-in-buffer)
;;     (action . (lambda (candidate)
;;                 (describe-function (intern candidate))))))


(defvar helm-c-source-emacs-commands
  '((name . "Emacs Commands")
    (candidates . (lambda ()
                    (let (commands)
                      (mapatoms (lambda (a)
                                  (if (commandp a)
                                      (push (symbol-name a)
                                            commands))))
                      (sort commands 'string-lessp))))
    (type . command)
    (requires-pattern . 2))
  "Source for completing and invoking Emacs commands.
A command is a function with interactive spec that can
be invoked with `M-x'.

To get non-interactive functions listed, use
`helm-c-source-emacs-functions'.")

(defun my-helm ()
  (interactive)
  (let ((default (thing-at-point 'symbol)))
    (helm
     :prompt "Info about: "
     :candidate-number-limit 15
     :sources
     (append '(helm-c-source-buffers-list
               helm-c-source-recentf
               helm-c-source-files-in-current-dir
               helm-c-source-bookmarks-local
               helm-c-source-emacs-commands
               ;; helm-def-source--emacs-commands
               )
             ;; (mapcar (lambda (func)
             ;;           (funcall func default))
             ;;         '(helm-c-source-emacs-commands
             ;;           ))
             ))))
(global-set-key (kbd "C-;") 'my-helm)

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

(require 'em-glob)
(defvar junk-file-dir "~/.emacs.d/junk/")
(defvar junk-file-list
  (reverse (eshell-extended-glob (concat
                                  (file-name-as-directory junk-file-dir)
                                  "*"))))
(defvar helm-c-source-junk-files
  '((name . "Junk Files")
    (candidates . junk-file-list)
    (type . file)))
(defun helm-open-junk-file ()
  (interactive)
  (helm-other-buffer 'helm-c-source-junk-files "*helm for junk file"))
(global-set-key (kbd "C-x M-j") 'helm-open-junk-file)

;; helm-project.el
(when (require 'helm-project nil t)
;(global-set-key (kbd "C-c C-f") 'anything-project)
  (global-set-key (kbd "C-:") 'hlm-project)
  (hp:add-project
   ;; templete
   ;; :name 'hoge
   ;; :look-for '("Rakefile")
   ;; :include-regexp '("\\.rb$" "\\.html$" "\\.erb$" "\\.js$" "\\.yml$" "\\.css$" "\\Gemfile$")
   ;:exclude-regexp "/test_files" ; can be regexp or list of regexp
   :name 'Ripple
   :look-for '(".gitignore")
   :include-regexp '("\\.scala$" "\\.html$" "\\.conf$" "\\.properties$" "\\.sbt$" "\\.sql$" "\\routes$" "\\.js$")
   )
  ;; 候補にディレクトリが含まれないようにする
  ;; http://d.hatena.ne.jp/IMAKADO/20090823/1250963119
  (setq hp:project-files-filters
        (list
         (lambda (files)
           (remove-if 'file-directory-p files))))
  )

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-z") 'helm-do-grep)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c e") 'helm-elscreen)
(global-set-key (kbd "C-M-z") 'helm-resume)

(define-key helm-map (kbd "C-p")   'helm-previous-line)
(define-key helm-map (kbd "C-n")   'helm-next-line)
(define-key helm-map (kbd "C-M-n") 'helm-next-source)
(define-key helm-map (kbd "C-M-p") 'helm-previous-source)

(provide 'init-helm)
