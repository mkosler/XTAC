local BASE = (...) .. '.'
assert(not BASE:match('%.init%.$'), "Invalid require path '" .. (...) .. "' (drop the '.init').")

return {
    Animation = require(BASE .. "animation"),
    Core = require(BASE .. "core"),
    Entity = require(BASE .. "entity"),
    Gamestate = require(BASE .. "gamestate"),
    Level = require(BASE .. "level"),
    Manager = require(BASE .. "manager"),
    Timer = require(BASE .. "timer"),
}
