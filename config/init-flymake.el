; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; flymake
;;----------------------------------------------------------------------------
(when (require 'flymake nil t)
  ;; GUIの警告は表示しない
  (setq flymake-gui-warnings-enabled nil)
  ;; I don't like the default colors :)
  (set-face-background 'flymake-errline "red4")
  (set-face-background 'flymake-warnline "dark slate blue")

  ;; Invoke ruby with '-c' to get syntax checking
  ;; http://d.hatena.ne.jp/gan2/20080702/1214972962
  ;; ruby での設定
  (defun flymake-ruby-init ()
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list "ruby" (list "-c" local-file))))
  (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
  (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
  (add-hook 'ruby-mode-hook
            '(lambda ()

 	     ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
 	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
 		 (flymake-mode)))
          ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
          (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf))

  ;; flymakeのエラー/警告表示をミニバッファで
  ;; http://d.hatena.ne.jp/khiker/20070720/emacs_flymake
  ;; http://quantumfluctuation.blogspot.com/2011/05/flymake.html
  ;; miniBuffer にエラーを出力
  (defun credmp/flymake-display-err-minibuf ()
    ;;   "Displays the error/warning for the current line in the minibuffer"
   (interactive)
   (let* ((line-no             (flymake-current-line-no))
          (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
          (count               (length line-err-info-list))
          )
     (while (> count 0)
       (when line-err-info-list
         (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
                (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
                (text (flymake-ler-text (nth (1- count) line-err-info-list))) ;
                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
           (message "[%s] %s" line text)
           )
         )
       (setq count (1- count)))))
  ;;  (defun flymake-show-and-sit ()
  ;;   "Displays the error/warning for the current line in the minibuffer"
  ;;   (interactive)
  ;;   (progn
  ;;     (let* ((line-no (flymake-current-line-no) )
  ;;            (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
  ;;            (count (length line-err-info-list)))
  ;;       (while (> count 0)
  ;;         (when line-err-info-list
  ;;           (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
  ;;                  (full-file
  ;;                   (flymake-ler-full-file (nth (1- count) line-err-info-list)))
  ;;                  (text (flymake-ler-text (nth (1- count) line-err-info-list)))
  ;;                  (line (flymake-ler-line (nth (1- count) line-err-info-list))))
  ;;             (message "[%s] %s" line text)))
  ;;         (setq count (1- count)))))
  ;;   (sit-for 60.0))

  ;; http://d.hatena.ne.jp/sugyan/20100705
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  )

;; (require 'flymake-ruby)
;; (add-hook 'ruby-mode-hook 'flymake-ruby-load) ; anything-rdefsと競合する

(provide 'init-flymake)
