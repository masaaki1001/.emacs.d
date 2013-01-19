; -*- mode: lisp; coding: utf-8 -*-
;; http://d.hatena.ne.jp/tarao/20130110/1357821338
;; (require 'hatena-diary)
(require 'hatena-markup-mode)
(setq hatena:d:major-mode 'hatena:markup-mode)
(require 'hatena-multi-mode)
(add-hook 'hatena:markup-mode-hook #'hatena:multi-mode)

(autoload 'hatena:d:new "hatena-diary"
  "List Hatena::Diary new entries in a buffer." t)
(autoload 'hatena:d:list "hatena-diary"
  "List Hatena::Diary blog entries in a buffer." t)
(autoload 'hatena:d:list-draft "hatena-diary"
  "List Hatena::Diary draft entries in a buffer." t)
(eval-after-load 'hatena-diary
  '(load "~/.emacs.d/resource/.hatena-credentials.gpg"))

(provide 'init-hatena)
