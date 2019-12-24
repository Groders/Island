-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Require statements
tiled = require "com.ponywolf.ponytiled"

local mapData = require "assets.map" -- load from lua export
-- drag the whole map for fun :o 
local dragable = require "com.ponywolf.plugins.dragable"

counter = 0
startTime = 0
--Number of points you get per second
coinRate = 1
-- print("startTime:")
-- print(startTime)

-- Load an object based map from a JSON file
map = tiled.new(mapData,"assets")

-- center the map on screen
map.x,map.y = display.contentCenterX - map.designedWidth/2, display.contentCenterY - map.designedHeight/2
map = dragable.new(map)

local topLayer = map:findLayer("TopLayer")

function map:insertObject(x, y, layerName, object)
    layer = map:findLayer(layerName)
    object.x = x
    object.y = y
    layer:insert(object)
end

-- Counter for score
print(display.contentCenterX)
print(display.contentCenterY)
myText = display.newText( "0", display.contentCenterX, 20, native.systemFont, 16 )
myText:setFillColor( 1, 0, 0 )
myText.isVisible = true

-- Zoom in and out
zoomInButton = display.newRect(display.contentCenterX - 100, 50, 50, 50)
zoomInButton:setFillColor( 0.5 )
zoomOutButton = display.newRect(display.contentCenterX + 100, 50, 50, 50)
zoomOutButton:setFillColor( 1.0 )


local zoomIn = function(event)
    print("zoom in clicked")
    map.xScale = map.xScale + 0.1
    map.yScale = map.yScale + 0.1
end

local zoomOut = function(event)
    print("zoom out clicked")
    map.xScale = map.xScale - 0.1
    map.yScale = map.yScale - 0.1
end


local update = function(event)
    -- print(event.time)
    counter = coinRate * event.time/1000
    myText.text = string.format("%d %d /s", counter, coinRate)
end


Runtime:addEventListener( "enterFrame", update )
zoomInButton:addEventListener("tap", zoomIn)
zoomOutButton:addEventListener("tap", zoomOut)