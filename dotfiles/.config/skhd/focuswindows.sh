#!/bin/dash
$(yabai -m space --create)
index="$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index')"
$(yabai -m window --space ${index})
$(yabai -m space --focus "≈${index}")
