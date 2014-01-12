#! /bin/bash

setup_ddskk() {
    local tar_file="ddskk-15.1.tar.gz"
    local ddskk=${tar_file%%.tar.gz}

    echo "Setup DDSKK."

    curl  -O http://openlab.ring.gr.jp/skk/maintrunk/$tar_file
    tar -xf $tar_file

    # download dictionary
    cd $ddskk/dic
    curl -O http://openlab.ring.gr.jp/skk/skk/dic/SKK-JISYO.L
    cd ../

    # set config
    echo "(setq SKK_DATADIR \"~/.emacs.d/ddskk\")" >> SKK-CFG
    echo "(setq SKK_INFODIR \"~/.emacs.d/ddskk/info\")" >> SKK-CFG
    echo "(setq SKK_LISPDIR \"~/.emacs.d/ddskk/site-lisp\")" >> SKK-CFG
    echo "(setq SKK_SET_JISYO t)" >> SKK-CFG
    make install EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs

    # clean up
    cd ../
    rm -rf $tar_file
    rm -rf $ddskk
}

setup_ddskk
