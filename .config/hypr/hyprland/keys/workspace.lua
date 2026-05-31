for i = 1, 10 do
	local key = i % 10
	SuperBind(key, hl.dsp.focus({ workspace = i }))
	SuperModBind(key, hl.dsp.window.move({ workspace = i }))
end

SuperBind("S", hl.dsp.workspace.toggle_special())
SuperModBind("S", hl.dsp.window.move({ workspace = "special" }))
