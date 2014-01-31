local Entity = {}
Entity.__index = Entity

function Entity:new(world, x, y, width, height, name)
    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newRectangleShape(width, height)
    local fixture = love.physics.newFixture(o.body, o.shape)

    body:setFixedRotation(true)
    fixture:setUserData(name)

    return setmetatable({
        x = x,
        y = y,
        width = width,
        height = height,
        name = name,
        body = body,
        shape = shape,
        fixture = fixture,
    }, self)
end

function Entity:__tostring()
    return string.format("%s: (%0.2f, %0.2f), width = %d, height = %d", self.name, self.x, self.y, self.width, self.height)
end

return setmetatable(Entity, { __call = Entity.new })
