;;;; dired
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

;; s を何回か入力すると，拡張子やサイズによる並び換えもできる
(load "sorter")
;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)
;; ディレクトリ内のファイル名を編集できるようにする
(when(require 'wdired nil t)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
  )
;; C-sでファイル名のみ検索対象にする
(setq dired-isearch-filenames t)
;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
;; direx.el
;; http://cx4a.blogspot.com/2011/12/popwineldirexel.html
(when (require 'direx nil t)
  (require 'direx-project nil t)
  ;; http://shibayu36.hatenablog.com/category/emacs?page=1361962452
  ;; (defun direx:jump-to-project-directory ()
  (defun my-direx ()
    (interactive)
    (let ((result (ignore-errors
                    (direx-project:jump-to-project-root-other-window)
                    t)))
      (unless result
        (direx:jump-to-directory-other-window))))
  )

;; joseph-single-dired.el
;; diredのバッファが増えないようにする
;; https://github.com/jixiuf/joseph-single-dired
(when (require 'joseph-single-dired nil t)
  (eval-after-load 'dired '(require 'joseph-single-dired)))

;; dired-filetype-face.el
;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
(require 'dired-filetype-face nil t)

;; dired-k.el
(when (require 'dired-k nil t)
  (setq dired-k-style 'git)
  (define-key dired-mode-map (kbd "K") 'dired-k))

(provide 'init-dired)
