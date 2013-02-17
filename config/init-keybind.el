;;----------------------------------------------------------------------------
;; keybind
;;----------------------------------------------------------------------------
;; (global-set-key "\C-h" 'delete-backward-char) ; 削除
(global-set-key "\M-h" 'backward-kill-word)
(if (= emacs-major-version 23)
  (progn
    (pc-selection-mode) ;; Shift + 矢印キーで範囲選択
    )
  (progn))

(setq kill-whole-line t) ;; C-k で改行を含め切り取り
;; 改行時にインデント
(global-set-key "\C-m" 'newline-and-indent)
;; 指定行へ移動
(global-set-key "\M-g" 'goto-line)

;; 単語削除で切り取りではなく削除になるようにする
;; http://d.hatena.ne.jp/syohex/20110329/
(defun delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  (interactive "p")
  (delete-word (- arg)))
(global-set-key (kbd "M-d") 'delete-word)
(global-set-key [C-backspace] 'backward-delete-word)

;; http://openlab.dino.co.jp/2007/09/25/23251372.html
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat)
  (terminal-init-bobcat))

;; 対応する括弧に移動(C-M-f/p相当)
;; http://www23.atwiki.jp/selflearn/pages/41.html
(global-set-key [?\C-{] 'backward-list)
(global-set-key [?\C-}] 'forward-list)

;; emacsのc-u-c-uを8回繰り返しにする
;; http://d.akinori.org/2010/03/05/emacsのc-u-c-uを8回繰り返しにする/
(defadvice universal-argument-more
  (before stop-by-eight-before-sixteen (arg) activate)
  "Stop by eight before sixteen."
  (let ((num (car arg)))
    (if (> 16 num) (ad-set-arg 0 (list (/ num 2))))))

;; バックスラッシュ
(define-key global-map (kbd "M-|") "\\")

;; http://d.hatena.ne.jp/kbkbkbkb1/20111205/1322988550
;; enable to pop `mark-ring' repeatedly like C-u C-SPC C-SPC ...
(setq set-mark-command-repeat-pop t)

;; Use C-x C-m to do M-x per Steve Yegge's advice
;; https://sites.google.com/site/steveyegge2/effective-emacs
;; https://github.com/magnars/.emacs.d/commit/0291309114029e1402fc59b84050a069f9e89b2c
(global-set-key "\C-x\C-m" 'execute-extended-command)

;; 範囲指定していないとき、C-wで前の単語を削除
;; http://dev.ariel-networks.com/wp/documents/aritcles/emacs/part16
(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))

;; move line down and up
(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

(global-set-key (kbd "<M-down>") 'move-line-down)
(global-set-key (kbd "<M-up>") 'move-line-up)

(provide 'init-keybind)
