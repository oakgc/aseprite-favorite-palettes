-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
------------------
local SetPalette = require("Scripts.Palettes.SetPalette")
local Tables = require("Scripts.Auxiliars.Tables")
local DeletePalette = require("Scripts.Palettes.DeletePalette")
local Validations = require("Scripts.Auxiliars.Validations")
------------------

local MenuLoadInfo = {}

function MenuLoadInfo:LoadFavoritePaletteInMenu(plugin,name,indexMenu)
    plugin:newCommand{
        id = indexMenu.."-favorite-palettes",
        title = name,
        group = "palettes-favorite-palettes",
        onclick = 
            function ()
                 --Validation of deleted palette
                local isPassed,errorReceived = Validations:CheckBeforeToSet(SavedFavoriteTable,DeletedNameTable,name)
                if isPassed == true then
                    SetPalette:Load(name)
                else
                    Validations:ErrorsMessages(errorReceived)
                end
            end,
        onenabled = 
            function ()
                local isDeleted = DeletePalette:HasDeletedName(DeletedNameTable,name)
                if isDeleted == true then
                    return false
                else
                    return true
                end        
            end    
    }
end

function MenuLoadInfo:LoadALLFavoritePaletteInMenu(plugin)
    if Tables:HasDataInTable(SavedFavoriteTable) == true then
        local lengthSize = Tables:GetLengthTable(SavedFavoriteTable)
        for index = 1 , lengthSize do
            if SavedFavoriteTable[index..txtPalette][txtNamePalette] ~= blankSpace then
                local namePalette = SavedFavoriteTable[index..txtPalette][txtNamePalette]
                MenuLoadInfo:LoadFavoritePaletteInMenu(plugin,namePalette,index)
            end    
        end
    end
end

return MenuLoadInfo