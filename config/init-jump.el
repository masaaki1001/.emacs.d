;; jaunte
;; http://kawaguchi.posterous.com/emacshit-a-hint
(require 'jaunte)
(setq jaunte-hint-unit 'word) ;default
(global-set-key (kbd "C-c C-j") 'jaunte)

;; ace-jump-mode
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "C-.") 'ace-jump-mode)

;; ace-jump-zap
(global-set-key (kbd "M-z") 'ace-jump-zap-to-char)

;; goto-chg
(define-key global-map (kbd "C-c /") 'goto-last-change)
(define-key global-map (kbd "C-c C-/") 'goto-last-change-reverse)

;; point-undo
(require 'point-undo)
(define-key global-map (kbd "C-x /") 'point-undo)
(define-key global-map (kbd "C-x C-/") 'point-redo)

(when is-mac
  (add-to-list 'dash-at-point-mode-alist '(web-mode . "html"))
  (add-to-list 'dash-at-point-mode-alist '(typescript-mode . "backbone,underscore,jquery,javascript"))
  (global-set-key (kbd "C-c C-d") 'dash-at-point))

(when is-linux
  (add-to-list 'zeal-at-point-mode-alist '(web-mode . "html"))
  (add-to-list 'dash-at-point-mode-alist '(typescript-mode . "backbone,underscore,jquery,javascript"))
  (global-set-key (kbd "C-c C-d") 'zeal-at-point))

(provide 'init-jump)
