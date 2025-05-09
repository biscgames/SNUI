local m = {}
m.OBJECT_X_NAME = "x"
m.OBJECT_Y_NAME = "y"
m.OBJECT_WIDTH_NAME = "w"
m.OBJECT_HEIGHT_NAME = "h"

function m.mouseIsInArea(x, y, obj)
    if x > obj[m.OBJECT_X_NAME] and x < obj[m.OBJECT_X_NAME] + obj[m.OBJECT_WIDTH_NAME] then
        if y > obj[m.OBJECT_Y_NAME] and y < obj[m.OBJECT_Y_NAME] + obj[m.OBJECT_HEIGHT_NAME] then
            return true
        end
    end
    return false
end

return m
