;; quickrun.el
;; https://github.com/syohex/emacs-quickrun
(when (require 'quickrun nil t)
  (global-set-key [(f5)] 'quickrun))

;; pomodoro.el
;; https://github.com/baudtack/pomodoro.el
(when (require 'pomodoro nil t)
  (pomodoro-add-to-mode-line)
  )

(provide 'init-util)
