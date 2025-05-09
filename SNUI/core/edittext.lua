local theme = require("SNUI.themes.default")
local m = {}

function m.setTheme(t)
    theme = t
end

m.edittextTemplate = {
    type = "edittext",
    focused = false,
    x = 0,
    y = 0,
    w = 180,
    h = 54,
    placeholder = "Text here...",
    text = ""
}

function m.edittextTemplate:draw()
    local colorPlaceholder = theme.colorPlaceholder or {0.5,0.5,0.5}
    local colorEdittextText = theme.colorEdittextText or {1,1,1}
    local colorEdittextBG = theme.colorEdittextBG or theme.frameColor


end