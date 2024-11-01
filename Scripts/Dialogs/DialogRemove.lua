-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
----------------------
local DialogLoadInfo = require("Scripts.Dialogs.DialogLoadInfo")
local Tables = require("Scripts.Auxiliars.Tables")
----------------------

local DialogRemove = {}

function DialogRemove:Show()

    local configurationDialog = Dialog{title ="Remove Favorited Palette"}
    
    configurationDialog:newrow()
    configurationDialog:label{
        id = "txtNoPalette",
        visible = true,
        label = "Any Palette was saved as favorite! Use the menu Save Palette as Favorite..."
    }
    if Tables:HasDataInTable(SavedFavoriteTable) == true then
        configurationDialog:modify{id = "txtNoPalette", visible = false}
        configurationDialog:separator{text= "Saved Palettes"}
        DialogLoadInfo:LoadALLFavoritePaletteInDialog(configurationDialog)
    else
        configurationDialog:modify{id = "txtNoPalette", visible = true}
    end
    configurationDialog:show()
end

return DialogRemove