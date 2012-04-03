; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; filecache
;;----------------------------------------------------------------------------
(when (require 'filecache nil t)
;;(file-cache-add-directory-list
;;  (list "~" "~/.emacs.d/")) ;; ディレクトリを追加
  )

(file-cache-add-directory-using-find "~/Workspace/hoge")
(define-key minibuffer-local-completion-map "\C-c\C-i"
  'file-cache-minibuffer-complete)

(eval-after-load
    "filecache"
  '(progn
     (message "Loading file cache...")
     (file-cache-add-directory-using-find "~/Workspace/hoge")
     ;;(file-cache-add-directory-list load-path)
     ))

(defun file-cache-save-cache-to-file (file)
  "Save contents of `file-cache-alist' to FILE.
For later retrieval using `file-cache-read-cache-from-file'"
  (interactive "FFile: ")
  (with-temp-file (expand-file-name file)
    (prin1 file-cache-alist (current-buffer))))

(defun file-cache-read-cache-from-file (file)
  "Clear `file-cache-alist' and read cache from FILE.
The file cache can be saved to a file using
`file-cache-save-cache-to-file'."
  (interactive "fFile: ")
  (file-cache-clear-cache)
  (let ((buf (find-file-noselect file)))
    (setq file-cache-alist (read buf))
    (kill-buffer buf)))

(defvar anything-source-file-cache
  '((name . "File Cache")
    (candidates . file-cache-files)
    (type . file)))

(provide 'init-filecache)