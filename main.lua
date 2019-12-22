-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local tiled = require "com.ponywolf.ponytiled"

local mapData = require "assets.map" -- load from lua export

local map = tiled.new( mapData, "assets" )

map.x,map.y = display.contentCenterX - map.designedWidth/2, display.contentCenterY - map.designedHeight/2

-- drag the whole map for fun :o 
local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)

