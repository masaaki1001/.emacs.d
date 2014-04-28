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
;; (require 'init-elpa nil t)
;; Cask
(require 'init-cask nil t)
;; Mac用設定
(require 'init-mac nil t)
;; env
(require 'init-env nil t)
;; basic
(require 'init-basic nil t)
;; keybind
(require 'init-keybind nil t)
;; filecache
(require 'init-filecache nil t)
;; dired
(require 'init-dired nil t)
;; recentf
(require 'init-recentf nil t)
;; auto-complete
(require 'init-auto-complete nil t)
;; window
(require 'init-window nil t)
;; popwin
(require 'init-popwin nil t)
;; elisp
(require 'init-elisp nil t)
;; undo
(require 'init-undo nil t)
;; grep
(require 'init-grep nil t)
;; search
(require 'init-search nil t)
;; html
(require 'init-html nil t)
;; bm.el
(require 'init-bm nil t)
;; twittering-mode
(require 'init-twitter nil t)
;; migemo
(require 'init-migemo nil t)
;; smartrep
(require 'init-smartrep nil t)
;; view-mode
(require 'init-view nil t)
;; Buffer関連
(require 'init-buffer nil t)
;; org-mode
(require 'init-org nil t)
;; ruby
(require 'init-ruby nil t)
;; scala
(require 'init-scala nil t)
;; javascript
(require 'init-javascript nil t)
;; typescript
(require 'init-typescript nil t)
;; htlm
(require 'init-html nil t)
;; markdown
(require 'init-markdown nil t)
;; flymake
;; (require 'init-flymake nil t)
;; flycheck
(require 'init-flycheck nil t)
;; highlight
(require 'init-highlight nil t)
;; log
(require 'init-log nil t)
;; jump
(require 'init-jump nil t)
;; util
(require 'init-util nil t)
;; edit-util
(require 'init-edit-util nil t)
;; anything
(require 'init-anything nil t)
;; helm
(require 'init-helm nil t)
;; shell
(require 'init-shell nil t)
;; eshell
(require 'init-eshell nil t)
;; svn
;; (require 'init-svn nil t)
;; git
(require 'init-git nil t)
;; ddskk
(require 'init-ddskk nil t)
;; yasnippet
(require 'init-yasnippet nil t)
;; defun
(require 'init-defun nil t)
;; hatena-mode
(require 'init-hatena nil t)
;; w3m
(require 'init-w3m nil t)
;; apache
(require 'init-apache nil t)
;; mode-line
(require 'init-modeline nil t)

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
