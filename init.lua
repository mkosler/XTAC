local BASE = (...) .. '.'
assert(not BASE:match('%.init%.$'), "Invalid require path '" .. (...) .. "' (drop the '.init').")

return {
    Animation = require(BASE .. "animation"),
    Entity = require(BASE .. "entity"),
    Gamestate = require(BASE .. "gamestate"),
    Level = require(BASE .. "level"),
    Timer = require(BASE .. "timer"),
}
