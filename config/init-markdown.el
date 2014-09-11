;;;; markdown
;; markdown-css
(setq github-markdown-style-dir (expand-file-name "github-css" repositories-dir))
(setq markdown-css-themes-dir (expand-file-name "markdown-css-themes" repositories-dir))

(setq markdown-css-path (expand-file-name "github.css" github-markdown-style-dir))

(provide 'init-markdown)
