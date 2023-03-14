(when *initializing*
  (grename "[1]")
  (gnewbg "[2]")
  (gnewbg "[3]")
  (gnewbg "[4]")
  (gnewbg "[5]"))

(clear-window-placement-rules)

(define-frame-preference "1" (nil t t :class "Ranger"))

(setf *dynamic-group-master-split-ratio* 1/2) ; half the available space
