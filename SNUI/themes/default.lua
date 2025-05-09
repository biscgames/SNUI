local t = {}
t.themeVersion = 2

t.affectsAll = {
    xRoundedCorners = 0,
    yRoundedCorners = 0
}
t.frame = {
    color = {238 / 255, 238 / 255, 238 / 255}
}
t.button = {
    colorButton = {
        {241/255,241/255,241/255},
        {220/255,220/255,220/255}
    },

    outlines = {
        boolOutlines = true,
        colorInnerOutline = {1, 1, 1, 0.7},
        colorOuterOutline = {100 / 255, 100 / 255, 100 / 255},
        thicknessInnerOutline = 3,
        thicknessOuterOutline = 5
    },
    text = {
        fontText = love.graphics.newFont("SNUI/themes/resources/default/Ubuntu-Regular.ttf", 24),
        colorText = {85 / 255, 140 / 255, 203 / 255}
    },
    brightnessModifier = {
        numberWhenHover = 1.2,
        numberWhenPressed = 0.8
    },
    scaleModifier = {
        numberWhenHover = 1,
        numberWhenPressed = 1,
        lerping = {
            easeSpeed = 1, -- 1 FOR INSTANT
            lerpType = 0 -- 0 FOR DIVISION, 1 FOR MULTIPLICATION
        }
    }
}
t.edittext = {
    colorEdittext = {1,1,1},
    allText = {
        fontText = love.graphics.newFont("SNUI/themes/resources/default/Ubuntu-Regular.ttf", 24)
    },
    text = {
        colorText = {0,0,0},
    },
    placeholder = {
        colorText = {0.5,0.5,0.5}
    },
    outlines = {
        colorOuterOutline = {0,0,0},
        thicknessOuterOutline = 5
    }
}

return t