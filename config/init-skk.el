;;;; ddskk
;; http://openlab.ring.gr.jp/skk/index-j.html
;; http://quruli.ivory.ne.jp/document/ddskk_14.2/skk_toc.html#SEC_Contents
;; http://www.bookshelf.jp/texi/skk/skk_4.html#SEC15
(require 'skk)
(require 'skk-autoloads)
(require 'skk-study)
;; http://sheephead.homelinux.org/2010/06/18/1894/
(setq skk-user-directory (expand-file-name ".skk" user-emacs-directory))
;; (setq skk-jisyo (expand-file-name "jisyo" resource-dir))
(setq skk-large-jisyo (expand-file-name "SKK-JISYO.L" skk-user-directory))
;; skk用にshift-stickyを";"に設定する
(setq skk-sticky-key ";")
;; C-x j で skk モードを起動
(global-set-key (kbd "C-x j") 'skk-mode)
;; .skk を自動的にバイトコンパイル
(setq skk-byte-compile-init-file t)
(add-to-list 'Info-additional-directory-list (expand-file-name "info" skk-user-directory))
;;チュートリアルの場所設定
(setq skk-tut-file (expand-file-name "SKK.tut" skk-user-directory))
;; 変換時に注釈 (annotation) を表示する
(setq skk-show-annotation t)
;; 変換候補一覧と注釈 (annotation) を GUI ぽく表示する
(setq skk-show-tooltip t)
;; 変換候補をインラインに表示する
(setq skk-show-inline t)
;; Enter キーを押したときには確定する
(setq skk-egg-like-newline t)
;; 対応する閉括弧を自動的に挿入する
(setq skk-auto-insert-paren t)
;; 句読点に ．， を使う
(setq-default skk-kutouten-type 'en)
;; 送り仮名が厳密に正しい候補を優先して表示する
(setq skk-henkan-strict-okuri-precedence t)
;; 辞書登録のとき、余計な送り仮名を送らないようにする
(setq skk-check-okurigana-on-touroku 'auto)
;;単漢字検索のキーを!にする
;; (setq skk-tankan-search-key ?!)
;; モード表示の色を設定する
(setq skk-indicator-use-cursor-color nil)
(setq skk-emacs-hiragana-face "LimeGreen")
;; 動的補完の可否を判定するより高度な設定例
;; (setq skk-dcomp-activate
;;       #'(lambda ()
;;           (and
;;            ;; -nw では動的補完をしない。
;;            window-system
;;            ;; 基本的に行末のときのみ補完する。ただし行末でなくても現在の
;;            ;; ポイントから行末までの文字が空白のみだったら補完する。
;;            (or (eolp)
;;                (looking-at "[ \t]+$")))))
;; 動的補完で候補を複数表示する
(setq skk-dcomp-multiple-activate t)

;; (setq skk-status-indicator 'left)
(defun my/skk-hook ()
  (skk-latin-mode t))
(add-hook 'find-file-hooks 'my/skk-hook)

;; (setq skk-isearch-start-mode 'latin)

(provide 'init-skk)
