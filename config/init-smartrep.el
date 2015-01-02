;; http://sheephead.homelinux.org/2011/12/19/6930/
(require 'smartrep)

(defadvice smartrep-map-internal (around smartrep-silence-echo-keystrokes activate)
  (let ((echo-keystrokes 0))
    ad-do-it
    ))

;; multiple-cursors
(smartrep-define-key
    global-map "C-q"
  '(("n" . 'mc/mark-next-like-this)
    ("p" . 'mc/mark-previous-like-this)
    ("a" . 'mc/mark-all-like-this)
    ("i" . 'mc/interactive-insert-numbers)
    ("I" . 'mc/insert-numbers)))

;; goto-chg
(smartrep-define-key
    global-map "C-q"
  '(("C-/" . 'goto-last-change)
    ("C-M-/" . 'goto-last-change-reverse)))

;; point-undo
(smartrep-define-key
    global-map "C-q"
  '(("u" . 'point-undo)
    ("r" . 'point-redo)))

(provide 'init-smartrep)
