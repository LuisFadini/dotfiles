MAX_ZOOM = 3
MIN_ZOOM = 1
ZOOM_TOGGLE_FACTOR = 1.5

local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current + offset
	elseif current ~= MIN_ZOOM then
		current = MIN_ZOOM
	else
		current = ZOOM_TOGGLE_FACTOR
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

SuperBind("equal", function()
	zoom(0.25)
end, { repeating = true })
SuperBind("minus", function()
	zoom(-0.25)
end, { repeating = true })
