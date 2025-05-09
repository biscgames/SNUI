local theme = require("SNUI.themes.default")
local m = {}

function m.setTheme(t)
    theme = t
end
m.edittextTemplate = {}
m.edittextTemplate = {
    type = "edittext",
    focused = false,
    boolCanFocus = true,
    x = 0,
    y = 0,
    w = 180,
    h = 54,
    placeholder = "Text here...",
    text = ""
}
function m.edittextTemplate:draw()
    local colorPlaceholder = theme.edittext.placeholder.colorText or {0.5,0.5,0.5}
    local colorEdittextText = theme.edittext.text.colorText or {1,1,1}
    local colorEdittextBG = theme.edittext.colorEdittext or theme.frame.color

    local colorOuterOutline = theme.edittext.outlines.colorOuterOutline
    local thicknessOuterOutline = theme.edittext.outlines.thicknessOuterOutline

    local edittextFont = theme.edittext.allText.fontText

    love.graphics.setColor(colorOuterOutline)
    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.w,
        self.h,
        theme.affectsAll.xRoundedCorners,
        theme.affectsAll.yRoundedCorners
    )

    local xCalculated = self.x+(thicknessOuterOutline/2)
    local yCalculated = self.y+(thicknessOuterOutline/2)
    local wCalculated = self.w-thicknessOuterOutline
    local hCalculated = self.h-thicknessOuterOutline

    love.graphics.setColor(colorEdittextBG)
    love.graphics.rectangle(
        "fill",
        xCalculated,
        yCalculated,
        wCalculated,
        hCalculated,
        theme.affectsAll.xRoundedCorners,
        theme.affectsAll.yRoundedCorners
    )

    if self.text == "" then
        love.graphics.setColor(colorPlaceholder)
        love.graphics.print(
            self.placeholder,
            xCalculated+5,
            self.y+(hCalculated/2)-(edittextFont:getHeight()/2)
        )
    else
        love.graphics.setColor(colorEdittextText)
        love.graphics.print(
            self.text,
            xCalculated+5,
            self.y+(hCalculated/2)-(edittextFont:getHeight()/2)
        )
    end
end
function m.edittextTemplate:onClick(button)
    if button == 0 then
        for _,obj in ipairs(self.parent.elements) do
            obj.focused = false
        end
        self.focused = true
    end
end
function m.edittextTemplate:keypressed(key)
    if self.focused then
        local replaceKey = {
            ["space"]=" ",
            ["tab"]="",
            ["return"]="",
        }
        for k,v in pairs(replaceKey) do
            if k == key then key = v end
        end
        if key ~= "backspace" then
            self.text = self.text..key
        else
            self.text = self.text:sub(1,-2)
        end
    end
end

function m.newEdittext(t)
    local temp = {}
    for k,v in pairs(m.edittextTemplate) do
        temp[k] = v
    end
    if t then
        for k,v in pairs(t) do
            temp[k] = v
        end
    end
    return temp
end

return m