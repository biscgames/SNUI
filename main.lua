local snui   = require("SNUI.snui")
local click  = require("SNUI.core.clickHandler")
local theme  = require("SNUI.themes.default")

-- switch to a different built-in theme (optional)
snui.setTheme(require("SNUI.themes.default"))

-- state
local count = 0

-- create a frame for controls
local controlFrame = snui.createNewFrame({
    x = 20, y = 20,
    w = 200, h = 260,
    title = "Controls"
})

-- create buttons
local incButton = snui.createNewButton({
    text = "+1"
})
local resetButton = snui.createNewButton({
    text = "Reset"
})
local edittext = snui.createNewEdittext({
    placeholder = "Enter num..."
})
local incInputButton = snui.createNewButton({
    text = "+(input)"
})

-- hook up click callbacks
function incButton:onClick(mouseBtn)
    if mouseBtn == snui.MOUSE_BUTTON_LEFT then
        count = count + 1
    end
end
function resetButton:onClick(mouseBtn)
    if mouseBtn == snui.MOUSE_BUTTON_LEFT then
        count = 0
    end
end
function incInputButton:onClick(mouseBtn)
    if mouseBtn == snui.MOUSE_BUTTON_LEFT then
        count = count + tonumber(edittext.text)
    end
end

-- add and layout buttons vertically
controlFrame:addElement(incButton)
controlFrame:addElement(resetButton)
controlFrame:addElement(edittext)
controlFrame:addElement(incInputButton)
controlFrame:arrangeChildrenY(nil, 10)

-- create a status frame that displays the count
local statusFrame = snui.createNewFrame({
    x = 240, y = 20,
    w = 200, h = 80,
    title = "Status"
})

-- use a button as a “read-only” display area (we just draw text)
local display = snui.createNewButton({
    w = 180, h = 40,
    text = "Count: 0"
})

function display:draw()
    love.graphics.setColor(0,0,0,1)
    local msg = "Count: " .. count
    local fw, fh = love.graphics.getFont():getWidth(msg), love.graphics.getFont():getHeight()
    local tx = self.x + (self.w - fw) / 2
    local ty = self.y + (self.h - fh) / 2
    love.graphics.print(msg, tx, ty)
end

statusFrame:addElement(display)
statusFrame:arrangeChildrenY(nil, 20)

function love.update(dt)
    snui.onHover(love.mouse.getPosition())
    snui.update(dt)
end

function love.mousepressed(x,y,button)
    snui.mousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
    snui.mousereleased(x,y)
end

function love.keypressed(key,scancode,isrepeat)
    snui.keypressed(key)
end

function love.draw()
    love.graphics.clear(0.1,0.1,0.1)
    snui.draw()
end