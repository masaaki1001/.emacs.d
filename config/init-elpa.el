;;----------------------------------------------------------------------------
;; package.el
;; http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el
;;----------------------------------------------------------------------------
(require 'package)

(defvar gnu '("gnu" . "http://elpa.gnu.org/packages/"))
(defvar marmalade '("marmalade" . "http://marmalade-repo.org/packages/"))
(defvar melpa '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives gnu t)
(add-to-list 'package-archives marmalade t)
(add-to-list 'package-archives melpa t)

(package-initialize)

;; https://github.com/magnars/.emacs.d/blob/master/setup-package.el
(defun packages-install (&rest packages)
  (mapc (lambda (package)
          (let ((name (car package))
                (repo (cdr package)))
            (when (not (package-installed-p name))
              (let ((package-archives (list repo)))
                (package-initialize)
                (package-install name)))))
        packages)
  (package-initialize)
  (delete-other-windows))

(defun init-install-packages ()
  (packages-install
   (cons 'melpa melpa)
   (cons 'auto-install melpa)
   (cons 'ruby-mode melpa)
   (cons 'robe melpa)
   (cons 'ruby-electric melpa)
   (cons 'ruby-block melpa)
   (cons 'inf-ruby melpa)
   (cons 'ruby-interpolation melpa)
   (cons 'rbenv melpa)
   (cons 'dired+ melpa)
   (cons 'dsvn melpa)
   (cons 'rainbow-mode gnu)
   (cons 'fold-dwim melpa)
   (cons 'goto-chg melpa)
   (cons 'key-chord melpa)
   (cons 'maxframe melpa)
   (cons 'color-moccur melpa)
   (cons 'diminish melpa)
   (cons 'git-commit-mode melpa)
   (cons 'gitconfig-mode melpa)
   (cons 'gitignore-mode melpa)
   (cons 'elscreen melpa)
   (cons 'flycheck melpa)
   (cons 'slime-js marmalade)
   (cons 'point-undo melpa)
   (cons 'all-ext melpa)
   (cons 'replace-from-region melpa)
   (cons 'multi-term melpa)
   (cons 'redo+ melpa)
   (cons 'bash-completion melpa)
   (cons 'yagist melpa)
   (cons 'scala-mode melpa)
   (cons 'scala-mode2 melpa)
   (cons 'helm melpa)
   (cons 'helm-c-moccur melpa)
   (cons 'helm-ls-git melpa)
   (cons 'helm-c-yasnippet melpa)
   (cons 'htmlize melpa)
   (cons 'zencoding-mode melpa)
   (cons 'ack-and-a-half melpa)
   (cons 'color-moccur melpa)
   (cons 'session melpa)
   (cons 'savekill melpa)
   (cons 'sticky melpa)
   (cons 'open-junk-file melpa)
   (cons 'recentf-ext melpa)
   (cons 'viewer melpa)
   ;; (cons 'minimap melpa)
   ))

(condition-case nil
    (init-install-packages)
  (error
   (package-refresh-contents)
   (init-install-packages)))

;;----------------------------------------------------------------------------
;; auto-install.el
;;----------------------------------------------------------------------------
(when (require 'auto-install nil t)
 (setq auto-install-directory "~/.emacs.d/auto-install/")
 (auto-install-update-emacswiki-package-name t)
 (auto-install-compatibility-setup)             ; 互換性確保
 )

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;; もし el-get がなければインストールを行う
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (end-of-buffer)
       (eval-print-last-sexp)))))
(require 'el-get)

(provide 'init-elpa)
