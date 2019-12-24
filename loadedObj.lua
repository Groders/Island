-- Define module
local M = {}

function M.new( instance )

	-- Store map placement and hide placeholder
    instance.isVisible = false
    
	local parent = instance.parent
    local x, y = instance.x, instance.y
    local sheetData = { width = 16, height = 16, numFrames = 1, sheetContentWidth = 16, sheetContentHeight = 16 }
    local sequenceData = {
		{ name = "idle", frames = { 1 } },
	}

    local sheet = graphics.newImageSheet( "assets/red.png", sheetData )
	instance = display.newSprite( parent, sheet, sequenceData )

	instance.x,instance.y = x, y

end

return M