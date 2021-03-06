#### COLOUR

tm_color_active=cyan
tm_color_inactive=colour241
tm_color_feature=colour206
tm_color_music=colour215
tm_active_border_color=colour240

# separators
tm_separator_left_bold="◀"
tm_separator_left_thin="❮"
tm_separator_right_bold="▶"
tm_separator_right_thin="❯"

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusbar colors
# set-option -g status-bg colour0
set-option -g status-fg $tm_color_active
set-option -g status-bg default
set-option -g status-style default

# default window title colors
set-window-option -g window-style-fg $tm_color_inactive
set-window-option -g window-style-bg default
set -g window-style-format "#I #W"

# active window title colors
set-window-option -g window-style-current-fg $tm_color_active
set-window-option -g window-style-current-bg default
set-window-option -g  window-style-current-format "#[bold]#I #W#F#{?pane_synchronized,#[fg=red]#[italics]SYNCHRONIZED#[default],}"

# pane border
set-option -g pane-border-style-fg $tm_color_inactive
set-option -g pane-active-border-style-fg $tm_active_border_color

# message text
set-option -g message-bg default
set-option -g message-fg $tm_color_active

# pane number display
set-option -g display-panes-active-colour $tm_color_active
set-option -g display-panes-colour $tm_color_inactive

# clock
set-window-option -g clock-mode-colour $tm_color_active

# tm_tunes="#[fg=$tm_color_music]#(osascript ~/.dotfiles/applescripts/tunes.scpt | cut -c 1-50)"
tm_tunes="#[fg=$tm_color_music]♫ #(osascript -l JavaScript ~/.dotfiles/applescripts/tunes.js)"
tm_battery="#(~/.dotfiles/bin/battery_indicator.sh)"

tm_date="#[fg=$tm_color_inactive] %R %d %b"
tm_host="#[fg=$tm_color_feature,bold]#h"
tm_session_name="#[fg=$tm_color_feature,bold]#S"

set -g status-left $tm_session_name' '
set -g status-right $tm_tunes' '$tm_date' '$tm_battery' '$tm_host
