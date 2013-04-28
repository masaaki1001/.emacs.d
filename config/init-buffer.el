;;----------------------------------------------------------------------------
;; Buffer関連
;;----------------------------------------------------------------------------
;; バッファ一覧を詳細に
(global-set-key (kbd "C-x C-b") 'bs-show)

;; ミニバッファの履歴をC-rでインクリメンタルサーチできるように
;; http://www.sodan.org/~knagano/emacs/minibuf-isearch/minibuf-isearch.el
(require 'minibuf-isearch nil t)

;; i-searchでのbackspace有効
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
;; isearch の終了時のカーソル位置を常に検索語の後ろにする
;; http://www.bookshelf.jp/soft/meadow_49.html#SEC716
(define-key isearch-mode-map (kbd "M-m") 'isearch-exit)
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (cond
             ((eq last-input-char ?\C-m)
              (goto-char (match-end 0)))
             ((eq last-input-char ?\M-m)
              (goto-char (match-beginning 0))))))

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
(global-set-key (kbd "C-t") 'switch-to-last-buffer-or-other-window)

;; zlc.el
;; http://d.hatena.ne.jp/mooz/20101003/p1
;; https://github.com/mooz/emacs-zlc/
(when (require 'zlc nil t)
  (zlc-mode t))

(provide 'init-buffer)
