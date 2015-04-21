(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-use-faces nil)

(ido-vertical-mode)
(flx-ido-mode t)
(setq smex-save-file (expand-file-name ".smex-items" resource-dir))
(smex-initialize)

;; http://tam5917.hatenablog.com/entry/2014/10/22/213509
(defun recentf-ido-find-files-and-dirs (arg)
  "Find a recent file and a directory using Ido."
  (interactive "P")
  (let* ((show-full-path-p (cond (arg t) (t nil)))
         (file-assoc-list
          (mapcar (lambda (x)
                    (cond ((equal (substring x (- (length x) 1) (length x)) "/")
                           (cons (file-name-directory x) x))
                          (t
                           (cond (show-full-path-p
                                  (cons x x))
                                 (t
                                  (cons (file-name-nondirectory x) x))))))
                  recentf-list))
         (filename-list
          (remove-duplicates (mapcar #'car file-assoc-list)
                             :test #'string=))
         (filename (ido-completing-read "Choose recent file or directory: "
                                        filename-list nil t)))
    (when filename
      (find-file (cdr (assoc filename file-assoc-list))))))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c r") 'recentf-ido-find-files-and-dirs)

(provide 'init-ido)
