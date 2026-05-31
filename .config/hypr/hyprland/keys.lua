-- Window management
require("hyprland.keys.workspace")
-- stylua: ignore start
local directions = {
	H = "l",   left  = "l",
	J = "d",   down  = "d",
	K = "u",   up    = "u",
	L = "r",   right = "r",
}
-- stylua: ignore end

for key, dir in pairs(directions) do
	SuperBind(key, hl.dsp.focus({ direction = dir }))
	SuperModBind(key, hl.dsp.window.move({ direction = dir }))
end

SuperBind("tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

SuperBind("F11", hl.dsp.window.fullscreen())
SuperBind("F", hl.dsp.window.float({ action = "toggle" }))
SuperBind("P", hl.dsp.window.pseudo())

SuperBind("mouse:272", hl.dsp.window.drag(), { mouse = true })
SuperBind("mouse:273", hl.dsp.window.resize(), { mouse = true })

SuperBind("C", hl.dsp.window.close())

-- Apps
SuperBind("Q", "exec " .. TERMINAL)
SuperBind("E", "exec " .. FILE_MANAGER)
SuperBind("R", "exec " .. BROWSER)

SuperBind("space", "exec rofi -show drun")
SuperBind("escape", "exec ~/dotfiles/scripts/powermenu")
SuperBind("W", "exec ~/dotfiles/scripts/rofi-wallpapers")

-- Screenshot
SuperBind("PRINT", "exec hyprshot -m window")
Bind("PRINT", "exec hyprshot -m output")
SuperModBind("PRINT", "exec hyprshot -m region")

-- Other utility keys
require("hyprland.keys.multimedia")
require("hyprland.keys.zoom")
