;;----------------------------------------------------------------------------
;; dired
;;----------------------------------------------------------------------------
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

;; s を何回か入力すると，拡張子やサイズによる並び換えもできる
(load "sorter")
;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)
;; ディレクトリ内のファイル名を編集できるようにする
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;; 削除したらごみ箱行き
(setq delete-by-moving-to-trash t)

;; direx.el
;; http://cx4a.blogspot.com/2011/12/popwineldirexel.html
(require 'direx nil t)

;; joseph-single-dired.el
;; diredのバッファが増えないようにする
;; https://github.com/jixiuf/joseph-single-dired
(when (require 'joseph-single-dired nil t)
  (eval-after-load 'dired '(require 'joseph-single-dired)))

;; dired-filetype-face.el
;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
(require 'dired-filetype-face nil t)

;; ファイル作成
(defun dired-create-file (file-name)
  (interactive "F Create file: ")
  (write-region "" nil file-name nil nil nil))
(define-key dired-mode-map "i" 'dired-create-file)

(provide 'init-dired)
