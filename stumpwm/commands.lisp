(defcommand delete-window-and-frame () ()
    "Delete the current frame with its window."
    (delete-window)
    (remove-split))

(defcommand hsplit-and-focus () ()
    "Create a new frame on the right and focus it."
    (hsplit)
    (move-focus :right))

(defcommand vsplit-and-focus () ()
    "Create a new frame below and move focus to it."
    (vsplit)
    (move-focus :down))

(defcommand term (&optional program) ()
    "Invoke a terminal, possibly with a @arg{program}."
    (sb-thread:make-thread
     (lambda ()
       (run-shell-command (if program
			      (format nil "urxvtc ~ A" program)
			      "urxvtc")))))
