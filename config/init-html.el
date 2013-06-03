;; css-mode
(autoload 'css-mode "css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)

;; scss-mode
(when (require 'scss-mode nil t)
  (setq scss-compile-at-save nil) ;; 自動コンパイルをオフにする
  (add-hook 'scss-mode-hook 'ac-css-mode-setup)
  (add-to-list 'ac-modes 'scss-mode))

;; less-css-mode
(when (require 'less-css-mode nil t)
  (add-to-list 'ac-modes 'less-css-mode)
  (add-hook 'less-css-mode-hook 'ac-css-mode-setup))

(when (require 'web-mode nil t)
  (setq web-mode-markup-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (define-key web-mode-map (kbd "C-;") nil)
  )

;; rainbow-mode
(when (require 'rainbow-mode nil t)
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'scss-mode-hook 'rainbow-mode)
  )

;; zencoding-mode
(when (require 'zencoding-mode nil t)
  (add-hook 'html-mode-hook 'zencoding-mode)
  (add-hook 'web-mode-hook 'zencoding-mode))

(defun brace-ret-brace ()
  (interactive)
  (insert "{") (newline-and-indent)
  (newline-and-indent)
  (insert "}") (indent-for-tab-command)
  (newline-and-indent) (newline-and-indent)
  (previous-line) (previous-line) (previous-line)
  (indent-for-tab-command)
  )

(add-hook 'css-mode-hook
              (lambda ()
                (setq css-indent-offset 2)
                (define-key css-mode-map "M-{" 'brace-ret-brace)
                ))

(eval-after-load 'auto-complete
  '(progn
     (dolist (hook '(css-mode-hook sass-mode-hook scss-mode-hook))
       (add-hook hook 'ac-css-mode-setup))))

(provide 'init-html)
