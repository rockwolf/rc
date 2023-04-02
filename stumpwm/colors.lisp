(defvar gruvbox-bg "#282828")
(defvar gruvbox-fg "#ebdbb2")
(defvar gruvbox-red "#cc241d")
(defvar gruvbox-green "#98971a")
(defvar gruvbox-yellow "#d79921")
(defvar gruvbox-blue "#458588")
(defvar gruvbox-purple "#b16286")
(defvar gruvbox-aqua "#689d6a")
(defvar gruvbox-gray "#a89984")
(defvar gruvbox-orange "#d65d0e")
(defvar gruvbox-bg-bright "#3c3836")
(defvar gruvbox-fg-bright "#fbf1c7")
(defvar gruvbox-red-bright "#fb4934")
(defvar gruvbox-green-bright "#b8bb26")
(defvar gruvbox-yellow-bright "#fabd2f")
(defvar gruvbox-blue-bright "#83a598")
(defvar gruvbox-purple-bright "#d3869b")
(defvar gruvbox-aqua-bright "#8ec07c")
(defvar gruvbox-orange-bright "#fe8019")

(setq *colors*
     `(,gruvbox-bg
       ,gruvbox-red
       ,gruvbox-green
       ,gruvbox-yellow
       ,gruvbox-blue
       ,gruvbox-purple
       ,gruvbox-blue
       ,gruvbox-fg))

(when *initializing*
  (update-color-map (current-screen)))
