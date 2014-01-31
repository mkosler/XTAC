local BASE = (...):match("(.-)[^%.]+$")
local Core = require(BASE .. "core")

local Entity = {}
Entity.__index = Entity

function Entity:new(x, y, width, height, bodyType)
    local world = Core.getWorld()

    local body = love.physics.newBody(world, x, y, bodyType)
    local shape = love.physics.newRectangleShape(width, height)
    local fixture = love.physics.newFixture(o.body, o.shape)

    return Core.getEntityManager():add(setmetatable({
        x = x,
        y = y,
        width = width,
        height = height,
        body = body,
        shape = shape,
        fixture = fixture,
    }, self))
end

function Entity:destroy()
    self.body:destroy()
    Core.getEntityManager():remove(self)
end

function Entity:getCategory()
    return self.fixture:getCategory()
end

function Entity:setCategory(...)
    self.fixture:setCategory(...)
end

function Entity:getMask()
    return self.fixture:getMask()
end

function Entity:setMask(...)
    self.fixture:setMask(...)
end

function Entity:__tostring()
    return string.format("%s: (%0.2f, %0.2f), width = %d, height = %d", self.name, self.x, self.y, self.width, self.height)
end

return setmetatable(Entity, { __call = Entity.new })
