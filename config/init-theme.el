; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; color-theme
;;----------------------------------------------------------------------------
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (require 'color-theme-solarized nil t)
  (require 'color-theme-sanityinc-tomorrow nil t)
  (require 'color-theme-tangotango nil t)
  (require 'zenburn nil t)
  )

;;(require 'color-theme-railscasts)
;;(color-theme-railscasts)
;;(color-theme-subtle-blue)
;;(color-theme-Gnome2)

;; 取得元
;; https://github.com/sellout/emacs-color-theme-solarized
;; https://github.com/purcell/color-theme-sanityinc-tomorrow
;; https://github.com/olegshaldybin/color-theme-railscasts
;; https://github.com/juba/color-theme-tangotango
;; https://github.com/credmp/color-theme-zenburn

(provide 'init-theme)
