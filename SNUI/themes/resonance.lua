local t = {}
t.themeVersion = 1

-- EVERYTHING
t.roundedCornersX = 24
t.roundedCornersY = 24

-- BUTTON
t.buttonColorGradient = {
    {237 / 255, 237 / 255, 237 / 255}
}
t.darkenMultiplier = 1 -- 1 = no darkening
t.scaleClickMultiplier = 0.8 -- 1 = no scaleClickMultiplier
t.lightenMultiplier = 1.02
t.scaleHoverMultiplier = 1.1 -- 1 = no scaleHoverMultiplier
t.scaleEase = 15 -- 1 = instant
-- BUTTON>OUTLINE
t.buttonOutline = false
-- BUTTON>TEXT
t.textColor = {37 / 255, 37 / 255, 37 / 255}
t.font = love.graphics.newFont("SNUI/themes/resources/default/Ubuntu-Regular.ttf", 24)

-- FRAME
t.frameColor = {190 / 255, 190 / 255, 190 / 255}

return t -- {buttonColorGradient,buttonOutline...}
