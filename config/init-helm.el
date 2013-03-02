(require 'helm-config)
(require 'helm-command)
(require 'helm-elisp)
(require 'helm-misc)

;; (helm-mode 1)

(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0)
(setq helm-candidate-number-limit 300)
(setq helm-samewindow nil)

(defun helm-mini ()
  "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
  (interactive)
  (helm-other-buffer '(helm-c-source-buffers-list
                       helm-c-source-recentf
                       helm-c-source-files-in-current-dir
                       helm-c-source-emacs-commands
                       helm-c-source-bookmarks-local
                       helm-c-source-buffer-not-found
                       )
                     "*helm mini*"))

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
    (requires-pattern . 2)))

(defun my-helm ()
  (interactive)
  (let ((default (thing-at-point 'symbol)))
    (helm
     :prompt "Info about: "
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

  (setq helm-c-moccur-enable-auto-look-flag t)
  )

(when (require 'helm-ls-git nil t)
  (global-set-key (kbd "C-c :") 'helm-ls-git-ls)
  )

(when (require 'helm-open-junk-file nil t)
  (global-set-key (kbd "C-x M-j") 'helm-open-junk-file)
  )


;; helm-project.el
(when (require 'helm-project nil t)
;(global-set-key (kbd "C-c C-f") 'anything-project)
  (global-set-key (kbd "C-:") 'helm-project)
  (hp:add-project
   ;; setting templete
   ;; :name 'hoge
   ;; :look-for '("Rakefile")
   ;; :include-regexp '("\\.rb$" "\\.html$" "\\.erb$" "\\.js$" "\\.yml$" "\\.css$" "\\Gemfile$")
   ;:exclude-regexp "/test_files" ; can be regexp or list of regexp
   :name 'Ripple
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

;; helm-c-yasnippet.el
(when (require 'helm-c-yasnippet nil t)
  (setq helm-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
  (global-set-key (kbd "C-c y") 'helm-c-yas-complete) ;C-c yで起動
  )

(when (require 'helm-replace-string nil t))

(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x f") 'helm-find-files)
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
