(with-eval-after-load 'esell
  ;; 補完時に大文字小文字を区別しない
  (setq eshell-cmpl-ignore-case t)
  ;; 履歴で重複を無視する
  (setq eshell-hist-ignoredups t)
  ;; 確認なしでヒストリ保存
  (setq eshell-ask-to-save-history (quote always))
  (setq eshell-directory-name (expand-file-name ".eshell" resource-dir)))

;; alias
(with-eval-after-load 'em-alias
  (eshell/alias "ll" "ls -la $*"))

(with-eval-after-load 'esh-opt
  (require 'eshell-prompt-extras)
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-dakrone))

(provide 'init-eshell)
