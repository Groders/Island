local widget = require("widget")

local M = {}

function M.new(options)
    group = group or display.currentStage
    params = params or {}

    local panel = {}
    function panel:showDialogTray(playerHouses, score)
        local width = 600
        local height = 400

        local function onClose(self, onComplete)
            transition.to(self, {
                y = centerY + fullh,
                transition = easing.inBack,
                onComplete = onComplete
            })
        end

        local dialog = ssk.dialogs.basic.create(group, centerX, centerY + 125, {
            fill = hexcolor("#56A5EC"),
            width = width,
            height = height,
            softShadow = true,
            softShadowOX = 8,
            softShadowOY = 8,
            softShadowBlur = 6,
            closeOnTouchBlocker = false,
            blockerFill = _K_,
            blockerAlpha = 0.55,
            softShadowAlpha = 0.6,
            blockerAlphaTime = 100,
            onClose = onClose,
            style = "1"
        })

        local function closeTray(event)
            onClose(dialog, function() dialog.frame:close() end)
        end

        ssk.easyIFC:presetPush(dialog, "default", 0, -160, 280, 50, "Close",
                               closeTray)

        ssk.easyIFC.easyFlyIn(dialog,
                              {delay = 250, time = 500, sox = 0, soy = fullh})

        local vc = ssk.vScroller.new(dialog, 0, -30, {
            w = dialog.contentWidth - 50,
            h = dialog.height / 2
        })

        local i = 1
        for k, v in pairs(playerHouses) do
            print(k, v)
            vc:insertContent(display.newRect(0, 0, dialog.width * 2, 40),
                             {x = 0, y = i * 45})

            local textOptions = {
                x = 0,
                y = 0,
                text = "Level: " .. v.level,
                width = 200,
                font = "assets/GermaniaOne-Regular.ttf",
                fontSize = 22,
                align = "left"
            }

            local level = display.newEmbossedText(textOptions)
            level:setFillColor(unpack({0, 0, 0, 1}))

            -- #TODO:
            local function upgradeHouse(event)
                if ("ended" == event.phase) then
                    score:add(-v.level)
                    v.level = v.level + 1
                    level.text = "Level: " .. v.level
                end
            end

            local button1 = widget.newButton(
                                {
                    width = 24,
                    height = 24,
                    defaultFile = "assets/plus.png",
                    overFile = "assets/plus.png",
                    onEvent = upgradeHouse
                })

            vc:insertContent(button1, {x = dialog.width - 100, y = i * 45})
            vc:insertContent(level, {x = textOptions.width / 2 + 10, y = i * 45})
            i = i + 1
        end

    end
    return panel

end

return M
