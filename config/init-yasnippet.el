;;;; yasnippet
(when (require 'yasnippet nil t)
  ;; (setq yas-snippet-dirs
  ;;       '("~/.emacs.d/snippets"
  ;;         "~/.emacs.d/repositories/yasnippets-rails/rails-snippets"
  ;;         ))
  (add-to-list 'yas-snippet-dirs (expand-file-name "yasnippets-rails"  repositories-dir))
  (yas-global-mode 1)
  ;; (custom-set-variables '(yas-trigger-key "TAB"))

  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

  (when (require 'dropdown-list nil t)
    (setq yas/prompt-functions '(yas/dropdown-prompt
                                   yas/ido-prompt
                                   yas/completing-prompt)))
  )

(provide 'init-yasnippet)
