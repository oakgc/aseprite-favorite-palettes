--[[
MIT LICENSE
Copyright © 2024 Gabriel Carvalho [oakgc]

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

######################################
Author: Gabriel Carvalho
Last Update: November/2024
Release Updates:
    Version 1.0 (11/24)
        First version of the extension.
######################################
]]
-- Turn of warnings of Aseprite API methods
---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
-----------------------------
local DialogShowPalette = require("Scripts.Dialogs.DialogShowPalette")
local DialogRemove = require("Scripts.Dialogs.DialogRemove")
local SavePalette = require("Scripts.Palettes.SavePalette")
local Auxiliars = require("Scripts.Auxiliars.Auxiliars")
local MenuLoadInfo = require("Scripts.Menu.MenuLoadInfo")
local Tables = require("Scripts.Auxiliars.Tables")
-----------------------------
maxQtdFavoritePaletteMenu = 5
MAXSHADECOLORBYROW = 10
ORDERTOSORT = "order"
txtNamePalette = "name"
txtColorPalette = "color"
txtPalette = "Palette"
KEYJSON = "FavoritePalette"


ErrorTypeTable = {"OVERSIZED","DUPLICATED","DELETED","BLANK","UNSAVED"}
DeletedNameTable = {}
SavedFavoriteTable = {}

local function MenuExtension(plugin)
    plugin:newMenuGroup{
        id = "mainmenu-favorite-palettes",
        title = "Favorite Palettes",
        group = "palette_main",   
    }

    plugin:newMenuGroup{
        id = "palettes-favorite-palettes",
        title = "Palettes",
        group = "mainmenu-favorite-palettes",   
    }

    MenuLoadInfo:LoadALLFavoritePaletteInMenu(plugin)

    plugin:newMenuSeparator{
        group = "mainmenu-favorite-palettes"
    }

    plugin:newCommand{
        id = "show-favorite-palettes",
        title = "Show Favorited",
        group = "mainmenu-favorite-palettes",
        onclick = 
        function ()
            DialogShowPalette:Show()
        end
    }
    plugin:newCommand{
        id = "remove-favorite-palettes",
        title = "Remove Favorited",
        group = "mainmenu-favorite-palettes",
        onclick = 
        function ()
            DialogRemove:Show()
        end
    }
   
    plugin:newCommand{
        id = "save-favorite-palettes",
        title = "Save Palette as Favorite",
        group = "palette_files",
        onclick = 
        function ()
        SavePalette:GetNamePalette(plugin)
        end
    }
end
--Initialize the extension as a menu in the Aseprite
function init(plugin)
    Auxiliars:GetUserDataFromFile(plugin)
    SavedFavoriteTable = Auxiliars:LoadFromPreferences(preferences,KEYJSON)
    MenuExtension(plugin)
end

function exit(plugin)
   Auxiliars:SavePalettesToPreferences(SavedFavoriteTable,preferences,KEYJSON)
   Auxiliars:SaveUserDataInFile(plugin)
end

