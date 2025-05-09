local snui   = require("SNUI.snui")
local click  = require("SNUI.core.clickHandler")
local theme  = require("SNUI.themes.default")

-- switch to a different built-in theme (optional)
snui.setTheme(require("SNUI.themes.resonance"))

-- state
local count = 0

-- create a frame for controls
local controlFrame = snui.createNewFrame({
    x = 20, y = 20,
    w = 200, h = 200,
    title = "Controls"
})

-- create a status frame that displays the count
local statusFrame = snui.createNewFrame({
    x = 240, y = 20,
    w = 200, h = 80,
    title = "Status"
})

local display = snui.createNewLabel({
    w = 180, h = 40,
    text = "Count: 0"
})

local function updateDisplay()
    display.text = "Count: " .. count
end

statusFrame:addElement(display)
statusFrame:arrangeChildrenY(nil, 20)

-- create buttons
local incButton = snui.createNewButton({
    text = "+1"
})
local mulButton = snui.createNewButton({
    text = "*2"
})
local resetButton = snui.createNewButton({
    text = "Reset"
})

-- hook up click callbacks
function incButton:onClick(mouseBtn)
    if mouseBtn ~= snui.MOUSE_BUTTON_LEFT then return end
    
    count = count + 1
    updateDisplay()
end
function mulButton:onClick(mouseBtn)
    if mouseBtn ~= snui.MOUSE_BUTTON_LEFT then return end
    
    count = count * 2
    updateDisplay()
end
function resetButton:onClick(mouseBtn)
    if mouseBtn ~= snui.MOUSE_BUTTON_LEFT then return end
    
    count = 0
    updateDisplay()
end

-- add and layout buttons vertically
controlFrame:addElement(incButton)
controlFrame:addElement(mulButton)
controlFrame:addElement(resetButton)
controlFrame:arrangeChildrenY(nil, 10)


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

function love.draw()
    love.graphics.clear(0.1,0.1,0.1)
    snui.draw()
end
