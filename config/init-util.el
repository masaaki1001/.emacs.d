;; pomodoro
(require 'pomodoro)
(setq pomodoro-play-sounds nil)
(pomodoro-add-to-mode-line)

;; open-junk-file
(require 'open-junk-file)
(global-set-key (kbd "C-x M-j") 'open-junk-file)
(setq open-junk-file-find-file-function 'find-file)
(setq open-junk-file-format
      (expand-file-name "%Y-%m-%d-%H%M%S."
                        (concat user-emacs-directory "junk")))

(provide 'init-util)
