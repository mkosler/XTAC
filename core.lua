local BASE = (...):match("(.-)[^%.]+$")

local Timer = require(BASE .. "timer")

local function update(dt)
    Timer.update(dt)
end

return {
    update = update,
}
