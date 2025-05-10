local t = {}
t.themeVersion = 2

t.affectsAll = {
    xRoundedCorners = 24,
    yRoundedCorners = 24
}
t.frame = {
    color = {0.7,0.7,0.7}
}
t.button = {
    colorButton = {
        {0.9,0.9,0.9},
        {0.9,0.9,0.9}
    },

    outlines = {
        boolOutlines = false,
        colorInnerOutline = {1, 1, 1, 0.7},
        colorOuterOutline = {100 / 255, 100 / 255, 100 / 255},
        thicknessInnerOutline = 3,
        thicknessOuterOutline = 5
    },
    text = {
        fontText = love.graphics.newFont("SNUI/themes/resources/resonance/Arimo-VariableFont_wght.ttf", 24),
        colorText = {0,0,0}
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
        fontText = love.graphics.newFont("SNUI/themes/resources/resonance/Arimo-VariableFont_wght.ttf", 24)
    },
    text = {
        colorText = {0,0,0},
    },
    placeholder = {
        colorText = {0.5,0.5,0.5}
    },
    outlines = {
        colorOuterOutline = {0.7,0.7,0.7,0.5},
        thicknessOuterOutline = 3
    },
    cursor = {
        colorCursor = {0,0,0,0.7},
        thicknessMultiplierCursor = 2
    }
}

return t