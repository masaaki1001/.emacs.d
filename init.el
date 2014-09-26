(setq load-path (append '("~/.emacs.d"
                          "~/.emacs.d/elisp"
                          "~/.emacs.d/config"
                          "~/.emacs.d/auto-install"
                          "~/.emacs.d/ddskk/site-lisp"
                          )
                        load-path))

;; function add to load-path
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "repositories")

(setq repositories-dir
      (expand-file-name "repositories" user-emacs-directory))
(setq resource-dir
      (expand-file-name "resource" user-emacs-directory))

(setq is-mac (eq system-type 'darwin))
(setq is-linux (eq window-system 'x))

(require 'init-cask)
(require 'init-mac)
(require 'init-basic)
(require 'init-keybind)
(require 'init-dired)
(require 'init-recentf)
(require 'init-auto-complete)
(require 'init-window)
(require 'init-popwin)
(require 'init-elisp)
(require 'init-undo)
(require 'init-grep)
(require 'init-search)
(require 'init-html)
(require 'init-bm)
(require 'init-twitter)
(require 'init-migemo)
(require 'init-smartrep)
(require 'init-view)
(require 'init-buffer)
(require 'init-org)
(require 'init-ruby)
(require 'init-scala)
(require 'init-javascript)
(require 'init-typescript)
(require 'init-html)
(require 'init-markdown)
(require 'init-flycheck)
(require 'init-highlight)
(require 'init-log)
(require 'init-jump)
(require 'init-util)
(require 'init-edit-util)
(require 'init-helm)
(require 'init-eshell)
;; (require 'init-svn)
(require 'init-git)
(require 'init-ddskk)
(require 'init-yasnippet)
(require 'init-defun)
(require 'init-hatena)
(require 'init-modeline)

;; revive.el
;; 前回emacsを終了したときの状態を復元してくれる (resume)を実行すれば復元してくれるが、
;; そのためには各モードの設定を読み込んでいる必要があるので、一番最後に書いてある。
;; http://d.hatena.ne.jp/gan2/20080203/1202032426
;; http://tech.kayac.com/archive/emacs.html
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(setq revive:configuration-file (expand-file-name ".revive.el" resource-dir))
(define-key ctl-x-map "F" 'resume)                        ; C-x F で復元
(define-key ctl-x-map "K" 'wipe)                          ; C-x K で Kill
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に保存
(resume) ; 起動時に復元
