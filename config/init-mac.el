; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; Mac用設定
;;----------------------------------------------------------------------------
(require 'ucs-normalize) ;; Mac用

(defun mac-os-p ()
  (member window-system '(mac ns)))
(defun linuxp ()
  (eq window-system 'x))

(when (mac-os-p)
;; Command-Key and Option-Key
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil))

;; 辞書アプリと連携する
;; http://d.hatena.ne.jp/pyopyopyo/20120414/p1?utm_source=twitterfeed&utm_medium=twitter
(defun dictionary ()
  "dictionary.app"
  (interactive)
  (let ((editable (not buffer-read-only))
        (pt (save-excursion (mouse-set-point last-nonmenu-event)))
        beg end)

    (if (and mark-active
             (<= (region-beginning) pt) (<= pt (region-end)) )
        (setq beg (region-beginning)
              end (region-end))
      (save-excursion
        (goto-char pt)
        (setq end (progn (forward-word) (point)))
        (setq beg (progn (backward-word) (point)))
        ))

    (start-process "dictionary.app" "*dictionary-region*"
                   "open"
                   (concat "dict:///"
                           (url-hexify-string (buffer-substring-no-properties begin end))))))
(define-key global-map (kbd "C-c w") 'dictionary)

;; フォント設定
;; http://weboo-returns.com/blog/inconsolata-as-a-programming-font/?utm_source=twitterfeed&utm_medium=twitter
;;(set-face-attribute 'default nil
;;                    :family "inconsolata"
;;                    :height 140)

(provide 'init-mac)
