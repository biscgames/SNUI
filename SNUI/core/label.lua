local theme = require("SNUI.themes.default")

table.unpack = table.unpack or unpack

local m = {}

function m.setTheme(t)
    theme = t
end

m.labelTemplate = {
    type = "label",
    x = 0,
    y = 0,
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

function m.labelTemplate:draw()
    if self.parent then
        self.literal.scale = self.literal.scale + (self.scale - self.literal.scale) / theme.scaleEase
        -- Make sure that the instance contains these keys
        local necessities = {"x", "y", "text"}
        for _, i in ipairs(necessities) do
            if self[i] == nil then -- > self[i] is nil --> error
                error(("Couldn't find \"%s\" in button"):format(i)) -- If one left out, crash with a reason
            end
        end

        local tc = {}
        for _, v in ipairs(theme.textColor) do
            table.insert(tc, v * (self.brightness or 1))
        end

        love.graphics.setColor(tc)
        love.graphics.setFont(theme.font)

        love.graphics.print(self.text,
            self.x + (((self.w) / 2) - (theme.font:getWidth(self.text) / 2)),
            self.y + (((self.h) / 2) - (theme.font:getHeight() / 2)))
    end
end

function m.newLabel(t)
    local lbl = {}
    for k, v in pairs(m.labelTemplate) do
        lbl[k] = v
    end
    if t then
        for k, v in pairs(t) do
            lbl[k] = v
        end
    end
    return lbl
end

return m
