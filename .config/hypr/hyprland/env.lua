local envs = {
	GDK_SCALE = "2",
	XCURSOR_SIZE = "24",

	HYPRCURSOR_THEME = "Bibata-Modern-Classic",
	HYPRCURSOR_SIZE = "24",

	NVD_BACKEND = "direct",
	LIBVA_DRIVER_NAME = "nvidia",
	__GLX_VENDOR_LIBRARY_NAME = "nvidia",

	ELECTRON_ENABLE_WAYLAND = "1",
	ELECTRON_OZONE_PLATFORM_HINT = "wayland",

	HYPRSHOT_DIR = "Screenshots",

	QT_QPA_PLATFORMTHEME = "gtk3",
	QT_QPA_PLATFORMTHEME_QT6 = "gtk3",
	QT_QPA_PLATFORM = "xcb",

	ANKI_WAYLAND = "1",
}

for env_name, value in pairs(envs) do
	hl.env(env_name, value)
end
