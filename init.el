;; load-path
;;http://d.hatena.ne.jp/omochist/20070207/1170872589
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

;; load-path
;; e.g. (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "repositories")

;; directory
(setq repositories-dir
      (expand-file-name "repositories" user-emacs-directory))
(setq resource-dir
      (expand-file-name "resource" user-emacs-directory))

;; OS
(setq is-mac (eq system-type 'darwin))
(setq is-linux (eq window-system 'x))

;; elpa, marmalade, melpa, auto-install etc...
;; (require 'init-elpaa)
;; Cask
(require 'init-cask)
;; Mac用設定
(require 'init-mac)
;; env
(require 'init-env)
;; basic
(require 'init-basic)
;; keybind
(require 'init-keybind)
;; filecache
(require 'init-filecache)
;; dired
(require 'init-dired)
;; recentf
(require 'init-recentf)
;; auto-complete
(require 'init-auto-complete)
;; window
(require 'init-window)
;; popwin
(require 'init-popwin)
;; elisp
(require 'init-elisp)
;; undo
(require 'init-undo)
;; grep
(require 'init-grep)
;; search
(require 'init-search)
;; html
(require 'init-html)
;; bm.el
(require 'init-bm)
;; twittering-mode
(require 'init-twitter)
;; migemo
(require 'init-migemo)
;; smartrep
(require 'init-smartrep)
;; view-mode
(require 'init-view)
;; Buffer関連
(require 'init-buffer)
;; org-mode
(require 'init-org)
;; ruby
(require 'init-ruby)
;; scala
(require 'init-scala)
;; javascript
(require 'init-javascript)
;; typescript
(require 'init-typescript)
;; htlm
(require 'init-html)
;; markdown
(require 'init-markdown)
;; flycheck
(require 'init-flycheck)
;; highlight
(require 'init-highlight)
;; log
(require 'init-log)
;; jump
(require 'init-jump)
;; util
(require 'init-util)
;; edit-util
(require 'init-edit-util)
;; helm
(require 'init-helm)
;; shell
(require 'init-shell)
;; eshell
(require 'init-eshell)
;; svn
;; (require 'init-svn)
;; git
(require 'init-git)
;; ddskk
(require 'init-ddskk)
;; yasnippet
(require 'init-yasnippet)
;; defun
(require 'init-defun)
;; hatena-mode
(require 'init-hatena)
;; w3m
(require 'init-w3m)
;; mode-line
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
