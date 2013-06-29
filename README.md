# emacs settings

## 前提条件

package.elを利用しているのでemacsのversionは24以上であること．

## setup

    git clone --recursive https://github.com/masaaki1001/.emacs.d.git ~/.emacs.d

## 依存ライブラリのインストール

初回起動時にpackage.elで[melpa](http://melpa.milkbox.net/)から自動的にインストールされる．

## elispのインストール

package.elからインストールする事が出来ないものは[auto-install](http://www.emacswiki.org/emacs/auto-install.el)で手動でインストールする．
インストールする対象は`install-lisp-list`に記載されているもの．

## ternのインストール

[tern](https://github.com/marijnh/tern)を利用しているので以下の手順を実行する．

* repositories/ternに移動する
* `npm install`を実行
