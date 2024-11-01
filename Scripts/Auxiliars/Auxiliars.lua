-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
----------------
local Tables = require("Scripts.Auxiliars.Tables")
local CastJSON = require("Scripts.Auxiliars.CastJSON")
----------------

local Auxiliars = {}
function Auxiliars:GetUserDataFromFile(plugin)
    preferences = plugin.preferences
end    
function Auxiliars:SaveUserDataInFile(plugin)
    plugin.preferences = preferences
    plugin.preferences.save()
end

function Auxiliars:SortTableBeforeToSave(tablePalette)
    local lengthTable = Tables:GetLengthTable(tablePalette)
    local auxTable = {}

    for index = 1, lengthTable do
        local searchItem = tonumber(tablePalette[index..txtPalette][ORDERTOSORT])
        if searchItem ~= nil then
            if searchItem ~= index then
                auxTable[tostring(searchItem)..txtPalette]=tablePalette[index..txtPalette]
            else
                auxTable[index..txtPalette]=tablePalette[index..txtPalette]
            end
        end    
    end
    return auxTable
end

function Auxiliars:SavePalettesToPreferences(tableFavoritePalette,tablePreferences,key)
    tableFavoritePalette = Auxiliars:SortTableBeforeToSave(tableFavoritePalette)
    local jsonFavoritePalette = json.encode(tableFavoritePalette)
    if #jsonFavoritePalette ~= 0 then
        tablePreferences[key] = jsonFavoritePalette
    end    
end

function Auxiliars:LoadFromPreferences(tablePreferences,key)
    local jsonFavoritePalette = tablePreferences[key]
    if jsonFavoritePalette == nil then
        jsonFavoritePalette = {}
    else
        jsonFavoritePalette = CastJSON:decode(jsonFavoritePalette)
        local lengthJSON = Tables:GetLengthTable(jsonFavoritePalette)
        if lengthJSON == 0 then
            jsonFavoritePalette = {}
        end
    end    
    return jsonFavoritePalette
end

return Auxiliars