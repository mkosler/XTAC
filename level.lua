local Level = {}
Level.__index = Level

local function loadTilesets(tilesets)
    local t = {}

    for _,tileset in ipairs(self.data.tilesets) do
        local ts = {}

        ts.image = love.graphics.newImage(tileset.image)
        ts.firstgid = tileset.firstgid
        ts.quads = {}

        local startx = tileset.imagewidth - tileset.margin - tileset.tilewidth
        local starty = tileset.imageheight - tileset.margin - tileset.tileheight
        local dx = tileset.tilewidth + tileset.spacing
        local dy = tileset.tileheight + tileset.spacing

        for y = tileset.margin, starty, dy do
            for x = tileset.margin, startx, dx do
                ts.quads[#tileset.quads + 1] = love.graphics.newQuad(x, y, tileset.tilewidth, tileset.tileheight, tileset.imagewidth, tileset.imageheight)
            end
        end

        t[#t + 1] = ts
    end

    return t
end

local function loadSpriteBatch(layer, tilesets)
    local gid = layer.data[1]
    local tileset = nil

    for i = 1, #tilesets - 1 do
        if gid < tilesets[i + 1].firstgid then
            tileset = tilesets[i]
            break
        end
    end

    local spriteBatch = love.graphics.newSpriteBatch(tileset.image, 1000, "static")

    for i,tid in ipairs(layer.data) do
        if tid > 0 then
            local x = ((i - 1) % layer.width) * tileset.tilewidth
            local y = (math.floor((i - 1) / layer.width)) * tileset.tilewidth

            spriteBatch:add(tileset.quads[tid], x, y)
        end
    end

    return spriteBatch
end

local function loadLayers(layers, tilesets)
    local tilelayers = {}
    local spriteBatches = {}
    local objectgroups = {}

    for _,layer in ipairs(self.data.layers) do
        if layer.opacity > 0 and layer.visible then
            if layer.type == "tilelayer" then
                tilelayers[#tilelayers + 1] = layer
                spriteBatches[#spriteBatches + 1] = loadSpriteBatch(layer, tilesets)
            elseif layer.type == "objectgroup" then
                objectgroups[#objectgroups + 1] = layer
            end
        end
    end

    return tilelayers, spriteBatches, objectgroups
end

function Level:new(world, filename)
    return setmetatable({
        world = world,
        filename = filename,
    }, self)
end

function Level:load()
    self.data = require(self.filepath)
end

function Level:draw()
    for _,sb in ipairs(self.spriteBatches) do
        love.graphics.draw(sb)
    end
end

return setmetatable(Level, { __call = Level.new })
