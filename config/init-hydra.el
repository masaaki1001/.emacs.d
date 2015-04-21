(defhydra hydra-multiple-cursors (global-map "C-q")
  "multiple-cursors"
  ("n" mc/mark-next-like-this "next")
  ("p" mc/mark-previous-like-this "previous")
  ("a" mc/mark-all-like-this "all")
  ("i" mc/interactive-insert-numbers "Interactive insert number")
  ("I" mc/insert-numbers  "insert number")
  ("j" mc/cycle-forward "cycle forward")
  ("k" mc/cycle-backward  "cycle backward")
  ("u" mc/unmark-next-like-this "ummark next")
  ("U" mc/unmark-previous-like-this "unmark previous")
  ("s" mc/skip-to-next-like-this "skip next")
  ("S" mc/skip-to-previous-like-this "skip previous")
  ("'" mc-hide-unmatched-lines-mode "hide unmatched line"))

(defhydra hydra-goto-chg (global-map "C-q")
  "goto-chg"
  ("C-/" goto-last-change "change")
  ("C-M-/" goto-last-change-reverse "reverse"))

(defhydra hydra-point-undo (global-map "C-q")
  "point-undo"
  ("u" point-undo "undo")
  ("r" point-redo "redo"))

(provide 'init-hydra)
