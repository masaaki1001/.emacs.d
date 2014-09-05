;;;; package.el
;; http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/emacs-lisp/package.el
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

(package-initialize)

(package-refresh-contents)

(defvar init-install-packages
  '(
    auto-install
    auto-complete
    fuzzy
    popwin
    ac-ispell
    bm
    robe
    ruby-block
    inf-ruby
    ruby-interpolation
    ruby-tools
    rbenv
    rspec-mode
    rinari
    bundler
    rhtml-mode
    direx
    ;; dsvn
    rainbow-mode
    goto-chg
    maxframe
    color-moccur
    diminish
    magit
    magit-svn
    magit-find-file
    gitconfig-mode
    gitignore-mode
    git-messenger
    gh
    elscreen
    flycheck
    undohist
    point-undo
    quickrun
    all-ext
    ag
    replace-from-region
    expand-region
    multiple-cursors
    redo+
    bash-completion
    yagist
    scala-mode2
    ensime
    yaml-mode
    helm
    helm-swoop
    helm-projectile
    helm-ls-git
    helm-c-yasnippet
    helm-open-github
    helm-spaces
    helm-git-grep
    helm-git-files
    helm-ag
    helm-descbinds
    helm-rails
    helm-bm
    htmlize
    emmet-mode
    markdown-mode
    color-moccur
    scratch-log
    session
    savekill
    sequential-command
    duplicate-thing
    open-junk-file
    recentf-ext
    viewer
    elisp-slime-nav
    eldoc-extension
    paredit
    smartparens
    spaces
    switch-window
    jaunte
    ace-jump-mode
    imenu-anywhere
    less-css-mode
    scss-mode
    css-eldoc
    json-mode
    js2-mode
    js2-refactor
    tss
    jquery-doc
    nodejs-repl
    coffee-mode
    wgrep
    wgrep-ag
    grep-a-lot
    smartrep
    pomodoro
    zlc
    revive
    exec-path-from-shell
    volatile-highlights
    highlight-symbol
    undo-tree
    yasnippet
    web-mode
    w3m
    migemo
    anzu
    move-text
    highlight-escape-sequences
    edit-server
    apache-mode
    dired-k
    httprepl
    groovy-mode))

(if is-mac (add-to-list 'init-install-packages 'dash-at-point))
(if is-linux (add-to-list 'init-install-packages 'zeal-at-point))

(dolist (package init-install-packages)
  (when (not (package-installed-p package))
    (package-install package)))

;; auto-install.el
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-compatibility-setup)             ; 互換性確保

(provide 'init-elpa)
