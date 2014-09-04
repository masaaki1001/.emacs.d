;;;; jump
;; jaunte.el
;; http://kawaguchi.posterous.com/emacshit-a-hint
(require 'jaunte)
(setq jaunte-hint-unit 'word) ;default
(global-set-key (kbd "C-c C-j") 'jaunte)

;; ace-jump-mode.el
;; http://d.hatena.ne.jp/syohex/20120304/1330822993
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "C-.") 'ace-jump-mode)

;; goto-chg.el
(require 'goto-chg)
(define-key global-map (kbd "C-c /") 'goto-last-change)
(define-key global-map (kbd "C-c C-/") 'goto-last-change-reverse)

;; point-undo.el
(require 'point-undo)
(define-key global-map (kbd "C-x /") 'point-undo)
(define-key global-map (kbd "C-x C-/") 'point-redo)

(when is-mac
  (require 'dash-at-point)
  (add-to-list 'dash-at-point-mode-alist '(web-mode . "html"))
  (add-to-list 'dash-at-point-mode-alist '(typescript-mode . "backbone,underscore,jquery,javascript"))
  (global-set-key (kbd "C-c C-d") 'dash-at-point))

(when is-linux
  (require 'zeal-at-point)
  (add-to-list 'zeal-at-point-mode-alist '(web-mode . "html"))
  (add-to-list 'dash-at-point-mode-alist '(typescript-mode . "backbone,underscore,jquery,javascript"))
  (global-set-key (kbd "C-c C-d") 'zeal-at-point))

(provide 'init-jump)
