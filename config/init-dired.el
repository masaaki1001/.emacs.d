;;;; dired
(with-eval-after-load "dired"
  (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
  (load-library "ls-lisp")
  (load-library "sorter")
  ;; ディレクトリを先に表示する
  (setq ls-lisp-dirs-first t)
  ;; ディレクトリ内のファイル名を編集できるようにする
  (require 'wdired)
  ;; joseph-single-dired
  ;; diredのバッファが増えないようにする
  ;; https://github.com/jixiuf/joseph-single-dired
  (require 'joseph-single-dired)

  ;; dired-k
  (setq dired-k-style 'git)
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
  (define-key dired-mode-map (kbd "K") 'dired-k)
  (define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)

  ;; direx
  ;; http://cx4a.blogspot.com/2011/12/popwineldirexel.html
  ;; http://shibayu36.hatenablog.com/category/emacs?page=1361962452
  (defun my/direx ()
    (interactive)
    (let ((result (ignore-errors
                    (direx-project:jump-to-project-root-other-window)
                    t)))
      (unless result
        (direx:jump-to-directory-other-window))))

  ;; dired-filetype-face
  ;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
  (require 'dired-filetype-face))

(provide 'init-dired)
