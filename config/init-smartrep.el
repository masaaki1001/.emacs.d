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
         ("P" . highlight-symbol-prev-in-defun)
         ("N" . highlight-symbol-next-in-defun)
         ("X" . highlight-symbol-remove-all)
         ("L" . highlight-symbol-list-all)
         ("x" . highlight-symbol-at-point)))
    (quit (highlight-symbol-at-point))))
(global-set-key (kbd "C-c s") 'highlight-symbol-at-point-smartrep)

(provide 'init-smartrep)
