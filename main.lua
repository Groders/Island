-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local tiled = require "com.ponywolf.ponytiled"

local mapData = require "assets.map_v1" -- load from lua export

local map = tiled.new( mapData, "assets" )

map.x,map.y = display.contentCenterX - map.designedWidth/2, display.contentCenterY - map.designedHeight/2

-- drag the whole map for fun :o 
-- local dragable = require "com.ponywolf.plugins.dragable"
-- map = dragable.new(map)

-- local physics = require ("physics")
-- physics.start()
-- physics.addBody(mapData, "static")

local myBlueFish = display.newImage("assets/fish.png")
myBlueFish:scale (0.08, 0.08)
myBlueFish.x = 275
myBlueFish.y = 235

local fishBlop = audio.loadSound ("assets/blop.m4a")
local function onTouch(event)
    if(event.phase == "ended") then
        transition.to(myBlueFish, {x=event.x, y=event.y})
        audio.play (fishBlop)
    end
end
Runtime:addEventListener("touch", onTouch)