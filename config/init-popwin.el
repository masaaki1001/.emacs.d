;;;; popwin.el
;; http://d.hatena.ne.jp/m2ym/20110120
(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("^\*helm.*\*$" :height 0.5 :regexp t :position bottom) popwin:special-display-config)
  (push '("^\*Helm.*\*$" :height 0.5 :regexp t :position bottom) popwin:special-display-config)
  (push '("*Warnings*" :height 20) popwin:special-display-config)
  (push '("*Procces List*" :height 20) popwin:special-display-config)
  (push '("*Messages*" :height 20) popwin:special-display-config)
  (push '("*Backtrace*" :height 20) popwin:special-display-config)
  (push '("*Compile-Log*" :height 20 :noselect t) popwin:special-display-config)
  (push '("*Remember*" :height 20) popwin:special-display-config)
  (push '("*All*" :height 20) popwin:special-display-config)
  ;; direx
  (push '(direx:direx-mode :position left :width 40 :dedicated t)
        popwin:special-display-config)
  )

(provide 'init-popwin)
