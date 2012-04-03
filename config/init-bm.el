; -*- mode: lisp; coding: utf-8 -*-
;;----------------------------------------------------------------------------
;; bm.el
;; from marmalade
;; Emacs tech Book p116
;; http://d.hatena.ne.jp/kenkov/20110507/1304754238
;; http://d.hatena.ne.jp/peccu/20100402
;; https://github.com/joodland/bm/blob/master/bm.el
;;----------------------------------------------------------------------------
(when (require 'bm nil t)
  ;; マークのセーブ
  (setq-default bm-buffer-persistence t)
  (setq bm-repository-file "~/.emacs.d/resource/.bm-repository")
  ;; 起動時に設定のロード
  (setq bm-restore-repository-on-load t)
  (add-hook 'after-init-hook 'bm-repository-load)
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  ;; 設定ファイルのセーブ
  (add-hook 'kill-buffer-hook 'bm-buffer-save)
  (add-hook 'auto-save-hook 'bm-buffer-save)
  (add-hook 'after-save-hook 'bm-buffer-save)
  (add-hook 'vc-before-checkin-hook 'bm-buffer-save)
  (add-hook 'after-revert-hook 'bm-buffer-restore)
  (global-set-key (kbd "<M-f2>") 'bm-toggle)
  (global-set-key (kbd "M-[") 'bm-previous)
  (global-set-key (kbd "M-]") 'bm-next)
  ;Saving the repository to file when on exit.
  ;kill-buffer-hook is not called when emacs is killed, so we
  ;must save all bookmarks first.
  (add-hook 'kill-emacs-hook '(lambda nil
                                (bm-buffer-save-all)
                                (bm-repository-save)))

  ;; http://d.hatena.ne.jp/peccu/20100402/bmglobal
  (defvar anything-c-source-bm-global-use-candidates-in-buffer
    '((name . "Global Bookmarks")
      (init . anything-c-bm-global-init)
      (candidates-in-buffer)
      (type . file-line))
    "show global bookmarks list.
Global means All bookmarks exist in `bm-repository'.

Needs bm.el.
http://www.nongnu.org/bm/")
  )
;; (anything 'anything-c-source-bm-global-use-candidates-in-buffer)
(defvaralias 'anything-c-source-bm-global 'anything-c-source-bm-global-use-candidates-in-buffer)
;; (anything 'anything-c-source-bm-global)

(defun anything-c-bm-global-init ()
  "Init function for `anything-c-source-bm-global'."
  (when (require 'bm nil t)
    (with-no-warnings
      (let ((files bm-repository)
            (buf (anything-candidate-buffer 'global)))
        (dolist (file files)            ;ブックマークされてるファイルリストから，1つ取り出す
          (dolist (bookmark (cdr (assoc 'bookmarks (cdr file)))) ;1つのファイルに対して複数のブックマークがあるので
            (let ((position (cdr (assoc 'position bookmark))) ;position
                  (annotation (cdr (assoc 'annotation bookmark))) ;annotation
                  (file (car file))                               ;file名を取り出す
                  line
                  str)
              (setq str (with-temp-buffer (insert-file-contents-literally file) ;anything用の文字列にformat
                               (goto-char position)
                               (beginning-of-line)
                               (unless annotation
                                   (setq annotation ""))
                               (if (string= "" line)
                                   (setq line  "<EMPTY LINE>")
                                 (setq line (car (split-string (thing-at-point 'line) "[\n\r]"))))
                               (format "%s:%d: [%s]: %s\n" file (line-number-at-pos) annotation line)))
              (with-current-buffer buf (insert str)))))))))

(provide 'init-bm)
