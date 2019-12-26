-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
require "ssk2.loadSSK"
_G.ssk.init({debugLevel = 2})

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

math.randomseed(os.time())

io.output():setvbuf("no") -- Don't use buffer for console messages
display.setStatusBar(display.HiddenStatusBar) -- Hide that pesky bar
local scoring = require "score"
local tiled = require "com.ponywolf.ponytiled"
local fx = require "com.ponywolf.ponyfx"
local tmp = require "loadedObj"
local widget = require("widget")
local upgradePane = (require "upgradePane").new()

local json = require("json")
local path =
    system.pathForFile("assets/Map_temp.json", system.ResourceDirectory)
local mapData = json.decodeFile(path)

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

-- hack, see method comment
increment(mapData.layers)

local buyHouseButton
local score
local map

-- updates players gold count to the new provided amount, and updates UI
local function updateGold(increment)
    score:add(increment)
    -- print("Increment:", increment, "Gold count:", score:get())
    if score:get() < math.pow(2, tablelength(playerHouses)) then
        buyHouseButton:disable(0.5)
    else
        buyHouseButton:enable()
    end
end

-- handles buying a house
local function buyHouse(event)
    if ("ended" == event.phase) then
        local houseToBuy = math.randomchoice(availableHouses)
        availableHouses[houseToBuy] = nil
        playerHouses[houseToBuy] = {level = 1}
        local house = map:findObject(houseToBuy)
        house.isVisible = true
        fx.breath(house, 0.10, 750)
        function house:tap() updateGold(1) end
        house:addEventListener("tap")
        updateGold(-math.pow(2, tablelength(playerHouses) - 1))
    end
end

-- create button to buy a house
buyHouseButton = ssk.easyIFC:presetPush(group, "default",
                                        display.contentCenterX + 200,
                                        display.contentCenterY, 100, 40,
                                        "Buy House", buyHouse)

map = tiled.new(mapData, "assets")

map.x, map.y = display.contentCenterX - map.designedWidth / 2,
               display.contentCenterY - map.designedHeight / 2

local dragable = require "com.ponywolf.plugins.dragable"
map = dragable.new(map)

-- Add our scoring module
local gem = display.newImageRect("assets/gem.png", 64, 64)
gem.x = display.contentWidth - gem.contentWidth / 2 - 24
gem.y = display.screenOriginY + gem.contentHeight / 2 + 20

score = scoring.new({score = 20})
score.x = display.contentWidth - score.contentWidth / 2 - 32 - gem.width
score.y = display.screenOriginY + score.contentHeight / 2 + 16

local house1 = map:findObject("house1")
house1.y = map:findObject("house1").y - 1
house1.isVisible = true
fx.breath(house1, 0.10, 750)
function house1:tap() updateGold(1) end
house1:addEventListener("tap")
availableHouses["house1"] = nil
playerHouses["house1"] = {level = 1}

local function listener(event) updateGold(tablelength(playerHouses)) end

-- Starting idle counter
timer.performWithDelay(1000, listener, 0)

local function displayUpgrades(event)
    upgradePane:showDialogTray(playerHouses, score)
end

ssk.easyIFC:presetPush(group, "default", display.contentCenterX + 200,
                       display.contentCenterY + 60, 120, 40, "Upgrade Houses",
                       displayUpgrades)

-- #TODO: put progress bar on top of houses
-- local progressView = widget.newProgressView(
--                      {left = 50, top = 200, width = 220, isAnimated = true})
-- progressView:setProgress(0.5)
