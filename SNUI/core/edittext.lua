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
    text = "",
    whenReturnButton = function(self)end
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
        theme.affectsAll.yRoundedCorners,
        16
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
        theme.affectsAll.yRoundedCorners,
        16
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

    if self.focused then
        local xCalculatedCursor = xCalculated
        for s in self.text:gmatch(".") do
            xCalculatedCursor = xCalculatedCursor + edittextFont:getWidth(s)
        end

        love.graphics.setColor(0,0,0)
        love.graphics.rectangle(
            "fill",
            xCalculatedCursor,
            self.y+(hCalculated/2)-(edittextFont:getHeight()/2),
            edittextFont:getWidth(self.text[#self.text] or "A")/10,
            edittextFont:getHeight()
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
            ["lshift"]="",
            ["rshift"]=""
        }
        if key == "lshift" or key == "rshift" then
            self.boolShiftKey = true
        end

        for k,v in pairs(replaceKey) do
            if k == key then key = v end
        end

        if self.boolShiftKey then
            key = require("SNUI.lib.replacedByShift")(key)
        end

        if string.lower(key) ~= "backspace" then
            self.text = self.text..key
            if key == "return" then
                self.focused = false
                self:whenReturnButton()
            end
        else
            self.text = self.text:sub(1,-2)
        end
    end
end

function m.edittextTemplate:keyreleased(key)
    if key == "lshift" or key == "rshift" then
        if self.focused then self.boolShiftKey = false end
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