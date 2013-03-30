;; jaunte.el
;; http://kawaguchi.posterous.com/emacshit-a-hint
;; https://github.com/kawaguchi/jaunte.el
(when (require 'jaunte nil t)
  (global-set-key (kbd "C-c C-j") 'jaunte)
  (setq jaunte-hint-unit 'word) ;default
  ;;(setq jaunte-global-hint-unit 'symbol)
  )

;; ace-jump-mode.el
;; http://d.hatena.ne.jp/syohex/20120304/1330822993
;; https://github.com/winterTTr/ace-jump-mode
(when (require 'ace-jump-mode nil t)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  (global-set-key (kbd "C-.") 'ace-jump-mode)
  )

;; jump-char.el
;; https://github.com/lewang/jump-char
(when (require 'jump-char nil t)
  (global-set-key (kbd "C-c f") 'jump-char-forward)
  (global-set-key (kbd "C-c F") 'jump-char-backward)
  )

;; iy-go-to-char.el
(when (require 'iy-go-to-char nil t)
  (global-set-key (kbd "C-c C-f") 'iy-go-to-char)
  (global-set-key (kbd "C-c C-F") 'iy-go-to-char-backward)
  (global-set-key (kbd "C-c ;") 'iy-go-to-char-continue)
  (global-set-key (kbd "C-c ,") 'iy-go-to-char-continue-backward)
  )

;; goto-chg.el
;; Emacs tech book p117
(when (require 'goto-chg nil t)
  (define-key global-map (kbd "<f8>") 'goto-last-change)
  (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse))

;; point-undo.el
;; こんな対応が必要らしい http://randd.kwappa.net/2011/03/10/258
(when (require 'point-undo nil t)
  (define-key global-map (kbd "<f7>") 'point-undo)
  (define-key global-map (kbd "S-<f7>") 'point-redo))

(when (require 'dash-at-point nil t)
  (global-set-key (kbd "C-c C-d") 'dash-at-point)
  )

(provide 'init-jump)
