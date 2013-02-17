;;---------------------------------------------------------
;; moz.el
;; Firefoxを操作する
;; http://skalldan.wordpress.com/2011/06/26/firefox-%E3%81%A8-emacs-%E3%81%AE%E4%BC%9A%E8%A9%B1/
;; (auto-install-from-url "https://raw.github.com/bard/mozrepl/master/chrome/content/moz.el")
;;---------------------------------------------------------
;;(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
;;(moz-minor-mode t)
(when (require 'moz nil t)

  (defun moz-send-message (moz-command)
    (comint-send-string
     (inferior-moz-process)
     (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
             moz-repl-name ".setenv('inputMode', 'line'); "
             moz-repl-name ".setenv('printPrompt', false); undefined; "))
    (comint-send-string
     (inferior-moz-process)
     (concat moz-command
             moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n")))

  (defun moz-scrolldown ()
    (interactive)
    (moz-send-message "goDoCommand('cmd_scrollLineDown');\n")) ; 下スクロール
  (global-set-key (kbd "M-n") 'moz-scrolldown)

  (defun moz-scrollup ()
    (interactive)
    (moz-send-message "goDoCommand('cmd_scrollLineUp');\n")) ; 上スクロール
  (global-set-key (kbd "M-p") 'moz-scrollup)

  ;; http://blog.livedoor.jp/k1LoW/archives/65023888.html
  (defun moz-send-reload ()
    (interactive)
    (comint-send-string (inferior-moz-process)
                        (concat moz-repl-name ".pushenv('printPrompt', 'inputMode'); "
                                moz-repl-name ".setenv('inputMode', 'line'); "
                                moz-repl-name ".setenv('printPrompt', false); undefined; "))
    (comint-send-string (inferior-moz-process)
                        (concat "content.location.reload();\n"
                                moz-repl-name ".popenv('inputMode', 'printPrompt'); undefined;\n"))
    )

  (defun reload-moz()
    (if (string-match "\.\\(html\\|css\\|js\\|rb\\|erb\\)$" (buffer-file-name))
        (moz-send-reload)))
  (add-hook 'after-save-hook 'reload-moz)

  ;; ;; ... (適宜追加) ...
  )

(provide 'init-moz)
