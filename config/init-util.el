;;;; util
;; quickrun.el
;; https://github.com/syohex/emacs-quickrun
(when (require 'quickrun nil t)
  (global-set-key [(f5)] 'quickrun))

;; pomodoro.el
;; https://github.com/baudtack/pomodoro.el
(when (require 'pomodoro nil t)
  (pomodoro-add-to-mode-line))

;; open-junk-file.el
(when (require 'open-junk-file nil t)
  (global-set-key (kbd "C-x M-j") 'open-junk-file)
  (setq open-junk-file-find-file-function 'find-file)
  (setq open-junk-file-format
        (expand-file-name "%Y-%m-%d-%H%M%S."
                          (concat user-emacs-directory "junk"))))

(provide 'init-util)
