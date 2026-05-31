local autostart = {
	"awww-daemon",
	"hypridle",
	"eww open topbar",
	"swaync",
	"wl-paste --type text --watch cliphist store",
	"wl-paste --type image --watch cliphist store",
	"systemctl --user start hyprpolkitagent",
}

hl.on("hyprland.start", function()
	for _, app in ipairs(autostart) do
		hl.exec_cmd(app)
	end
end)
