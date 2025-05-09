local theme = require("SNUI.themes.default")
local gradientMesh = require("SNUI.lib.gradient")

table.unpack = table.unpack or unpack

local m = {}

function m.setTheme(t)
    theme = t
end

local buttonGradient = gradientMesh("vertical", table.unpack(theme.buttonColorGradient))

local temp = {}
for _, v in ipairs(theme.buttonColorGradient) do
    local l = {}
    for _, e in ipairs(v) do
        table.insert(l, e * theme.darkenMultiplier)
    end
    table.insert(temp, l)
end
local buttonGradientPressed = gradientMesh("vertical", table.unpack(temp))

temp = {}
for _, v in ipairs(theme.buttonColorGradient) do
    local l = {}
    for _, e in ipairs(v) do
        table.insert(l, e * theme.lightenMultiplier)
    end
    table.insert(temp, l)
end
local buttonGradientHover = gradientMesh("vertical", table.unpack(temp))

m.buttonTemplate = {
    type = "button",
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
        self.literal.scale = self.literal.scale + (self.scale - self.literal.scale) / theme.scaleEase
        -- Make sure that the button contains these keys
        local necessities = {"x", "y", "w", "h", "text", "brightness"}
        for _, i in ipairs(necessities) do
            if self[i] == nil then -- > button[i] is nil --> error
                error(("Couldn't find \"%s\" in button"):format(i)) -- If one left out, crash with a reason
            end
        end

        local outerOutlineColor = {}
        if theme.buttonOutline then
            for _, v in ipairs(theme.buttonOuterOutlineColor) do
                table.insert(outerOutlineColor, v * self.brightness)
            end
        else
            for _, v in ipairs(theme.buttonColorGradient[1]) do
                table.insert(outerOutlineColor, v * self.brightness)
            end
        end

        love.graphics.setColor(outerOutlineColor)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, theme.roundedCornersX or 0,
            theme.roundedCornersY or 0)

        love.graphics.setColor(1, 1, 1, 1)

        local buttonAxis = {
            x = self.x + ((theme.buttonOuterOutlineThickness or 5) / 2),
            y = self.y + ((theme.buttonOuterOutlineThickness or 5) / 2)
        }

        love.graphics.stencil(function()
            local outline = (theme.buttonOuterOutlineThickness or 5)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle("fill", buttonAxis.x, buttonAxis.y, self.w - outline, self.h - outline,
                theme.roundedCornersX or 0, theme.roundedCornersY or 0)
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

        love.graphics.draw(mesh, buttonAxis.x, buttonAxis.y, 0, self.w - (theme.buttonOuterOutlineThickness or 5),
            self.h - (theme.buttonOuterOutlineThickness or 5))

        if theme.buttonOutline then
            local ioc = {}
            for _, v in ipairs(theme.buttonInnerOutlineColor) do
                table.insert(ioc, v * self.brightness)
            end
            love.graphics.setColor(ioc)
            love.graphics.setLineWidth(theme.buttonInnerOutlineThickness or 3)
            love.graphics.rectangle("line", buttonAxis.x, buttonAxis.y, self.w - theme.buttonOuterOutlineThickness,
                self.h - theme.buttonOuterOutlineThickness, theme.roundedCornersX or 0, theme.roundedCornersY or 0)
        end

        love.graphics.setStencilTest()

        local tc = {}
        for _, v in ipairs(theme.textColor) do
            table.insert(tc, v * self.brightness)
        end

        local outline = (theme.buttonOuterOutlineThickness or 5)
        love.graphics.setColor(tc)
        love.graphics.setFont(theme.font)
        if theme.font:getWidth(self.text) > self.w - outline then
            love.graphics.print(self.text:sub(1, #self.text - 5) .. "...", buttonAxis.x +
                (((self.w - outline) / 2) - (theme.font:getWidth(self.text:sub(1, #self.text - 5)) / 2)),
                buttonAxis.y + (((self.h - outline) / 2) - (theme.font:getHeight() / 2)))
        else
            love.graphics.print(self.text,
                buttonAxis.x + (((self.w - outline) / 2) - (theme.font:getWidth(self.text) / 2)),
                buttonAxis.y + (((self.h - outline) / 2) - (theme.font:getHeight() / 2)))
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
