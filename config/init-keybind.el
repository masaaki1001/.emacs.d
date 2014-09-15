;;;; keybind
(global-set-key (kbd "M-h") 'backward-kill-word)

;; 改行時にインデント
(global-set-key (kbd "C-m") 'newline-and-indent)
;; 指定行へ移動
(global-set-key (kbd "M-g") 'goto-line)

;; 単語削除で切り取りではなく削除になるようにする
;; http://d.hatena.ne.jp/syohex/20110329/
(defun delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  (interactive "p")
  (delete-word (- arg)))
(global-set-key (kbd "M-d") 'delete-word)
(global-set-key [C-backspace] 'backward-delete-word)
(global-set-key (kbd "M-h") 'backward-delete-word)

;; C-hでbackspace
;; http://openlab.dino.co.jp/2007/09/25/23251372.html
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat)
  (terminal-init-bobcat))

;; emacsのc-u-c-uを8回繰り返しにする
;; http://d.akinori.org/2010/03/05/emacsのc-u-c-uを8回繰り返しにする/
(defadvice universal-argument-more
  (before stop-by-eight-before-sixteen (arg) activate)
  "Stop by eight before sixteen."
  (let ((num (car arg)))
    (if (> 16 num) (ad-set-arg 0 (list (/ num 2))))))

;; バックスラッシュ
(define-key global-map (kbd "M-|") "\\")

;; M-^で実現できる．
;; (global-set-key (kbd "M-j")
;;             (lambda ()
;;                   (interactive)
;;                   (join-line -1)))

;; http://d.hatena.ne.jp/kbkbkbkb1/20111205/1322988550
;; enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC ...
(setq set-mark-command-repeat-pop t)

;; sequential-command.el C-a C-e の挙動変更
;; http://emacs.g.hatena.ne.jp/k1LoW/20101211/1292046538
(require 'sequential-command)
(define-sequential-command seq-home
  back-to-indentation  beginning-of-line beginning-of-buffer seq-return)
(global-set-key (kbd "C-a") 'seq-home)
(define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)
(global-set-key (kbd "C-e") 'seq-end)

;; duplicate-thing.el
;; https://github.com/ongaeshi/duplicate-thing
(global-set-key (kbd "C-M-y") 'duplicate-thing)

;; Use C-x C-m to do M-x per Steve Yegge's advice
;; https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; 範囲指定していないとき、C-wで前の単語を削除
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (called-interactively-p 'interactive) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))

;; shift + 矢印キー でwindowを移動
(windmove-default-keybindings)

;; ctrl-q
(defvar ctrl-q-map (make-keymap))
(define-key global-map (kbd "C-q") ctrl-q-map)

(global-set-key (kbd "C-q i") 'indent-buffer)

(provide 'init-keybind)
