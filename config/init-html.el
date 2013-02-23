;; css-mode
(autoload 'css-mode "css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)

;; scss-mode
(autoload 'scss-mode "scss-mode")
(setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-hook 'scss-mode-hook 'ac-css-mode-setup)

;; less-css-mode
(when (require 'less-css-mode nil t)
  (add-to-list 'ac-modes 'less-css-mode)
  (add-hook 'less-css-mode-hook 'ac-css-mode-setup))

(when (require 'web-mode nil t)
  (setq web-mode-markup-indent-offset 4)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (define-key web-mode-map (kbd "C-;") nil)
  )

;; zencoding-mode
(when (require 'zencoding-mode nil t)
  (add-hook 'html-mode-hook 'zencoding-mode)
  (add-hook 'web-mode-hook 'zencoding-mode))

(provide 'init-html)
