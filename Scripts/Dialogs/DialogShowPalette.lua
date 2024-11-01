-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global

local Tables = require("Scripts.Auxiliars.Tables")
local DialogLoadInfo = require("Scripts.Dialogs.DialogLoadInfo")

local DialogShowPalette = {}

function DialogShowPalette:Show()

    local showDialog = Dialog{title ="Favorited Palette"}
    showDialog:newrow()
    showDialog:label{
        id = "txtNoPalette",
        visible = true,
        label = "Any Palette was saved as favorite! Use the menu Save Palette as Favorite..."
    }
    if Tables:HasDataInTable(SavedFavoriteTable) == true then
        showDialog:modify{id = "txtNoPalette", visible = false}
        showDialog:separator{text= "Saved Palettes"}
        DialogLoadInfo:LoadALLFavoritePaletteInDialog(showDialog,"DialogShow")
    else
        showDialog:modify{id = "txtNoPalette", visible = true}
    end
    showDialog:show{ wait=false }
end

return DialogShowPalette