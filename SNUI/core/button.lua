local theme = require("SNUI.themes.default")
local gradientMesh = require("SNUI.lib.gradient")

table.unpack = table.unpack or unpack

local m = {}

local buttonGradient = gradientMesh("vertical", table.unpack(theme.button.colorButton))
local buttonGradientHover
local buttonGradientPressed

function m.setTheme(t)
    theme = t
    buttonGradient = gradientMesh("vertical", table.unpack(theme.button.colorButton))
    m.buttonColorUpdate()
end


function m.buttonColorUpdate()
    local temp = {}
    for _, v in ipairs(theme.button.colorButton) do
        local l = {}
        for _, e in ipairs(v) do
            table.insert(l, e * theme.button.brightnessModifier.numberWhenPressed)
        end
        table.insert(temp, l)
    end
    buttonGradientPressed = gradientMesh("vertical", table.unpack(temp))

    temp = {}
    for _, v in ipairs(theme.button.colorButton) do
        local l = {}
        for _, e in ipairs(v) do
            table.insert(l, e * theme.button.brightnessModifier.numberWhenHover)
        end
        table.insert(temp, l)
    end
    buttonGradientHover = gradientMesh("vertical", table.unpack(temp))
end

m.buttonColorUpdate()

m.buttonTemplate = {
    type = "button",
    focused = false,
    boolCanFocus = false,
    x = 0,
    y = 0,
    w = 180,
    h = 54,
    brightness = 1,
    literal = {
        scale = 1
    },
    scale = 1,

    mouseclick = false,
    hover = false,

    onClick = function(self, mousebtn)
    end,
    onHover = function(self)
    end,
    onMouseReleased = function(self)
    end,
    onUpdate = function(self)
    end
}

function m.buttonTemplate:draw()
    if self.parent then
        self.literal.scale = self.literal.scale + (self.scale - self.literal.scale) / theme.button.scaleModifier.lerping.easeSpeed
        -- Make sure that the button contains these keys
        local necessities = {"x", "y", "w", "h", "text", "brightness"}
        for _, i in ipairs(necessities) do
            if self[i] == nil then -- > button[i] is nil --> error
                error(("Couldn't find \"%s\" in button"):format(i)) -- If one left out, crash with a reason
            end
        end

        local outerOutlineColor = {}
        if theme.button.outlines.boolOutlines then
            for _, v in ipairs(theme.button.outlines.colorOuterOutline) do
                table.insert(outerOutlineColor, v * self.brightness)
            end
        else
            for _, v in ipairs(theme.button.colorButton[1]) do
                table.insert(outerOutlineColor, v * self.brightness)
            end
        end

        love.graphics.setColor(outerOutlineColor)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, theme.affectsAll.xRoundedCorners or 0, theme.affectsAll.yRoundedCorners or 0)

        love.graphics.setColor(1, 1, 1, 1)

        local buttonAxis = {
            x = self.x + ((theme.button.outlines.thicknessOuterOutline or 5) / 2),
            y = self.y + ((theme.button.outlines.thicknessOuterOutline or 5) / 2)
        }

        love.graphics.stencil(function()
            local outline = (theme.button.outlines.thicknessOuterOutline or 5)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("fill", buttonAxis.x, buttonAxis.y, self.w - outline, self.h - outline,
                theme.affectsAll.xRoundedCorners or 0, theme.affectsAll.yRoundedCorners or 0)
        end, "replace", 1)

        love.graphics.setStencilTest("greater", 0)

        local mesh
        if not self.mouseclick and not self.hover then
            mesh = buttonGradient
        elseif self.mouseclick and not self.hover then
            mesh = buttonGradientPressed
        elseif self.hover and not self.mouseclick then
            mesh = buttonGradientHover
        end

        love.graphics.draw(mesh, buttonAxis.x, buttonAxis.y, 0, self.w - (theme.button.outlines.thicknessOuterOutline or 5),
            self.h - (theme.button.outlines.thicknessOuterOutline or 5))

        if theme.buttonOutline then
            local ioc = {}
            for _, v in ipairs(theme.button.outlines.colorInnerOutline) do
                table.insert(ioc, v * self.brightness)
            end
            love.graphics.setColor(ioc)
            love.graphics.setLineWidth(theme.button.outlines.thicknessInnerOutline or 3)
            love.graphics.rectangle("line", buttonAxis.x, buttonAxis.y, self.w - theme.button.outlines.thicknessOuterOutline,
                self.h - theme.buttonOuterOutlineThickness, theme.affectsAll.xRoundedCorners or 0, theme.affectsAll.yRoundedCorners or 0)
        end

        love.graphics.setStencilTest()

        local tc = {}
        for _, v in ipairs(theme.button.text.colorText) do
            table.insert(tc, v * self.brightness)
        end

        local outline = (theme.button.outlines.thicknessOuterOutline or 5)
        love.graphics.setColor(tc)
        love.graphics.setFont(theme.button.text.fontText)
        if theme.button.text.fontText:getWidth(self.text) > self.w - outline then
            love.graphics.print(self.text:sub(1, #self.text - 5) .. "...", buttonAxis.x +
                (((self.w - outline) / 2) - (theme.button.text.fontText:getWidth(self.text:sub(1, #self.text - 5)) / 2)),
                buttonAxis.y + (((self.h - outline) / 2) - (theme.button.text.fontText:getHeight() / 2)))
        else
            love.graphics.print(self.text,
                buttonAxis.x + (((self.w - outline) / 2) - (theme.button.text.fontText:getWidth(self.text) / 2)),
                buttonAxis.y + (((self.h - outline) / 2) - (theme.button.text.fontText:getHeight() / 2)))
        end
    end
end

function m.newButton(t)
    local btn = {}
    for k, v in pairs(m.buttonTemplate) do
        btn[k] = v
    end
    if t then
        for k, v in pairs(t) do
            btn[k] = v
        end
    end
    return btn
end

return m
