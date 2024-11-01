-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local PaletteInfo = {}

function PaletteInfo:GetSprite()
    local sprite = app.sprite
   return sprite
end

function PaletteInfo:GetCurrentPalette(spriteInfo)
    if spriteInfo ~= nil then
        local spritePalette = spriteInfo.palettes[1]
        return spritePalette
    end
end

function PaletteInfo:HasSprite(spriteInfo)
    if spriteInfo == nil then
        return false
    else
        return true
    end
end

function PaletteInfo:SendInfoFromPalette()
    local lastSprite = PaletteInfo:GetSprite()
    if PaletteInfo:HasSprite(lastSprite) == true then
        local palette = PaletteInfo:GetCurrentPalette(lastSprite)
        return palette 
    end
end
function PaletteInfo:GetColorsFromPalette(favoritePalette)
    local auxTable = {}
    local key = 1
    for auxInd = 0, #favoritePalette-1 do
        local colorPalette = favoritePalette:getColor(auxInd)
        auxTable[key]=colorPalette.rgbaPixel
        key= key+1
    end
    return auxTable
end

return PaletteInfo