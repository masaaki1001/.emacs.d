;;;; window
(require 'spaces)

(require 'elscreen)
(defadvice elscreen-jump (around elscreen-last-command-char-event activate)
  (let ((last-command-char last-command-event))
    ad-do-it))

(require 'zoom-window)
;; M-x elscreen-start 実行時に一度だけ実行させる．
(defun my/elscreen-update-hook ()
  (setq zoom-window-use-elscreen t)
  (zoom-window-setup)
  (remove-hook 'elscreen-screen-update-hook 'my/elscreen-update-hook)
  (message "zoom-window-setup...done"))

(add-hook 'elscreen-screen-update-hook 'my/elscreen-update-hook)

(global-set-key (kbd "C-x C-z") 'zoom-window-zoom)

(provide 'init-window)
