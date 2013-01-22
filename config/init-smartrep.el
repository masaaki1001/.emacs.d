; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; Smartrep.el
;; http://sheephead.homelinux.org/2011/12/19/6930/
;; https://github.com/myuhe/smartrep.el
;; https://raw.github.com/tkf/smartrep.el/master/smartrep.el
;;----------------------------------------------------------------------------
(when (require 'smartrep nil t)
  (setq orig-binding (key-binding "\C-l")) ; default key bind backup
  (progn
    (global-set-key "\C-l" nil)
    (smartrep-define-key
        global-map "C-l"
      '(("SPC" . 'scroll-up)
        ("b" . 'scroll-down)
        ("l" . 'forward-char)
        ("h" . 'backward-char)
        ("j" . 'next-line)
        ("k" . 'previous-line)
        ("i" . 'keyboard-quit)))
    )
  (global-set-key "\C-l\C-l" 'recenter-top-bottom)
  ;;(global-set-key "\C-l" orig-binding) ; default key bind revert


  ;; multiple-cursors
  (progn
    (smartrep-define-key
        global-map "C-l"
      '(("n" . 'mc/mark-next-like-this)
        ("p" . 'mc/mark-previous-like-this))))

  ;; org-mode
  (eval-after-load "org"
    '(progn
       (smartrep-define-key
           org-mode-map "C-c"
         ;; '(("C-n" . 'outline-next-visible-heading)
         ;;   ("C-p" . 'outline-previous-visible-heading)))))
         '(("n" . 'outline-next-visible-heading)
           ("p" . 'outline-previous-visible-heading)))))
  )

(provide 'init-smartrep)
