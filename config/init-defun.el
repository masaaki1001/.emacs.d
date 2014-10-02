;;;; defuns
;; 縦分割と横分割を切り替える M-x window-toggle-divisionでできるようにする
;; http://d.hatena.ne.jp/himadatanode/20061011/p2
(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)

    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )
    (switch-to-buffer-other-window other-buf)
    (other-window -1)))

(defun kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (loop for buffer being the buffers
     do (kill-buffer buffer)))

(defun kill-other-buffers ()
  "Kill all buffers except the current and unsplit the window."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
  (delete-other-windows)
  (delete-other-frames))

;; https://github.com/magnars/.emacs.d/blob/master/defuns/buffer-defuns.el#L139
(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)

(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename t)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))
(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)

(defun dired-create-file (file-name)
  (interactive "F Create file: ")
  (write-region "" nil file-name nil nil nil))
(define-key dired-mode-map (kbd "i") 'dired-create-file)

(defun toggle-frame-alpha ()
  "半透明 <-> 黒背景.
   パラメータは、順に通常のフレーム，アクティブでないフレームの透明度を表す"
  (interactive)
  (let ((alpha-parameter (frame-parameter nil 'alpha)))
    (if (equal alpha-parameter 80)
        (set-frame-parameter nil 'alpha 100)
      (set-frame-parameter nil 'alpha 80))))

;; New macro `with-eval-after-load' in Emacs 24.4
;; http://www.lunaryorn.com/2013/06/25/introducing-with-eval-after-load.html
(unless (fboundp 'with-eval-after-load)
  (defmacro with-eval-after-load (file &rest body)
    `(eval-after-load ,file
       `(funcall (function ,(lambda () ,@body))))))

(provide 'init-defun)
