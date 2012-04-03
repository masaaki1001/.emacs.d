; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; keybind
;;----------------------------------------------------------------------------
(global-set-key "\C-h" 'delete-backward-char) ; 削除
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\C-z" 'undo) ;; undo
(pc-selection-mode) ;; Shift + 矢印キーで範囲選択
(setq kill-whole-line t) ;; C-k で改行を含め切り取り
;; 改行時にインデント
(global-set-key "\C-m" 'newline-and-indent)
;; 指定行へ移動
(global-set-key "\M-g" 'goto-line)

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

;; http://openlab.dino.co.jp/2007/09/25/23251372.html
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat)
  (terminal-init-bobcat))

;; 対応する括弧に移動(C-M-f/p相当)
;; http://www23.atwiki.jp/selflearn/pages/41.html
(global-set-key [?\C-{] 'backward-list)
(global-set-key [?\C-}] 'forward-list)

;; enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC ...
;; http://d.hatena.ne.jp/kbkbkbkb1/20111205/1322988550
(setq set-mark-command-repeat-pop t)

;; 一行複製
;; https://gist.github.com/1708398
;; https://gist.github.com/897494
;; (defun duplicate-line()
;;   (interactive)
;;   (save-excursion
;;     (move-beginning-of-line 1)
;;     (kill-line)
;;     (yank)
;;     (yank)))
;; (global-set-key (kbd "C-M-y") 'duplicate-line)

;; duplicate-thing.el
;; https://github.com/ongaeshi/duplicate-thing
;; https://raw.github.com/ongaeshi/duplicate-thing/master/duplicate-thing.el
;; http://d.hatena.ne.jp/syohex/20120325/1332641491
(require 'duplicate-thing)
(global-set-key (kbd "C-M-y") 'duplicate-thing)

;; emacsのc-u-c-uを8回繰り返しにする
;; http://d.akinori.org/2010/03/05/emacsのc-u-c-uを8回繰り返しにする/
(defadvice universal-argument-more
  (before stop-by-eight-before-sixteen (arg) activate)
  "Stop by eight before sixteen."
  (let ((num (car arg)))
    (if (> 16 num) (ad-set-arg 0 (list (/ num 2))))))

;; バックスラッシュ
(define-key global-map (kbd "M-|") "\\")

;; http://d.hatena.ne.jp/kbkbkbkb1/20111205/1322988550
;; enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC ...
(setq set-mark-command-repeat-pop t)

(provide 'init-keybind)