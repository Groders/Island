-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local tiled = require "com.ponywolf.ponytiled"

local mapData = require "assets.map_v1" -- load from lua export

-- drag the whole map for fun :o 
local dragable = require "com.ponywolf.plugins.dragable"

local widget = require("widget")


local map = tiled.new( mapData, "assets" )

map.x,map.y = display.contentCenterX - map.designedWidth/2, display.contentCenterY - map.designedHeight/2

map = dragable.new(map)

--Function to handle button events
local function handleButtonEvent(event)
    if("ended" == event.phase) then
        print("Adding new stuff")
        local fishermanLayer = map:findLayer("fisherman")

        print(fisherman)

        -- fisherman.toFront()
    end
    return true
end

local button1 = widget.newButton(
    {
        left = 100,
        top = 200,
        id = "button1",
        label = "Default",
        onEvent = handleButtonEvent,
        fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } }
    }
)

