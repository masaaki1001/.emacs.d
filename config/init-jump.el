;;;; jump
;; jaunte.el
;; http://kawaguchi.posterous.com/emacshit-a-hint
(when (require 'jaunte nil t)
  (global-set-key (kbd "C-c C-j") 'jaunte)
  (setq jaunte-hint-unit 'word) ;default
  )

;; ace-jump-mode.el
;; http://d.hatena.ne.jp/syohex/20120304/1330822993
(when (require 'ace-jump-mode nil t)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  (global-set-key (kbd "C-.") 'ace-jump-mode)
  )

;; goto-chg.el
(when (require 'goto-chg nil t)
  (define-key global-map (kbd "<f8>") 'goto-last-change)
  (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse))

;; point-undo.el
(when (require 'point-undo nil t)
  (define-key global-map (kbd "<f7>") 'point-undo)
  (define-key global-map (kbd "S-<f7>") 'point-redo))

(when is-mac
  (when (require 'dash-at-point nil t)
    (add-to-list 'dash-at-point-mode-alist '(web-mode . "html"))
    (add-to-list 'dash-at-point-mode-alist '(less-css-mode . "less"))
    (global-set-key (kbd "C-c C-d") 'dash-at-point)
    )
  )

(when is-linux
  (when (require 'zeal-at-point nil t)
    (global-set-key (kbd "C-c C-d") 'zeal-at-point)
    )
  )

(provide 'init-jump)
