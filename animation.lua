local Animation = {}
Animation.__index = Animation

Animation.Modes = {
    LOOP = 1,
    BOUNCE = 2,
}

function Animation:new(image, delay, mode)
    return setmetatable({
        image = image,
        frames = {},
        index = 0,
        totalFrames = 0,
        delay = delay,
        mode = mode or Animation.Modes.LOOP,
        bounce = false,
        flip = false,
        handle = nil,
    }, self)
end

function Animation:reset()
    self.index = 0
    self.bounce = false
    self.handle = nil
end

function Animation:addFrame(x, y, width, height, index)
    index = index or self.index

    self.frames[index] = love.graphics.newQuad(x, y, width, height, self.image:getWidth(), self.image:getHeight())

    self.index = self.index + 1
    self.totalFrames = self.index
end

function Animation:play()
    self:reset()

    if self.mode == Animation.Modes.LOOP then
        self.handle = Timer.addPeriodic(self.delay, function () self.index = (self.index + 1) % self.totalFrames end)
    elseif self.mode == Animation.Modes.BOUNCE then
        self.handle = Timer.addPeriodic(self.delay, function ()
            if self.index == self.totalFrames - 1 or self.index == 0 then
                self.bounce = not self.bounce
            end

            self.index = (self.index + (self.bounce and 1 or -1)) % self.totalFrames
        end)
    end
end

function Animation:stop()
    if self.handle then
        Timer.cancel(self.handle)
    end
end

function Animation:draw()
    local sx = self.flip and -1 or 1
    local _,_,w,_ = self.frames[self.index]:getViewport()
    local ox = self.flip and w or 0

    love.graphics.draw(self.image, self.frames[self.index], x, y, 0, sx, 1, ox)
end

return setmetatable(Animation, { __call = Animation.new })
