(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
  (setq ls-lisp-dirs-first t)
  (require 'wdired)
  (require 'joseph-single-dired)
  (require 'dired-filetype-face)

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
  (define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode))

(provide 'init-dired)
