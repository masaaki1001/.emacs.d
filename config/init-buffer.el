; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; Buffer関連
;;----------------------------------------------------------------------------
;; バッファ一覧を詳細に
(global-set-key "\C-x\C-b" 'bs-show)
;; ミニバッファの履歴を【C-r】でインクリメンタルサーチできるように
;; http://www.sodan.org/~knagano/emacs/minibuf-isearch/minibuf-isearch.el
(require 'minibuf-isearch)

;; i-searchでのBS有効
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
;; isearch の終了時のカーソル位置を常に検索語の後ろにする
;; http://www.bookshelf.jp/soft/meadow_49.html#SEC716
(define-key isearch-mode-map "\M-m" 'isearch-exit)
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (cond
             ((eq last-input-char ?\C-m)
              (goto-char (match-end 0)))
             ((eq last-input-char ?\M-m)
              (goto-char (match-beginning 0))))))

;; iswitchb.el
;; Emacs本より
;;(iswitchb-mode t) ;; anythingがあるのでコメントアウト
;; バッファ読み取り関数を iswitchb にする
(setq read-buffer-function 'iswitchb-read-buffer)
;; 部分文字列の代わりに正規表現を使う場合はtに設定
(setq iswitchb-regexp nil)
;; 新しいバッファを作成するときにいちいち聞いてこない
(setq iswitchb-prompt-newbuffer nil)

;; バッファ移動を一瞬で行う
;; http://d.hatena.ne.jp/rubikitch/20111211/smalldisplay
;;; last-buffer
(defvar last-buffer-saved nil)
;; last-bufferで選択しないバッファを設定
(defvar last-buffer-exclude-name-regexp
  (rx (or "*mplayer*" "*Completions*" "*Org Export/Publishing Help*" "*Messages*" "*anything*" "*Warnings*" "*Packages*" "TAGS"
          (regexp "^ "))))
(defun record-last-buffer ()
  (when (and (one-window-p)
             (not (eq (window-buffer) (car last-buffer-saved)))
             (not (string-match last-buffer-exclude-name-regexp
                                (buffer-name (window-buffer)))))
    (setq last-buffer-saved
          (cons (window-buffer) (car last-buffer-saved)))))
(add-hook 'window-configuration-change-hook 'record-last-buffer)
(defun switch-to-last-buffer ()
  (interactive)
  (condition-case nil
      (switch-to-buffer (cdr last-buffer-saved))
    (error (switch-to-buffer (other-buffer)))))

(defun switch-to-last-buffer-or-other-window ()
  (interactive)
  (if (one-window-p t)
      (switch-to-last-buffer)
    (other-window 1)))
(global-set-key (kbd "\C-t") 'switch-to-last-buffer-or-other-window)

;; cycle-buffer.el
;; http://www.bookshelf.jp/cgi-bin/goto.cgi?file=meadow&node=cyclebuf
(autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
(autoload 'cycle-buffer-backward
  "cycle-buffer" "Cycle backward." t)
(autoload 'cycle-buffer-permissive
  "cycle-buffer" "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive
  "cycle-buffer" "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting
  "cycle-buffer" "Toggle if this buffer will be considered." t)
(global-set-key [(f9)]        'cycle-buffer-backward)
(global-set-key [(f10)]       'cycle-buffer)
(global-set-key [(shift f9)]  'cycle-buffer-backward-permissive)
(global-set-key [(shift f10)] 'cycle-buffer-permissive)

(provide 'init-buffer)
