;;;; window
(require 'spaces nil t)


(when (require 'elscreen nil t)
  (defadvice elscreen-jump (around elscreen-last-command-char-event activate)
    (let ((last-command-char last-command-event))
      ad-do-it))
  )

(when (require 'zoom-window nil t)
  (zoom-window-setup)
  (global-set-key (kbd "C-x C-z") 'zoom-window-zoom)
  )

(provide 'init-window)
