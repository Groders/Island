-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local tiled = require "com.ponywolf.ponytiled" 
local tmp = require "loadedObj" 

local json = require("json")

local path=system.pathForFile("assets/Map_temp.json", system.ResourceDirectory )
local mapData=json.decodeFile(path)

local map = tiled.new( mapData, "assets" )

map.x,map.y = display.contentCenterX - map.designedWidth/2, display.contentCenterY - map.designedHeight/2

-- drag the whole map for fun :o 
local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)


-- test seaching for objects
TestOjb = map:findObject("Test")
TestOjb:toFront()
TestOjb:rotate(20)
print(TestOjb.isVisible)


local function listener( event )
    TestOjb.isVisible = true
    print(TestOjb.isVisible)
end


timer1 = timer.performWithDelay( 200, listener )  -- wait 2 seconds


print(TestOjb.isVisible)


--  test adding/duiplicating objects
local object = map:insertObject( TestOjb.x + 30, TestOjb.y, 'Test' )
map:extendObject(object, 'loadedObj')
