;;----------------------------------------------------------------------------
;; load-path
;;----------------------------------------------------------------------------
;;http://d.hatena.ne.jp/omochist/20070207/1170872589
(setq load-path (append '("~/.emacs.d"
                          "~/.emacs.d/elisp"
                          "~/.emacs.d/config"
                          "~/.emacs.d/auto-install"
                          "~/.emacs.d/ddskk/elisp"
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

;;----------------------------------------------------------------------------
;; env
;;----------------------------------------------------------------------------
(require 'env)

;;----------------------------------------------------------------------------
;; Mac用設定
;;----------------------------------------------------------------------------
(require 'init-mac nil t)

;;----------------------------------------------------------------------------
;; global
;;----------------------------------------------------------------------------
(require 'init-global nil t)

;;----------------------------------------------------------------------------
;; elpa, marmalade, melpa, auto-install etc...
;;----------------------------------------------------------------------------
(require 'init-elpa nil t)

;;----------------------------------------------------------------------------
;; keybind
;;----------------------------------------------------------------------------
(require 'init-keybind nil t)

;;----------------------------------------------------------------------------
;; filecache
;;----------------------------------------------------------------------------
(require 'init-filecache nil t)

;;----------------------------------------------------------------------------
;; dired
;;----------------------------------------------------------------------------
(require 'init-dired nil t)

;;----------------------------------------------------------------------------
;; recentf
;;----------------------------------------------------------------------------
(require 'init-recentf nil t)

;;----------------------------------------------------------------------------
;; auto-complete
;;----------------------------------------------------------------------------
(require 'init-auto-complete nil t)

;;----------------------------------------------------------------------------
;; 各種elisp
;;----------------------------------------------------------------------------
(require 'init-elisp nil t)

;;----------------------------------------------------------------------------
;; undo
;;----------------------------------------------------------------------------
(require 'init-undo nil t)

;;----------------------------------------------------------------------------
;; grep
;;----------------------------------------------------------------------------
(require 'init-grep nil t)

;;----------------------------------------------------------------------------
;; jump
;;----------------------------------------------------------------------------
(require 'init-jump nil t)

;; html
;;----------------------------------------------------------------------------
(require 'init-html nil t)

;;----------------------------------------------------------------------------
;; bm.el
;;----------------------------------------------------------------------------
(require 'init-bm nil t)

;;----------------------------------------------------------------------------
;; twittering-mode.el
;; http://www.emacswiki.org/emacs/TwitteringMode-ja
;; http://www.kototone.jp/com/how_to_use_twittering-mode.html
;;----------------------------------------------------------------------------
(require 'init-twitter nil t)

;;----------------------------------------------------------------------------
;; migemo.el
;;----------------------------------------------------------------------------
(require 'init-migemo nil t)

;;----------------------------------------------------------------------------
;; calfw.el
;;----------------------------------------------------------------------------
(require 'init-calfw nil t)

;;----------------------------------------------------------------------------
;; smartrep.el
;;----------------------------------------------------------------------------
(require 'init-smartrep nil t)

;;----------------------------------------------------------------------------
;; view-mode
;; Emacs mail magazine
;;----------------------------------------------------------------------------
(require 'init-view nil t)

;;----------------------------------------------------------------------------
;; Buffer関連
;;----------------------------------------------------------------------------
(require 'init-buffer nil t)

;;----------------------------------------------------------------------------
;; org-mode
;;----------------------------------------------------------------------------
(require 'init-org nil t)

;;----------------------------------------------------------------------------
;; ruby
;;----------------------------------------------------------------------------
(require 'init-ruby nil t)

;;----------------------------------------------------------------------------
;; scala
;;----------------------------------------------------------------------------
(require 'init-scala nil t)

;;----------------------------------------------------------------------------
;; javascript
;;----------------------------------------------------------------------------
(require 'init-javascript nil t)

;;----------------------------------------------------------------------------
;; htlm
;;----------------------------------------------------------------------------
(require 'init-html nil t)

;;----------------------------------------------------------------------------
;; flymake
;;----------------------------------------------------------------------------
(require 'init-flymake nil t)

;;----------------------------------------------------------------------------
;; anything.el or helm.el
;;----------------------------------------------------------------------------
;;(require 'init-anything nil t)
(require 'init-helm nil t)

;;---------------------------------------------------------
;; shell
;;---------------------------------------------------------
(require 'init-shell nil t)

;;---------------------------------------------------------
;; Eshell
;;---------------------------------------------------------
(require 'init-eshell nil t)

;;---------------------------------------------------------
;; moz.el
;;---------------------------------------------------------
;; (require 'init-moz nil t)

;;---------------------------------------------------------
;; magit.el
;;---------------------------------------------------------
(require 'init-magit nil t)

;;---------------------------------------------------------
;; svn
;;---------------------------------------------------------
(require 'init-svn nil t)

;;---------------------------------------------------------
;; ddskk
;;---------------------------------------------------------
(require 'init-ddskk nil t)

;;---------------------------------------------------------
;; yasnippet
;;---------------------------------------------------------
(require 'init-yasnippet nil t)

;;---------------------------------------------------------
;; defun
;;---------------------------------------------------------
(require 'init-defun nil t)

;;---------------------------------------------------------
;; hatena-mode
;;---------------------------------------------------------
(require 'init-hatena nil t)

;;---------------------------------------------------------
;; slime
;;---------------------------------------------------------
(require 'init-slime nil t)

;;----------------------------------------------------------------------------
;; mode-line
;;----------------------------------------------------------------------------
(require 'init-modeline nil t)

;;----------------------------------------------------------------------------
;; revive.el
;; 前回emacsを終了したときの状態を復元してくれる (resume)を実行すれば復元してくれるが、
;; そのためには各モードの設定を読み込んでいる必要があるので、一番最後に書いてある。
;; http://d.hatena.ne.jp/gan2/20080203/1202032426
;; http://tech.kayac.com/archive/emacs.html
;;----------------------------------------------------------------------------
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(setq revive:configuration-file "~/.emacs.d/resource/.revive.el")
(define-key ctl-x-map "F" 'resume)                        ; C-x F で復元
(define-key ctl-x-map "K" 'wipe)                          ; C-x K で Kill
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に保存
(resume) ; 起動時に復元
