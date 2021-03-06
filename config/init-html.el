;; css-mode
(autoload 'css-mode "css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)

;; scss-mode
(with-eval-after-load 'scss-mode
  (setq scss-compile-at-save nil))

;; css-eldoc
(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'turn-on-css-eldoc)

;; web-mode
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(defun my/web-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (define-key web-mode-map (kbd "C-;") nil)
  ;; web-modeでのjshint実行キーバインドを変更
  (define-key web-mode-map (kbd "C-c C-j") nil)
  (define-key web-mode-map (kbd "C-c C-o") nil)
  (define-key web-mode-map (kbd "C-c h") 'web-mode-jshint))
(add-hook 'web-mode-hook 'my/web-mode-hook)

;; rainbow-mode
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)

;; emmet-mode
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; css-mode
(defun my/css-mode-hook ()
  (setq css-indent-offset 2))
(add-hook 'css-mode-hook 'my/css-mode-hook)

(provide 'init-html)
