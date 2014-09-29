;;;; view-mode
(require 'viewer)
(viewer-stay-in-setup)
;; 書き込み不能ファイルのバッファに対しては真赤
;; その他のview-modeバッファに対してはオレンジ
(setq viewer-modeline-color-unwritable "tomato"
      viewer-modeline-color-view "orange")
(viewer-change-modeline-color-setup)

(defun my/view-insert-after ()
  (interactive)
  (unless (eolp)
    (forward-char))
  (View-quit))

(defun my/view-insert-eol ()
  (interactive)
  (end-of-line)
  (View-quit))

(defun my/view-insert-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent)
  (View-quit))

(defun my/view-insert-prev-line ()
  (interactive)
  (beginning-of-line)
  (save-excursion
    (newline))
  (View-quit))

(global-set-key (kbd "C-c C-v") 'view-mode)
(define-key view-mode-map (kbd "h") 'backward-char)
(define-key view-mode-map (kbd "l") 'forward-char)
(define-key view-mode-map (kbd "j") 'next-line)
(define-key view-mode-map (kbd "k") 'previous-line)
(define-key view-mode-map (kbd "b") 'backward-word)
(define-key view-mode-map (kbd " ") 'scroll-up)
(define-key view-mode-map (kbd "w") 'forward-word)
(define-key view-mode-map (kbd "W") 'forward-symbol)
(define-key view-mode-map (kbd "e") 'backward-word)
(define-key view-mode-map (kbd "q") 'View-exit)
(define-key view-mode-map (kbd "i") 'View-exit-and-edit)
(define-key view-mode-map (kbd "f") 'ace-jump-mode)
(define-key view-mode-map (kbd "a") 'my/view-insert-after)
(define-key view-mode-map (kbd "A") 'my/view-insert-eol)
(define-key view-mode-map (kbd "o") 'my/view-insert-next-line)
(define-key view-mode-map (kbd "O") 'my/view-insert-prev-line)

;; bm.elの設定
(define-key view-mode-map (kbd "m") 'bm-toggle)
(define-key view-mode-map (kbd "[") 'bm-previous)
(define-key view-mode-map (kbd "]") 'bm-next)

(provide 'init-view)
