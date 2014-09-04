;;;; dired
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

;; s を何回か入力すると，拡張子やサイズによる並び換えもできる
(load "sorter")
;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)
;; ディレクトリ内のファイル名を編集できるようにする
(require 'wdired)
(define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)
;; C-sでファイル名のみ検索対象にする
(setq dired-isearch-filenames t)
;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
;; ディレクトリを再帰的に削除する
(setq dired-recursive-deletes 'always)
;; dired-modeでもC-tで直前のバッファに移動できるようにする
(define-key dired-mode-map (kbd "C-t") 'switch-to-last-buffer-or-other-window)
(define-key dired-mode-map (kbd "k") 'dired-do-delete)

;; direx.el
;; http://cx4a.blogspot.com/2011/12/popwineldirexel.html
(require 'direx)
(require 'direx-project)
;; http://shibayu36.hatenablog.com/category/emacs?page=1361962452
(defun my/direx ()
  (interactive)
  (let ((result (ignore-errors
                  (direx-project:jump-to-project-root-other-window)
                  t)))
    (unless result
      (direx:jump-to-directory-other-window))))

;; joseph-single-dired.el
;; diredのバッファが増えないようにする
;; https://github.com/jixiuf/joseph-single-dired
(eval-after-load 'dired '(require 'joseph-single-dired))

;; dired-filetype-face.el
;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
(require 'dired-filetype-face)

;; dired-k.el
(require 'dired-k)
(setq dired-k-style 'git)
(define-key dired-mode-map (kbd "K") 'dired-k)

(provide 'init-dired)
