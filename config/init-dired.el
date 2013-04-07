;;----------------------------------------------------------------------------
;; dired
;;----------------------------------------------------------------------------
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

;; s を何回か入力すると，拡張子やサイズによる並び換えもできる
(load "sorter")
;; ディレクトリを先に表示する
(setq ls-lisp-dirs-first t)
;; ディレクトリ内のファイル名を編集できるようにする
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;; 削除したらごみ箱行き
(setq delete-by-moving-to-trash t)

;; direx.el
;; http://cx4a.blogspot.com/2011/12/popwineldirexel.html
;; https://github.com/m2ym/direx-el/
;; https://raw.github.com/m2ym/direx-el/master/direx.el
(require 'direx nil t)
;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
;;(push '(direx:direx-mode :position left :width 25 :dedicated t)
;;      popwin:special-display-config)
;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
;;(setq direx:leaf-icon "  "
;;      direx:open-icon "▾ "
;;      direx:closed-icon "▸ ")

;; joseph-single-dired.el
;; diredのバッファが増えないようにする
;; https://github.com/jixiuf/joseph-single-dired
;; https://raw.github.com/jixiuf/joseph-single-dired/master/joseph-single-dired.el
(when (require 'joseph-single-dired nil t)
  (eval-after-load 'dired '(require 'joseph-single-dired)))

;; dired-filetype-face.el
;; diredの表示をファイルタイプ毎に色分けしてカラフルにする
(require 'dired-filetype-face nil t)

;; diredでマークをつけたファイルを開く
;; http://d.hatena.ne.jp/oh_cannot_angel/20101216/1292506110
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "F") 'my-dired-find-marked-files)
     (defun my-dired-find-marked-files (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))

;; diredでマークをつけたファイルをviewモードで開く
;; http://d.hatena.ne.jp/oh_cannot_angel/20101216/1292506110
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "V") 'my-dired-view-marked-files)
     (defun my-dired-view-marked-files (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'view-file fn-list)))))

;;;;ファイル作成
(defun dired-create-file (file-name)
  (interactive "F Create file: ")
  (write-region "" nil file-name nil nil nil))
(define-key dired-mode-map "i" 'dired-create-file)

(provide 'init-dired)
