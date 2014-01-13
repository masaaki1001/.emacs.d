;;;; window
(require 'spaces nil t)

(defadvice elscreen-jump (around elscreen-last-command-char-event activate)
  (let ((last-command-char last-command-event))
    ad-do-it))

(provide 'init-window)
