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

;; http://willnet.in/13
;; (setq ruby-deep-indent-paren-style nil)
;; (defadvice ruby-indent-line (after unindent-closing-paren activate)
;;   (let ((column (current-column))
;;         indent offset)
;;     (save-excursion
;;       (back-to-indentation)
;;       (let ((state (syntax-ppss)))
;;         (setq offset (- column (current-column)))
;;         (when (and (eq (char-after) ?\))
;;                    (not (zerop (car state))))
;;           (goto-char (cadr state))
;;           (setq indent (current-indentation)))))
;;     (when indent
;;       (indent-line-to indent)
;;       (when (> offset 0) (forward-char offset)))))

;; ruby-electric.el
(when (require 'ruby-electric nil t)
  (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
  ;; ruby-electric.el --- electric editing commands for ruby files
  ;; http://d.hatena.ne.jp/authorNari/20081203/1228285596
  (setq ruby-electric-expand-delimiters-list nil)
  )

;; ruby-block.el
(when (require 'ruby-block nil t)
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)
  )

;; ruby-indent
(setq ruby-indent-level 2)
(setq ruby-indent-tabs-mode nil)

;; Rinari
;; https://github.com/eschulte/rinari
(when (require 'rinari nil t)
  (setq rinari-rgrep-file-endings "*.rb *.erb *.yml *.js"))
;; yasnippet
(when (require 'yasnippet nil t) ;; not yasnippet-bundle
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/snippets")
  ;; rails-snippets
  (yas/load-directory "~/.emacs.d/repositories/yasnippets-rails/rails-snippets")
  )

;; anything-c-yasnippet.el
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
;; https://github.com/senny/rvm.el
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
;; https://github.com/eschulte/rhtml
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

;; http://d.hatena.ne.jp/kitokitoki/20120310/p1
(defun ffap-ruby-mode (name)
  (shell-command-to-string
   (format "ruby -e 'require %%[rubygems];require %%[devel/which];require %%[%s];
print (which_library (%%[%%s]))'" name name)))

(defun find-ruby-lib (name)
  (interactive "sRuby library name: ")
  (find-file (ffap-ruby-mode name)))

;; ffap
;; (when (require 'ffap nil t)
;;   (add-to-list 'ffap-alist '(ruby-mode . ffap-ruby-mode))
;;   )

;; ruby-interpolation.el
;; https://github.com/leoc/ruby-interpolation.el
(require 'ruby-interpolation nil t)

;; https://github.com/tobiassvn/bundler.el
(require 'bundler nil t)

(provide 'init-ruby)
