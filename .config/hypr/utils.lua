local function startswith(str, start)
	return str:sub(1, #start) == start
end

---@param key string|integer
---@param dispatcher string|function|HL.Dispatcher
---@param opts? HL.BindOptions
function Bind(key, dispatcher, opts)
	local bindDispatcher

	if type(dispatcher) == "string" then
		assert(startswith(dispatcher, "exec "))
		bindDispatcher = hl.dsp.exec_cmd(dispatcher:sub(6))
	else
		bindDispatcher = dispatcher
	end

	hl.bind(tostring(key), bindDispatcher, opts)
end

---@param key string|integer
---@param dispatcher string|function|HL.Dispatcher
---@param opts? HL.BindOptions
function SuperBind(key, dispatcher, opts)
	Bind(string.upper(MAIN_MOD) .. " + " .. key, dispatcher, opts)
end

---@param key string|integer
---@param dispatcher string|function|HL.Dispatcher
---@param opts? HL.BindOptions
function SuperModBind(key, dispatcher, opts)
	SuperBind(string.upper(SECOND_MOD) .. " + " .. key, dispatcher, opts)
end

---@param name string
---@param x0 integer
---@param y0 integer
---@param x1 integer
---@param y1 integer
function Bezier(name, x0, y0, x1, y1)
	hl.curve(name, { type = "bezier", points = { { x0, y0 }, { x1, y1 } } })
end

---@param scope string
---@param enabled boolean|integer
---@param speed integer
---@param bezier string
---@param style? string
function BAnimation(scope, enabled, speed, bezier, style)
	local animationEnabled = (enabled == true or enabled == 1)
	hl.animation({ leaf = scope, enabled = animationEnabled, speed = speed, bezier = bezier, style = style })
end
