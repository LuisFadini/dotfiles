Bind("XF86AudioRaiseVolume", "exec pactl -- set-sink-volume @DEFAULT_SINK@ +5%")
Bind("XF86AudioLowerVolume", "exec pactl -- set-sink-volume @DEFAULT_SINK@ -5%")
Bind("XF86AudioMute", "exec pactl -- set-sink-mute @DEFAULT_SINK@ toggle")
Bind("XF86AudioMicMute", "exec pactl -- set-source-mute 0 toggle")

Bind("XF86MonBrightnessUp", "exec brightnessctl s 10%+", { repeating = true, locked = true })
Bind("XF86MonBrightnessDown", "exec brightnessctl s 10%-", { repeating = true, locked = true })

Bind("XF86AudioNext", "exec playerctl next", { locked = true })
Bind("XF86AudioPause", "exec playerctl play-pause", { locked = true })
Bind("XF86AudioPlay", "exec playerctl play-pause", { locked = true })
Bind("XF86AudioPrev", "exec playerctl previous", { locked = true })
