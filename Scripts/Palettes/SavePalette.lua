-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

-------------------------
local PaletteInfo = require("Scripts.Palettes.PaletteInfo")
local MenuLoadInfo = require("Scripts.Menu.MenuLoadInfo")
local Tables = require("Scripts.Auxiliars.Tables")
local Validations = require("Scripts.Auxiliars.Validations")
-------------------------

local SavePalette = {}

function SavePalette:GetNamePalette(plugin)
    local currentPalette = PaletteInfo:SendInfoFromPalette()
    local namePaletteDialog = Dialog{title = "Save Palette"}
  
    namePaletteDialog:entry{
        id = "txtNameSavedFavoritePalette",
       label = "Name:",
        text = ""
    }
    
    namePaletteDialog:button{
        id = "bt-Cancel",
        text = "Cancel",
        onclick = function ()
            namePaletteDialog:close()
        end
    }

    namePaletteDialog:button{
        id = "bt-Save",
        text = "Save",
        onclick = function ()
            local namePalette = string.upper(namePaletteDialog.data.txtNameSavedFavoritePalette)
            local isPassedTest,errorReceived = Validations:CheckBeforeToSave(SavedFavoriteTable,DeletedNameTable,namePalette)
            if isPassedTest == true then
                local insertedPalettePosition = SavePalette:SaveColorsInTable(namePalette,currentPalette)
                MenuLoadInfo:LoadFavoritePaletteInMenu(plugin,namePalette,insertedPalettePosition)
                app.alert("Palette "..namePalette.." was saved as favorite!")
                namePaletteDialog:close()
            else
                Validations:ErrorsMessages(errorReceived)
            end
        end
    }
    namePaletteDialog:show()
end

function SavePalette:SaveColorsInTable(namePalette,colorsPallete)
    local shadeColors = PaletteInfo:GetColorsFromPalette(colorsPallete)
    local orderPosition = Tables:FindBlankOrderPosition(SavedFavoriteTable)
    local lastItem = Tables:GetLengthTable(SavedFavoriteTable)+1
    local index = lastItem..txtPalette
    
    if index ~= nil then
        SavedFavoriteTable[index]= {}
        SavedFavoriteTable[index][txtNamePalette] = namePalette
        SavedFavoriteTable[index][ORDERTOSORT] = orderPosition
        colorIndex=1
        for key= 1,#shadeColors do
            SavedFavoriteTable[index][txtColorPalette..colorIndex] = tostring(shadeColors[key])
            colorIndex = colorIndex+1
        end
    end
    return lastItem
end



return SavePalette