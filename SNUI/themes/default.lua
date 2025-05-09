local t = {}
t.themeVersion = 1

-- EVERYTHING
t.roundedCornersX = 0
t.roundedCornersY = 0

-- BUTTON
t.buttonColorGradient = {
    {241 / 255, 241 / 255, 241 / 255},
    {220 / 255, 220 / 255, 220 / 255}
}
t.darkenMultiplier = 0.8 -- 1 = no darkening
t.scaleClickMultiplier = 1 -- 1 = no scaleClickMultiplier
t.lightenMultiplier = 1.2
t.scaleHoverMultiplier = 1 -- 1 = no scaleHoverMultiplier
t.scaleEase = 1 -- 1 = instant
-- BUTTON>OUTLINE
t.buttonOutline = true
t.buttonInnerOutlineColor = {1, 1, 1, 0.7}
t.buttonOuterOutlineColor = {100 / 255, 100 / 255, 100 / 255}
t.buttonInnerOutlineThickness = 3
t.buttonOuterOutlineThickness = 5
-- BUTTON>TEXT
t.textColor = {85 / 255, 140 / 255, 203 / 255}
t.font = love.graphics.newFont("SNUI/themes/resources/default/Ubuntu-Regular.ttf", 24)

-- FRAME
t.frameColor = {238 / 255, 238 / 255, 238 / 255}

return t -- {buttonColorGradient,buttonOutline...}
