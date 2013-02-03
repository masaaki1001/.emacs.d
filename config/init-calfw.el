;; http://d.hatena.ne.jp/kiwanami/20110723/1311434175
(when (require 'calfw nil t)
  ;;(cfw:open-calendar-buffer) ; カレンダー表示
  ;; calfw-org.el
  (require 'calfw-org nil t)
  ;; 月
  (setq calendar-month-name-array
    ["January" "February" "March"     "April"   "May"      "June"
     "July"    "August"   "September" "October" "November" "December"])

  ;; 曜日
  (setq calendar-day-name-array
        ["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"])

  ;; ;; 週の先頭の曜日
  (setq calendar-week-start-day 0) ; 日曜日は0, 月曜日は1

  (when (require 'calendar nil t)
    (setq  number-of-diary-entries 31)
    (define-key calendar-mode-map "f" 'calendar-forward-day)
    (define-key calendar-mode-map "n" 'calendar-forward-day)
    (define-key calendar-mode-map "b" 'calendar-backward-day)
    (setq mark-holidays-in-calendar t))

  (when (require 'japanese-holidays nil t)
    (setq calendar-holidays
          (append japanese-holidays local-holidays other-holidays))
    (setq calendar-weekend-marker 'diary)
    (add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
    (add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend))
  )

(provide 'init-calfw)
