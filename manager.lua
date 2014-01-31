local Manager = {}
Manager.__index = Manager

function Manager:new(objs)
    local count = 0
    for _,v in pairs(objs) do
        count = count + 1
    end

    return setmetatable({
        objects = objs or {},
        count = count,
    }, self)
end

function Manager:add(o)
    if not self.objects[o] then
        self.objects[o] = true
        count = count + 1
    else
        print("Object already managed")
    end

    return o
end

function Manager:remove(o)
    if self.objects[o] then
        self.objects[o] = nil
        count = count - 1
    else
        print("Object not managed")
    end

    return o
end

function Manager:map(f, ...)
    for o,_ in pairs(self.objects) do
        if type(f) == "string" then
            if o[f] then o[f](...) end
        elseif type(f) == "function" then
            f(o, ...)
        end
    end
end

return setmetatable(Manager, { __call = Manager.new })
