;;;; view-mode
(when (require 'viewer nil t)
  (viewer-stay-in-setup)
  ;; 書き込み不能ファイルのバッファに対しては真赤
  ;; その他のview-modeバッファに対してはオレンジ
  (setq viewer-modeline-color-unwritable "tomato"
        viewer-modeline-color-view "orange")
  (viewer-change-modeline-color-setup)

  (setq pager-keybind
        `( ;; vi-like
          ("h" . backward-char)
          ("l" . forward-char)
          ("j" . next-line)
          ("k" . previous-line)
          ("b" . scroll-down)
          (" " . scroll-up)
          ("w" . forward-word)
          ("e" . backward-word)
          ("J" . ,(lambda () (interactive) (scroll-up 1)))
          ("K" . ,(lambda () (interactive) (scroll-down 1)))
          ))

  (defun define-many-keys (keymap key-table &optional includes)
    (let (key cmd)
      (dolist (key-cmd key-table)
        (setq key (car key-cmd)
              cmd (cdr key-cmd))
        (if (or (not includes) (member key includes))
            (define-key keymap key cmd))))
    keymap)
  (defun view-mode-hook--pager ()
    (define-many-keys view-mode-map pager-keybind))
  (add-hook 'view-mode-hook 'view-mode-hook--pager)
  (global-set-key (kbd "C-c C-v") 'view-mode)

  (defun my/view-insert ()
    (interactive)
    (toggle-read-only))
  (define-key view-mode-map (kbd "i") 'my/view-insert)

  (defun my/view-insert-bol ()
    (interactive)
    (back-to-indentation)
    (toggle-read-only))
  (define-key view-mode-map (kbd "I") 'my/view-insert-bol)

  (defun my/view-insert-after ()
    (interactive)
    (unless (eolp)
      (forward-char))
    (toggle-read-only))
  (define-key view-mode-map (kbd "a") 'my/view-insert-after)

  (defun my/view-insert-eol ()
    (interactive)
    (end-of-line)
    (toggle-read-only))
  (define-key view-mode-map (kbd "A") 'my/view-insert-eol)

  (defun my/view-insert-next-line ()
    (interactive)
    (toggle-read-only)
    (end-of-line)
    (newline-and-indent))
  (define-key view-mode-map (kbd "o") 'my/view-insert-next-line)

  (defun my/view-insert-prev-line ()
    (interactive)
    (beginning-of-line)
    (toggle-read-only)
    (save-excursion
      (newline)))
  (define-key view-mode-map (kbd "O") 'my/view-insert-prev-line)

  (define-key view-mode-map (kbd "f") 'ace-jump-mode)

  ;; bm.elの設定
  (define-key view-mode-map (kbd "m") 'bm-toggle)
  (define-key view-mode-map (kbd "[") 'bm-previous)
  (define-key view-mode-map (kbd "]") 'bm-next)
  )

(provide 'init-view)
