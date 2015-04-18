# emacs settings

## 前提条件

emacsのversionは24.4以上であること．

## setup

    git clone --recursive https://github.com/masaaki1001/.emacs.d.git ~/.emacs.d

## 初期インストール

`setup.sh`を実行する.

    cd ~/.emacs.d
    ./setup.sh

以下がインストールされる.

* [Cask](http://cask.readthedocs.org/en/latest/)
* [DDSKK](http://openlab.ring.gr.jp/skk/ddskk-ja.html)


以下の手順は`setup.sh`にて実行されている．
---

## 依存ライブラリのインストール

インストールされるライブラリは`Cask`ファイル参照．

    cask install

## ternのインストール

[tern](https://github.com/marijnh/tern)を利用しているので以下の手順を実行する．

    cd repositories/tern
    npm install


以下の手順は手動で実行する．
---

## elispのインストール

`Cask`からインストールする事が出来ないものは[auto-install](http://www.emacswiki.org/emacs/auto-install.el)で手動でインストールする.

インストールする対象は`install-lisp-list`に記載されているもの．
