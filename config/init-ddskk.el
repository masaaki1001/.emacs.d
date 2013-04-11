;;---------------------------------------------------------
;; ddskk
;; http://openlab.ring.gr.jp/skk/index-j.html
;; http://quruli.ivory.ne.jp/document/ddskk_14.2/skk_toc.html#SEC_Contents
;; http://www.bookshelf.jp/texi/skk/skk_4.html#SEC15
;;---------------------------------------------------------
(when (require 'skk-autoloads nil t)
;; http://sheephead.homelinux.org/2010/06/18/1894/
(setq skk-user-directory "~/.emacs.d/ddskk/") ; ディレクトリ指定
(setq skk-large-jisyo "~/.emacs.d/ddskk/SKK-JISYO.L")

;; skk用にshift-stickyを";"に設定する
(setq skk-sticky-key ";")

;; C-x C-j で skk モードを起動
(global-set-key (kbd "C-x j") 'skk-mode)
;; .skk を自動的にバイトコンパイル
(setq skk-byte-compile-init-file t)
(require 'info nil t)
(add-to-list 'Info-additional-directory-list "~/.emacs.d/ddskk/info")
;;(global-set-key [?\S- ] 'skk-mode)
;;チュートリアルの場所設定
(setq skk-tut-file "~/.emacs.d/ddskk/SKK.tut")
;; メッセージを日本語で通知する
(setq skk-japanese-message-and-error t)
;; メニューを日本語で表示する
(setq skk-show-japanese-menu t)
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
;; 句読点を動的に決定する
;; (add-hook 'skk-mode-hook
;;           (lambda ()
;;             (save-excursion
;;               (goto-char 0)
;;               (make-local-variable 'skk-kutouten-type)
;;               (if (re-search-forward "。" 10000 t)
;;                   (setq skk-kutouten-type 'en)
;;                 (setq skk-kutouten-type 'jp)))))
;; 句読点に ．， を使う
(setq-default skk-kutouten-type 'en)
;; 送り仮名が厳密に正しい候補を優先して表示する
(setq skk-henkan-strict-okuri-precedence t)
;; 辞書登録のとき、余計な送り仮名を送らないようにする
(setq skk-check-okurigana-on-touroku 'auto)
;; 変換の学習
(require 'skk-study nil t)
;;単漢字検索のキーを!にする
(setq skk-tankan-search-key ?!)
;; モード表示の色を設定する
(setq skk-indicator-use-cursor-color nil)
(setq skk-emacs-hiragana-face "LimeGreen")
;; 動的補完の可否を判定するより高度な設定例
(setq skk-dcomp-activate
      #'(lambda ()
          (and
           ;; -nw では動的補完をしない。
           window-system
           ;; 基本的に行末のときのみ補完する。ただし行末でなくても現在の
           ;; ポイントから行末までの文字が空白のみだったら補完する。
           (or (eolp)
               (looking-at "[ \t]+$")))))
;; 動的補完で候補を複数表示する
(setq skk-dcomp-multiple-activate t))

(provide 'init-ddskk)
