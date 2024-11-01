-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local Tables = {}

function Tables:FindNamePalette(tablePalette, namePalette)
    for index in pairs(tablePalette) do
        local searchItem = tablePalette[index][txtNamePalette]
        if searchItem == namePalette then
            return true
        end
    end
    return false
end

function Tables:FindBlankOrderPosition(tablePalette)
    local lengthTable = Tables:GetLengthTable(tablePalette)
    local  orderPosition = lengthTable +1

    for index = 1, lengthTable do
        if tablePalette[index..txtPalette] == nil then
            tablePalette[index..txtPalette] = {}
        end
        local searchItem = tonumber(tablePalette[index..txtPalette][ORDERTOSORT])
        if searchItem ~= index then
            orderPosition = index
            return orderPosition
        end
    end

    return orderPosition
end

function Tables:ReturnIndexOFSavedPalette(tablePalette,keyTable)
    local lengthTable =Tables:GetLengthTable(tablePalette)
    for index = 1 ,lengthTable do
        if tablePalette[index..txtPalette] == nil then
            tablePalette[index..txtPalette] = {}
        end
        local searchName = tablePalette[index..txtPalette][txtNamePalette]
        if searchName == keyTable then
            local indexCompleted = index..txtPalette
            return indexCompleted,index
        end 
    end
end

function Tables:ReturnIndexOFDeletedSavedPalette(tablePalette,keyTable)
    for index,value in ipairs(tablePalette) do
        if value == keyTable then
            return index
        end 
    end
end

function Tables:HasDataInTable(tablePalette)
    local lengthTable = Tables:GetLengthTable(tablePalette)
    if tablePalette == nil or lengthTable == 0 then
        return false
    else
        return true
    end
end

function Tables:GetLengthTable(tablePalette)
    local lengthTable = 0
    for index in pairs(tablePalette) do
        lengthTable = lengthTable+1
    end
    return lengthTable
end

function Tables:GetColorsOfPaletteFromTable(tablePalette,key)
    local shadeTable = {}
    local index = Tables:ReturnIndexOFSavedPalette(tablePalette,key)
    if index ~= nil then
        local lengthTable = Tables:GetLengthTable(tablePalette[index])-2

        if lengthTable > MAXSHADECOLORBYROW then
            lengthTable = MAXSHADECOLORBYROW
        end

        for colorPosition = 1,lengthTable do
            shadeTable[txtColorPalette..colorPosition] = Color(tonumber(tablePalette[index][txtColorPalette..colorPosition]))
        end
    end    
    return shadeTable
end

function Tables:CheckQuantityOfSavedPalette(tablePalette)
    local qtdPaletteInTable = Tables:GetLengthTable(tablePalette)
    if qtdPaletteInTable >= maxQtdFavoritePaletteMenu then
        return false
    else
        return true
    end
end
return Tables
