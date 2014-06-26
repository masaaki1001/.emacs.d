# emacs settings

## 前提条件

`package.el`を利用しているのでemacsのversionは24以上であること．

## setup

submoduleを含めてcloneしてくる．

    git clone --recursive https://github.com/masaaki1001/.emacs.d.git ~/.emacs.d

## 初期インストール

[Cask](http://cask.readthedocs.org/en/latest/)を利用するためインストールする．

また，同時に[DDSKK](http://openlab.ring.gr.jp/skk/ddskk-ja.html)もインストールされる．

* `cd ~/.emacs.d`
* `./setup.sh`

## 依存ライブラリのインストール

インストールされるライブラリは`Cask`ファイル参照．

    cask install

## elispのインストール

`Cask`からインストールする事が出来ないものは[auto-install](http://www.emacswiki.org/emacs/auto-install.el)で手動でインストールする.

インストールする対象は`install-lisp-list`に記載されているもの．

## ternのインストール

[tern](https://github.com/marijnh/tern)を利用しているので以下の手順を実行する．

* repositories/ternに移動する
* `npm install`を実行
