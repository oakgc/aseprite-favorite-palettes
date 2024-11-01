-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
---@
------------------
local PaletteInfo = require("Scripts.Palettes.PaletteInfo")
local Tables = require("Scripts.Auxiliars.Tables")
------------------

local SetPalette = {}

function SetPalette:Load(keyTable)
    --get currentPalette to change the colors
    local currentPalette = PaletteInfo:SendInfoFromPalette()
    --get the position of the new Favorite Color in the table to be used
    local keyFavoritePalette =  Tables:ReturnIndexOFSavedPalette(SavedFavoriteTable,keyTable)
    local auxtable = SavedFavoriteTable[keyFavoritePalette]
    local positionColorChanged = 0
    local lengthTable = Tables:GetLengthTable(auxtable)-2
    --resize the current palette to size of the favorite palette
    currentPalette:resize(lengthTable)
    --loop to change all the old colors to favorite palette colors
    for index = 1 , lengthTable do
            currentPalette:setColor(positionColorChanged,tonumber(auxtable[txtColorPalette..index]))
            positionColorChanged = positionColorChanged+1
    end
end
return SetPalette