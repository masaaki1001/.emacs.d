;;----------------------------------------------------------------------------
;; filecache
;;----------------------------------------------------------------------------
(require 'filecache nil t)

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

(provide 'init-filecache)
