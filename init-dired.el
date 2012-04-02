; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; dired
;;----------------------------------------------------------------------------
;; emacs wiki
;; http://xahlee.org/emacs/emacs_diredplus_mode.html
;;(require 'dired+)
;; diredで今日変更したファイル色付け
;; http://masutaka.net/chalow/2011-12-17-1.html
(defface dired-todays-face '((t (:foreground "forest green"))) nil)
(defvar dired-todays-face 'dired-todays-face)

(defconst month-name-alist
  '(("1"  . "Jan") ("2"  . "Feb") ("3"  . "Mar") ("4"  . "Apr")
    ("5"  . "May") ("6"  . "Jun") ("7"  . "Jul") ("8"  . "Aug")
    ("9"  . "Sep") ("10" . "Oct") ("11" . "Nov") ("12" . "Dec")))

(defun dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   (let ((month-name
	  (cdr (assoc (format-time-string "%b") month-name-alist))))
     (if month-name
	 (format
	  (format-time-string
	   "\\(%Y-%m-%d\\|%b %e\\|%%s %e\\) [0-9]....") month-name)
       (format-time-string
	"\\(%Y-%m-%d\\|%b %e\\) [0-9]....")))
   arg t))

(eval-after-load "dired"
  '(font-lock-add-keywords
    'dired-mode
    (list '(dired-today-search . dired-todays-face))))

;; s を何回か入力すると，拡張子やサイズによる並び換えもできる
(load "sorter")
;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)
;; ディレクトリ内のファイル名を編集できるようにする
;; Emacs tech book p102
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;; 削除したらごみ箱行き
(setq delete-by-moving-to-trash t)

;; direx.el
;; http://cx4a.blogspot.com/2011/12/popwineldirexel.html
;; https://github.com/m2ym/direx-el/
;; https://raw.github.com/m2ym/direx-el/master/direx.el
(require 'direx nil t)
;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
;;(push '(direx:direx-mode :position left :width 25 :dedicated t)
;;      popwin:special-display-config)
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
;;(setq direx:leaf-icon "  "
;;      direx:open-icon "▾ "
;;      direx:closed-icon "▸ ")

;; joseph-single-dired.el
;; diredのバッファが増えないようにする
;; Emacs mail magazine
;; https://github.com/jixiuf/joseph-single-dired
;; https://raw.github.com/jixiuf/joseph-single-dired/master/joseph-single-dired.el
(when (require 'joseph-single-dired nil t)
  (eval-after-load 'dired '(require 'joseph-single-dired)))

;; dired-filetype-face.el
;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
;; Emacs mail magazine
(require 'dired-filetype-face nil t)

;; diredでマークをつけたファイルを開く
;; http://d.hatena.ne.jp/oh_cannot_angel/20101216/1292506110
;; (eval-after-load "dired"
;;   '(progn
;;      (define-key dired-mode-map (kbd "F") 'my-dired-find-marked-files)
;;      (defun my-dired-find-marked-files (&optional arg)
;;        "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
;;        (interactive "P")
;;        (let* ((fn-list (dired-get-marked-files nil arg)))
;;          (mapc 'find-file fn-list)))))

;; diredでマークをつけたファイルをviewモードで開く
;; http://d.hatena.ne.jp/oh_cannot_angel/20101216/1292506110
;; (eval-after-load "dired"
;;   '(progn
;;      (define-key dired-mode-map (kbd "V") 'my-dired-view-marked-files)
;;      (defun my-dired-view-marked-files (&optional arg)
;;        "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
;;        (interactive "P")
;;        (let* ((fn-list (dired-get-marked-files nil arg)))
;;          (mapc 'view-file fn-list)))))

(provide 'init-dired)