-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local Tables = require("Scripts.Auxiliars.Tables")

local DeletePalette = {}


function DeletePalette:Remove(tablePalette, namePalette)
        local index = Tables:ReturnIndexOFSavedPalette(tablePalette,namePalette)
        SavedFavoriteTable[index] = nil
        table.insert(DeletedNameTable,namePalette)
end

function DeletePalette:HasDeletedName(tablePalette,keyTable)
        local isPopulatedTable = Tables:HasDataInTable(tablePalette)
        if isPopulatedTable == true then
                local index = Tables:ReturnIndexOFDeletedSavedPalette(tablePalette,keyTable)
                if index ~= nil then
                        return true
                else
                        return false
                end
        else
                return false
        end
end

return DeletePalette