; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; package.el(marmalade) Emacs24からは標準搭載
;; http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el
;;----------------------------------------------------------------------------
(when (require 'package nil t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize)

  ;; marmalade.el
  ;; http://sheephead.homelinux.org/2011/06/17/6724/
  (load "~/.emacs.d/elpa/marmalade-0.0.4/marmalade.el")
  )


;; https://github.com/purcell/emacs.d/blob/master/init-elpa.el
(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

;; package-spec
(require 'package-spec)

(provide 'init-elpa)
