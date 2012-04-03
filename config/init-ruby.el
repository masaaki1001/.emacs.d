; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; ruby
;;----------------------------------------------------------------------------
;; ruby-mode.el
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)))

;; http://d.hatena.ne.jp/odz/20071222/1198288746
;; 最終行に空白行を挿入しないようにする
;;(add-hook 'ruby-mode-hook '(lambda () (setq require-final-newline nil)))

;; ruby-electric.el
(when (require 'ruby-electric nil t)
  (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
  )

;; ruby-block.el
(when (require 'ruby-block nil t)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)
  )

;; ruby-indent
(setq ruby-indent-level 2)
(setq ruby-indent-tabs-mode nil)

;; Interactively Do Things (highly recommended, but not strictly required)
;;(require 'ido)
;;(ido-mode t)
;; Rinari
;; https://github.com/eschulte/rinari
(require 'rinari nil t)
;; yasnippet
(when (require 'yasnippet nil t) ;; not yasnippet-bundle
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/snippets")
  ;; rails-snippets
  (yas/load-directory "~/.emacs.d/yasnippets-rails/rails-snippets")
  )
;; anything-c-yasnjppet.el
;; http://d.hatena.ne.jp/shiba_yu36/20100615/1276612642
;; http://d.hatena.ne.jp/sugyan/20120111/1326288445
(when (require 'anything-c-yasnippet nil t)
  (setq anything-c-yas-space-match-any-greedy t) ;スペース区切りで絞り込めるようにする デフォルトは nil
  (global-set-key (kbd "C-c y") 'anything-c-yas-complete) ;C-c yで起動
  )



;; yasnippetのインデント
;; http://d.hatena.ne.jp/rubikitch/20080420/1208697562
(defun yas/indent-snippet ()
  (indent-region yas/snippet-beg yas/snippet-end)
  (indent-according-to-mode))
(add-hook 'yas/after-exit-snippet-hook 'yas/indent-snippet)

;; rvm.el
(when (require 'rvm nil t)
  (rvm-use-default) ;; use rvm's default ruby for the current Emacs session
  (defcustom rspec-use-rvm nil
    "t when RVM in is in use. (Requires rvm.el)"
    :type 'boolean
    :group 'rspec-mode)
  (defun rspec-compile ()
    ;; some code.....
    (if rspec-use-rvm
        (rvm-activate-corresponding-ruby))
    ;; more code ..
    )
  )

;; rspec-mode
(when (require 'rspec-mode nil t)
  (custom-set-variables '(rspec-use-rake-flag nil))
  )

;; rhtml-mode.el
;; http://d.hatena.ne.jp/willnet/20090110/1231595231
(when (require 'rhtml-mode nil t)
  (add-hook 'rhtml-mode-hook
            (lambda () (rinari-launch)))
  )

;; anything-rdefs.el
;; http://openlab.dino.co.jp/2011/05/23/184501727.html
(when (require 'anything-rdefs nil t)
  (setq ar:command "~/.emacs.d/script/rdefs.rb")
  (add-hook 'ruby-mode-hook
            (lambda ()
              (define-key ruby-mode-map (kbd "C-@") 'anything-rdefs)))
  )

;; yarm.el (Yet Another Ruby on Rails Minor Mode)
;; https://github.com/k1LoW/emacs-yarm
;; 依存パッケージ historyf.el
;; https://github.com/k1LoW/emacs-historyf
;; https://raw.github.com/k1LoW/emacs-historyf/master/historyf.el
(when (require 'yarm nil t)
;;(global-yarm t)
  )


;; http://d.hatena.ne.jp/kitokitoki/20120310/p1
(defun ffap-ruby-mode (name)
  (shell-command-to-string
   (format "ruby -e 'require %%[rubygems];require %%[devel/which];require %%[%s];
print (which_library (%%[%%s]))'" name name)))

(defun find-ruby-lib (name)
  (interactive "sRuby library name: ")
  (find-file (ffap-ruby-mode name)))

;ffap
(when (require 'ffap nil t)
  (add-to-list 'ffap-alist '(ruby-mode . ffap-ruby-mode))
  )

(provide 'init-ruby)