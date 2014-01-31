local BASE = (...):match("(.-)[^%.]+$")
local Level = require(BASE .. "level")
local Manager = require(BASE .. "manager")

local Scene = {}
Scene.__index = Scene

function Scene:new(xg, yg, sleep, filename)
    xg = xg or 0
    yg = yg or 0
    sleep = sleep or true

    local world = love.physics.newWorld(xg, yg, sleep)

    return setmetatable({
        manager = Manager(),
        level = Level(world, filename),
    }, self)
end

function Scene:add(o)
    return self.manager:add(o)
end

function Scene:remove(o)
    return self.manager:remove(o)
end

function Scene:load()
    self.level:load()
end

function Scene:update(dt)
    self.manager:map("update", dt)
end

function Scene:draw()
    self.level:draw()
    self.manager:map("draw")
end

function Scene:getTileset(name)
    return self.level:getTileset(name)
end

function Scene:getTilelayer(name)
    return self.level:getTilelayer(name)
end

function Scene:getObjectgroup(name)
    return self.level:getObjectgroup(name)
end

return setmetatable(Scene, { __call = Scene.new })
