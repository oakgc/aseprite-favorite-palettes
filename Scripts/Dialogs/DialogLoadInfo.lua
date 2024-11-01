-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

------------------
local DeletePalette = require("Scripts.Palettes.DeletePalette")
local Tables = require("Scripts.Auxiliars.Tables")
local SetPalette = require("Scripts.Palettes.SetPalette")
------------------

local DialogLoadInfo = {}
local nameDialogShow = "DialogShow"

function DialogLoadInfo:LoadFavoritePaletteInDialog(dialogPalette,keyTable,keyPosition,className)
    dialogPalette:label{
        id = "txtPositionFavorited"..keyPosition,
        text = keyTable
    }
    if keyTable ~= blankSpace then
        local shadeColors = Tables:GetColorsOfPaletteFromTable(SavedFavoriteTable,keyTable)
        dialogPalette:shades{
            id ="shadeColorPalette"..keyTable,
            colors = shadeColors,
            onclick = 
            function ()
            end
        }
        if className == nameDialogShow then
            DialogLoadInfo:ButtonSelect(dialogPalette,keyTable)
        else
            DialogLoadInfo:ButtonRemove(dialogPalette,keyTable,keyPosition)
        end
       
    else
        dialogPalette:label{
            id ="txtBlankPosition"..keyPosition,
            text = "Any palette saved in this position"
        }
    end 
    dialogPalette:separator{id = keyTable.."separator"}
end
function DialogLoadInfo:ButtonSelect(dialogPalette,keyTable)
    dialogPalette:button{
        id = "btSelect"..keyTable,
        text = "Select",
        onclick = 
        function ()
            SetPalette:Load(keyTable)
        end
    }
end

function DialogLoadInfo:ButtonRemove(dialogPalette,keyTable,keyPosition)
    dialogPalette:button{
        id = "btRemove"..keyTable,
        text = "Remove",
        onclick = 
            function ()   
                DeletePalette:Remove(SavedFavoriteTable,keyTable)
                dialogPalette:modify{id = "txtPositionFavorited"..keyPosition,visible = false,enabled = false}
                dialogPalette:modify{id = "shadeColorPalette"..keyTable,visible = false,enabled = false}    
                dialogPalette:modify{id = "btRemove"..keyTable,visible = false,enabled = false} 
                dialogPalette:modify{id = keyTable.."separator",visible = false,enabled = false} 
                app.alert("Palette "..keyTable.." was remove from favorite!")
                dialogPalette:repaint()
            end
    }
end
function DialogLoadInfo:LoadALLFavoritePaletteInDialog(dialogPalette,className)
    if Tables:HasDataInTable(SavedFavoriteTable) == true then
        local lengthSizeTable = Tables:GetLengthTable(SavedFavoriteTable)
        for indexPalette=1, lengthSizeTable do
            if SavedFavoriteTable[indexPalette..txtPalette][txtNamePalette] ~= blankSpace then
                local namePalette = SavedFavoriteTable[indexPalette..txtPalette][txtNamePalette]
                DialogLoadInfo:LoadFavoritePaletteInDialog(dialogPalette,namePalette,indexPalette,className)
            end
        end
    end
end

return DialogLoadInfo