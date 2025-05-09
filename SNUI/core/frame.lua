local theme = require("SNUI.themes.default")
local btn = require("SNUI.core.button")

local m = {}

function m.setTheme(t)
    theme = t
end

m.frameTemplate = {
    type = "frame",
    x = 0,
    y = 0,
    w = 300,
    h = 150,
    visible = true,

    elements = {},

    addElement = function(self, obj)
        table.insert(self.elements, obj)
        obj.parent = self
        obj.prev = {}

        obj.prev.x = obj.x
        obj.prev.y = obj.y

        obj.x = self.x + obj.x
        obj.y = self.y + obj.y

        return obj
    end,
    removeElement = function(self, idx)
        local obj = self.elements[idx]
        table.remove(self.elements, idx)
        obj.parent = nil

        obj.x = obj.prev.x
        obj.y = obj.prev.y

        obj.prev = nil
    end,
    createButton = function(self, t)
        return self:addElement(btn.newButton(t))
    end,
    arrangeChildrenY = function(self, by, padding)
        by      = by      or 0
        padding = padding or 0
        local n = #self.elements
        if n == 0 then return end

        -- 1) compute total height
        local totalH = padding * (n - 1)
        for _, obj in ipairs(self.elements) do
            totalH = totalH + ((by > 0) and by or obj.h)
        end

        -- 2) find the starting Y so the block is centered
        local startY = self.y + (self.h - totalH) / 2

        -- 3) place each child
        for _, obj in ipairs(self.elements) do
            local stepH = (by > 0) and by or obj.h

            -- center in X
            obj.x = self.x + (self.w - obj.w) / 2

            -- set Y and bump
            obj.y = startY
            startY = startY + stepH + padding
        end
    end,
    arrangeChildrenX = function(self, by, padding)
        by      = by      or 0
        padding = padding or 0
        local n = #self.elements
        if n == 0 then return end

        -- 1) compute total width
        local totalW = padding * (n - 1)
        for _, obj in ipairs(self.elements) do
            totalW = totalW + ((by > 0) and by or obj.w)
        end

        -- 2) find starting X so the block is centered
        local startX = self.x + (self.w - totalW) / 2

        -- 3) place each child
        for _, obj in ipairs(self.elements) do
            local stepW = (by > 0) and by or obj.w

            -- center in Y
            obj.y = self.y + (self.h - obj.h) / 2

            -- set X and bump
            obj.x = startX
            startX = startX + stepW + padding
        end
    end
}
function m.frameTemplate:draw()
    local necessities = {"x", "y", "w", "h", "elements", "visible"}
    for _, i in ipairs(necessities) do
        if self[i] == nil then -- > frame[i] is nil --> error
            error(("Couldn't find \"%s\" in frame"):format(i)) -- If one left out, crash with a reason
        end
    end

    if self.visible then
        love.graphics.setColor(theme.frame.color)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, theme.affectsAll.xRoundedCorners or 0,theme.affectsAll.yRoundedCorners or 0)
        for i, element in ipairs(self.elements) do
            if element.draw then
                element:draw()
            else
                print(("SNUI WARNING: element %d is missing the draw function!"):format(i))
            end
        end
    end
end

function m.newFrame(t)
    local frm = {}
    t = t or {}
    for k, v in pairs(m.frameTemplate) do
        if type(v) == "table" then
            if k == "elements" then
                frm[k] = {}
            else
                frm[k] = v[1]
            end
        else
            frm[k] = v
        end
    end
    for k, v in pairs(t) do
        frm[k] = v
    end
    return frm
end

return m
