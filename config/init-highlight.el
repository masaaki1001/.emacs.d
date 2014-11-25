;; volatile-highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)

(dolist (hook '(prog-mode-hook html-mode-hook typescript-mode-hook))
  (add-hook hook 'highlight-symbol-mode)
  (add-hook hook 'highlight-symbol-nav-mode))

(provide 'init-highlight)
