-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local Tables = require("Scripts.Auxiliars.Tables")
local DeletePalette = require("Scripts.Palettes.DeletePalette")

local Validations = {}

function Validations:CheckBeforeToSave(tablePalette,tableDeleted,namePalette)
    
    --Validation of Size Table
    local isRightSizeOfPalette = Tables:CheckQuantityOfSavedPalette(tablePalette)
    if isRightSizeOfPalette == false then
        return false,ErrorTypeTable[1]
    end
    --Validation of deleted palette
    local isDeletedName = DeletePalette:HasDeletedName(tableDeleted,namePalette)
    if isDeletedName == true then 
        return false,ErrorTypeTable[3]
    end

    --Validation of duplicated palette
    local isDuplicatedName = Tables:FindNamePalette(tablePalette,namePalette)
    if  isDuplicatedName == true then
        return false,ErrorTypeTable[2]
    end

    --validation of blank name
    if namePalette == "" then
        return false,ErrorTypeTable[4]
    end

    return true
end

function Validations:CheckBeforeToSet(tablePalette,tableDeleted,namePalette)
    
    --Validation of deleted palette
    local isDeleted = DeletePalette:HasDeletedName(tableDeleted,namePalette)
    if isDeleted == true then 
        return false,ErrorTypeTable[3]
    end

    --Validation of duplicated palette
    local existPalette = Tables:FindNamePalette(tablePalette,namePalette)
    if  existPalette == false then
        return false,ErrorTypeTable[5]
    end

    return true
end

function Validations:ErrorsMessages(errorReceived)

    if errorReceived == ErrorTypeTable[1] then
        app.alert("It's only possible to favorite"..maxQtdFavoritePaletteMenu.." palettes! Please delete some palette to add new one")
    end

    if errorReceived == ErrorTypeTable[2] then
        app.alert("Name duplicated!Please insert other name...")
    end

    if errorReceived == ErrorTypeTable[3] then
        app.alert("This palette was deleted! Restart the Aseprite to reuse this.")
    end

    if errorReceived == ErrorTypeTable[4] then
        app.alert("The palette name is empty!Please insert a name before to save")
    end

    if errorReceived == ErrorTypeTable[5] then
        app.alert("There is not any palette saved in this shorcut!")
    end
    
end
return Validations