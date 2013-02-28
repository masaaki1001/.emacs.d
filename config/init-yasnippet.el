;; yasnippet
(when (require 'yasnippet nil t) ;; not yasnippet-bundle
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
          "~/.emacs.d/repositories/yasnippets-rails/rails-snippets"
          ))
  (yas-global-mode 1)
  (custom-set-variables '(yas-trigger-key "TAB"))

  ;; 既存スニペットを挿入する
  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  ;; 新規スニペットを作成するバッファを用意する
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  ;; 既存スニペットを閲覧・編集する
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
 )

;; yasnippetのインデント
;; http://d.hatena.ne.jp/rubikitch/20080420/1208697562
(defun yas/indent-snippet ()
  (indent-region yas/snippet-beg yas/snippet-end)
  (indent-according-to-mode))
(add-hook 'yas/after-exit-snippet-hook 'yas/indent-snippet)

(provide 'init-yasnippet)
