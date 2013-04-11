(require 'helm-config)
(require 'helm-command)
(require 'helm-elisp)
(require 'helm-misc)

(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0)
(setq helm-candidate-number-limit 300)
(setq helm-samewindow nil)
(setq helm-quick-update t)

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

(defvar helm-source-spaces
  '((name . "Spaces")
    (candidates . sp-space-names)
    (action ("Switch" . sp-apply-space-config))))

(defun helm-spaces ()
  (interactive)
  (helm
     :prompt "pattern: "
     :sources
     (append '(helm-source-spaces)
             )))

;; (defun helm-mini ()
;;   (interactive)
;;   (helm-other-buffer '(helm-source-buffers-list
;;                        helm-source-recentf
;;                        helm-source-files-in-current-dir
;;                        helm-source-emacs-commands
;;                        helm-source-bookmarks-local
;;                        helm-source-buffer-not-found
;;                        )
;;                      "*helm mini*"))

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

(when (require 'helm-c-moccur nil t)
  (global-set-key (kbd "C-c C-o") 'helm-c-moccur-occur-by-moccur)
  (global-set-key (kbd "C-c C-M-o") 'helm-c-moccur-dmoccur)
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
;; (when (require 'helm-project nil t)
;;   (global-set-key (kbd "C-:") 'helm-project)
;;   (hp:add-project
;;    ;; setting templete
;;    ;; :name 'hoge
;;    ;; :look-for '("Rakefile")
;;    ;; :include-regexp '("\\.rb$" "\\.html$" "\\.erb$" "\\.js$" "\\.yml$" "\\.css$" "\\Gemfile$")
;;    ;:exclude-regexp "/test_files" ; can be regexp or list of regexp
;;    :name 'project
;;    :look-for '(".git")
;;    :include-regexp '("\\.scala$" "\\.html$" "\\.conf$" "\\.properties$" "\\.sbt$" "\\.sql$" "\\routes$" "\\.js$")
;;    :exclude-regexp "/target*"
;;    )
;;   ;; 候補にディレクトリが含まれないようにする
;;   ;; http://d.hatena.ne.jp/IMAKADO/20090823/1250963119
;;   (setq hp:project-files-filters
;;         (list
;;          (lambda (files)
;;            (remove-if 'file-directory-p files))))
;;   )

;; helm-c-yasnippet.el
(when (require 'helm-c-yasnippet nil t)
  (setq helm-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
  (global-set-key (kbd "C-c y") 'helm-c-yas-complete) ;C-c yで起動
  )

(require 'helm-replace-string nil t)

(require 'imenu-anywhere nil t)

;; (global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-z") 'helm-do-grep)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
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
