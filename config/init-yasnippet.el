;;;; yasnippet
(when (require 'yasnippet nil t)
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"
          "~/.emacs.d/repositories/yasnippets-rails/rails-snippets"
          ))
  (yas-global-mode 1)
  ;; (custom-set-variables '(yas-trigger-key "TAB"))

  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

  ;; yasnippetのインデント
  ;; http://d.hatena.ne.jp/rubikitch/20080420/1208697562
  (defun yas/indent-snippet ()
    (indent-region yas/snippet-beg yas/snippet-end)
    (indent-according-to-mode))
  (add-hook 'yas/after-exit-snippet-hook 'yas/indent-snippet)

  (when (require 'dropdown-list nil t)
    (setq yas/prompt-functions '(yas/dropdown-prompt
                                   yas/ido-prompt
                                   yas/completing-prompt)))
  )

(provide 'init-yasnippet)
