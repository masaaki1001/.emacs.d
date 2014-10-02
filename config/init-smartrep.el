;; http://sheephead.homelinux.org/2011/12/19/6930/
(require 'smartrep)
(setq orig-binding (key-binding "\C-l")) ; default key bind backup
(global-set-key (kbd "C-l") nil)
(global-set-key (kbd "C-l C-l") 'recenter-top-bottom)
;; (global-set-key "\C-l" orig-binding) ; default key bind revert

(defadvice smartrep-map-internal (around smartrep-silence-echo-keystrokes activate)
  (let ((echo-keystrokes 0))
    ad-do-it
    ))

;; multiple-cursors
(with-eval-after-load "multiple-cursors"
  (smartrep-define-key
      global-map "C-l"
    '(("n" . 'mc/mark-next-like-this)
      ("p" . 'mc/mark-previous-like-this)
      ("a" . 'mc/mark-all-like-this)
      ("i" . 'mc/interactive-insert-numbers)
      ("I" . 'mc/insert-numbers))))

;; org-mode
(with-eval-after-load "org"
  (smartrep-define-key
      org-mode-map "C-c"
    '(("n" . 'outline-next-visible-heading)
      ("p" . 'outline-previous-visible-heading))))

;; all-mode
(with-eval-after-load "all"
  (smartrep-define-key
      all-mode-map "M-g"
    '(("n"   . 'next-error)
      ("p"   . 'previous-error)
      ("C-n" . 'next-error)
      ("C-p" . 'previous-error))))

;; goto-chg
(with-eval-after-load "goto-chg"
  (smartrep-define-key
      global-map "C-q"
    '(("n" . 'goto-last-change)
      ("p" . 'goto-last-change-reverse))))

;; point-undo
(with-eval-after-load "point-undo"
  (smartrep-define-key
      global-map "C-q"
    '(("u" . 'point-undo)
      ("r" . 'point-redo))))

(defun highlight-symbol-at-point-smartrep ()
  (interactive)
  ;; highlight-symbol-at-pointより抜粋
  (let ((symbol (highlight-symbol-get-symbol)))
    (unless symbol (error "No symbol at point"))
    (when (and font-lock-mode (not (highlight-symbol-symbol-highlighted-p symbol)))
      (highlight-symbol-add-symbol symbol)))
  ;; smartrep化するコマンドを増やす
  (message "[p]rev [n]ext [P]revDefun [N]extDefun [L]ist [a]ll [x]Remove [X]RemoveAll")
  (condition-case e
      (smartrep-read-event-loop
       '(("p" . highlight-symbol-prev)
         ("n" . highlight-symbol-next)
         ("s" . highlight-symbol-next)
         ("r" . highlight-symbol-prev)
         ("C-s" . highlight-symbol-next)
         ("C-r" . highlight-symbol-prev)
         ("P" . highlight-symbol-prev-in-defun)
         ("N" . highlight-symbol-next-in-defun)
         ("X" . highlight-symbol-remove-all)
         ("L" . highlight-symbol-list-all)
         ("a" . highlight-symbol-all)
         ("x" . highlight-symbol-at-point)))
    (quit (highlight-symbol-at-point))))
(global-set-key (kbd "C-c s") 'highlight-symbol-at-point-smartrep)

(provide 'init-smartrep)
