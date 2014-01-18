;;;; package.el
;; http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/emacs-lisp/package.el
(require 'package)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(package-refresh-contents)

(defvar init-install-packages
  '(
    cl-lib
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
    git-commit-mode
    gitconfig-mode
    gitignore-mode
    git-messenger
    git-rebase-mode
    gh
    elscreen
    flycheck
    undohist
    point-undo
    quickrun
    all
    all-ext
    replace-from-region
    expand-region
    multiple-cursors
    redo+
    bash-completion
    yagist
    scala-mode2
    ensime
    yaml-mode
    anything
    anything-git-files
    helm
    helm-swoop
    helm-projectile
    helm-ls-git
    helm-c-yasnippet
    helm-open-github
    helm-spaces
    helm-git-grep
    helm-dired-recent-dirs
    helm-ag
    helm-descbinds
    helm-rails
    helm-rb
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
    dash-at-point
    zeal-at-point
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
    tss
    jquery-doc
    nodejs-repl
    coffee-mode
    wgrep
    wgrep-ag
    grep-a-lot
    ag
    smartrep
    pomodoro
    zlc
    revive
    exec-path-from-shell
    volatile-highlights
    highlight-symbol
    undo-tree
    yasnippet
    dropdown-list
    web-mode
    w3m
    migemo
    anzu
    move-text
    highlight-escape-sequences
    edit-server
    ))

(dolist (package init-install-packages)
  (when (not (package-installed-p package))
    (package-install package)))

;; auto-install.el
(when (require 'auto-install nil t)
 (setq auto-install-directory "~/.emacs.d/auto-install/")
 (auto-install-compatibility-setup)             ; 互換性確保
 )

(provide 'init-elpa)
