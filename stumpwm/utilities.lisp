(load-module "swm-ssh")
(setq swm-ssh:*swm-ssh-default-term" "urxvtc")
(define-key *rrot-map* "s" "swm-ssh-menu")
