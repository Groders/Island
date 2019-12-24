-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- returns length of table
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- gets a random key from a table
function math.randomchoice(t)
    local keys = {}
    for key, value in pairs(t) do keys[#keys + 1] = key end
    return keys[math.random(1, #keys)]
end

-- hack for translating tiles from original tileset (which cause corona to bug out and display the tiles incorrectly) 
-- to the individual tileset with each tile being in its own .tsx
local function increment(o)
    for k, v in pairs(o) do
        if v["data"] == nil then return end

        for k1, v1 in pairs(v["data"]) do
            if v1 < 50 then o[k]["data"][k1] = v1 + 49 end
        end
    end
end

-- deep tostring that can be used for any object type
local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

math.randomseed(os.time())
local tiled = require "com.ponywolf.ponytiled"
local tmp = require "loadedObj"
local widget = require("widget")

local json = require("json")
local path =
    system.pathForFile("assets/Map_temp.json", system.ResourceDirectory)
local mapData = json.decodeFile(path)

-- holds player gold count
local playerGold = 0

-- array holding all the player owned houses
-- #TODO: houses??? Probably should be changed to fishing huts etc
local playerHouses = {}

-- map holding all houses not currently obtained by the player
-- #TODO: same comment as above, ie dont call houses
local availableHouses = {
    house1 = true,
    house2 = true,
    house3 = true,
    house4 = true,
    house5 = true,
    house6 = true,
    house7 = true,
    house8 = true,
    house9 = true,
    house10 = true,
    house11 = true,
    house12 = true,
    house13 = true
}

increment(mapData.layers)

local buyHouseButton
local goldText
local map

-- updates players gold count to the new provided amount, and updates UI
local function updateGold(newGold)
    playerGold = newGold
    goldText.text = "Gold: " .. playerGold
    if playerGold < math.pow(2, tablelength(playerHouses)) then
        buyHouseButton:setEnabled(false)
    else
        buyHouseButton:setEnabled(true)
    end
end

-- handles buying a house
local function buyHouse(event)
    if ("ended" == event.phase) then
        local houseToBuy = math.randomchoice(availableHouses)
        availableHouses[houseToBuy] = nil
        playerHouses[houseToBuy] = true
        local house = map:findObject(houseToBuy)
        house.isVisible = true
        function house:tap() updateGold(playerGold + 1) end
        house:addEventListener("tap")
        updateGold(playerGold - math.pow(2, tablelength(playerHouses)))
    end
end

-- create button to buy a house
buyHouseButton = widget.newButton({
    label = "button",
    emboss = false,
    onEvent = buyHouse,
    shape = "roundedRect",
    width = 100,
    height = 40,
    cornerRadius = 2,
    fillColor = {default = {1, 0, 0, 1}, over = {1, 0.1, 0.7, 0.4}},
    strokeColor = {default = {1, 0.4, 0, 1}, over = {0.8, 0.8, 1, 1}},
    strokeWidth = 4
})

buyHouseButton.x = display.contentCenterX + 200
buyHouseButton.y = display.contentCenterY

buyHouseButton:setLabel("Buy House")

map = tiled.new(mapData, "assets")

map.x, map.y = display.contentCenterX - map.designedWidth / 2,
               display.contentCenterY - map.designedHeight / 2

local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)

local goldRect = display.newRect(400, 50, 200, 100)
goldRect:setFillColor(0, 0, 0, 0)

goldText = display.newText("Gold: " .. playerGold, goldRect.x, goldRect.y,
                           native.newFont(), 30)

local sx = goldRect.contentWidth / goldText.contentWidth
local sy = goldRect.contentHeight / goldText.contentHeight
local scale = (sx < sy) and sx or sy

goldText:scale(scale, scale)

-- test seaching for objects
TestOjb = map:findObject("Test")
TestOjb:toFront()
TestOjb:rotate(20)
print(TestOjb.isVisible)

local function listener(event)
    TestOjb.isVisible = true
    print(TestOjb.isVisible)
end

timer1 = timer.performWithDelay(200, listener) -- wait 2 seconds

print(TestOjb.isVisible)

--  test adding/duplicating objects
local object = map:insertObject(TestOjb.x + 30, TestOjb.y, 'Test')
map:extendObject(object, 'loadedObj')

local house1 = map:findObject("house1")
house1.y = map:findObject("house1").y - 1
house1.isVisible = true
function house1:tap()
    print("Gold +1")
    updateGold(playerGold + 1)
end
house1:addEventListener("tap")
availableHouses["house1"] = nil
playerHouses["house1"] = true

local function listener(event) updateGold(playerGold + tablelength(playerHouses)) end

-- Starting idle counter
timer.performWithDelay(1000, listener, 0)
