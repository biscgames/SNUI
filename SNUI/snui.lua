local btn = require("SNUI.core.button")
local edittxt = require("SNUI.core.edittext")
local frm = require("SNUI.core.frame")
local click = require("SNUI.core.clickHandler")
local theme = require("SNUI.themes.default")

local m = {}

m.MOUSE_BUTTON_LEFT = 1
m.MOUSE_BUTTON_RIGHT = 2
m.MOUSE_BUTTON_MIDDLE = 3

m.elements = {}

function m.setTheme(t)
    theme = t

    btn.setTheme(t)
    frm.setTheme(t)
end

function m.createNewFrame(t)
    table.insert(m.elements, frm.newFrame(t))
    return m.elements[#m.elements]
end

function m.createNewButton(t)
    table.insert(m.elements, btn.newButton(t))
    return m.elements[#m.elements]
end

function m.createNewEdittext(t)
    table.insert(m.elements, edittxt.newEdittext(t))
    return m.elements[#m.elements]
end

function m.mousepressed(x, y, button)
    local function onClick(e)
        if e.onClick and click.mouseIsInArea(x, y, e) then
            e.mouseclick = true
            e:onClick(button)
            return true
        end
        return false
    end
    for _, element in ipairs(m.elements) do
        if not onClick(element) and element.elements then
            for _, c in ipairs(element.elements) do
                if onClick(c) then
                    return
                end
            end
        end
    end
end

function m.onHover(x, y)
    local function onHover(e)
        if e.onHover and click.mouseIsInArea(x, y, e) and not e.mouseclick then
            e.hover = true
            e:onHover()
        else
            e.hover = false
        end
    end
    for _, element in ipairs(m.elements) do
        onHover(element)
        if element.elements then
            for _, c in ipairs(element.elements) do
                onHover(c)
            end
        end
    end
end

function m.update(dt)
    local function update(e)
        if e.onUpdate then
            e:onUpdate()
        end
        if e.type == "button" then
            if e.mouseclick and not e.hover then
                e.brightness = theme.button.brightnessModifier.numberWhenPressed
            elseif e.hover and not e.mouseclick then
                e.brightness = theme.button.brightnessModifier.numberWhenHover
            else
                e.brightness = 1
            end
        end
    end
    for _, element in ipairs(m.elements) do
        update(element)
        if element.elements then
            for _, c in ipairs(element.elements) do
                update(c)
            end
        end
    end
end

function m.mousereleased(x, y)
    local function onMouseReleased(e)
        if e.onMouseReleased and click.mouseIsInArea(x, y, e) then
            if e.brightness then
                e.brightness = 1
            end
            e.mouseclick = false
            e:onMouseReleased()
        end
    end
    for _, element in ipairs(m.elements) do
        onMouseReleased(element)
        if element.elements then
            for _, c in ipairs(element.elements) do
                onMouseReleased(c)
            end
        end
    end
end

function m.draw()
    for i, element in ipairs(m.elements) do
        if element.draw then
            element:draw()
        end
    end
end

return m
