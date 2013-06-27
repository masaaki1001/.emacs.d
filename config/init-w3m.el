(add-to-list 'load-path
       	     "~/.emacs.d/emacs-w3m/share/emacs/site-lisp/w3m")
(add-to-list 'Info-additional-directory-list
       	     "~/.emacs.d/emacs-w3m/share/info")
(require 'w3m-load nil t)
;; (setq w3m-use-cookies t) 		 ;ログイン可能にする
;; (setq w3m-favicon-cache-expire-wait nil) ;favicon のキャッシュを消さない

(provide 'init-w3m)
