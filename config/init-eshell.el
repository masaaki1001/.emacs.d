;; キーバインドをshellらしくする
(progn
  (defun eshell-in-command-line-p ()
    (<= eshell-last-output-end (point)))
  (defmacro defun-eshell-cmdline (key &rest body)
    (let ((cmd (intern (format "eshell-cmdline/%s" key))))
      `(progn
         (add-hook 'eshell-mode-hook
                   (lambda () (define-key eshell-mode-map
                                (read-kbd-macro ,key) ',cmd)))
         (defun ,cmd ()
           (interactive)
           (if (not (eshell-in-command-line-p))
               (call-interactively (lookup-key (current-global-map)
                                               (read-kbd-macro ,key)))
             ,@body)))))
  (defun eshell-history-and-bol (func)
    (delete-region eshell-last-output-end (point-max))
    (funcall func 1)
    (goto-char eshell-last-output-end)))

;; 前のコマンドの履歴取得
(defun-eshell-cmdline "M-p"
  (let ((last-command 'eshell-previous-matching-input-from-input))
    (eshell-history-and-bol 'eshell-previous-matching-input-from-input)))
;; 次のコマンドの履歴取得
(defun-eshell-cmdline "M-n"
  (let ((last-command 'eshell-previous-matching-input-from-input))
    (eshell-history-and-bol 'eshell-next-input)))
;; 直前の履歴を取得
(defadvice eshell-send-input (after history-position activate)
  (setq-default eshell-history-index -1))
;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
(setq eshell-directory-name (expand-file-name ".eshell" resource-dir))
;; alias
(with-eval-after-load "em-alias"
  (eshell/alias "ll" "ls -la $*"))

(with-eval-after-load "esh-opt"
  (require 'eshell-prompt-extras)
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-dakrone))

(provide 'init-eshell)
