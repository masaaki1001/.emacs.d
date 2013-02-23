;;----------------------------------------------------------------------------
;; auto-complete
;; http://cx4a.org/software/auto-complete/manual.ja.html
;;----------------------------------------------------------------------------
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/repositories/auto-complete/dict")
  (ac-config-default)
  (setq ac-delay 0.5)
  ;; (setq ac-auto-show-menu 0.8)
  (setq ac-use-menu-map t)
  (add-hook 'auto-complete-mode-hook
            (lambda ()
              (define-key ac-completing-map (kbd "C-n") 'ac-next)
              (define-key ac-completing-map (kbd "C-p") 'ac-previous)
              (define-key ac-completing-map (kbd "C-s") 'ac-isearch)
              ))

  ;; auto-complete-ruby.el
  ;; http://d.hatena.ne.jp/tkng/20090207/1234020003
  (add-to-list 'load-path (expand-file-name "~/.rvm/gems/jruby-1.6.5/gems/rcodetools-0.8.5.0"))
  (when (require 'auto-complete-ruby nil t)
    (setq ac-comphist-file "~/.emacs.d/resource/auto-complete/ac-comphist.dat")
    (global-auto-complete-mode t)
    (setq ac-dwim nil)
    (set-face-background 'ac-selection-face "steelblue")
    (setq ac-auto-start t)
    (global-set-key "\M-q" 'ac-start)
    (setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
    (add-hook 'ruby-mode-hook
              (lambda ()
                (when (require 'rcodetools nil t))
                (when (require 'auto-complete-ruby nil t))
                (make-local-variable 'ac-omni-completion-sources)
                (setq ac-omni-completion-sources '(("\\.\\=" . (ac-source-rcodetools))))))
    )
  )

(provide 'init-auto-complete)
