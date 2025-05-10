local function replaceChar(char)
    local shiftReplace = {
        ["1"]="!",
        ["2"]="@",
        ["3"]="#",
        ["4"]="$",
        ["5"]="%",
        ["6"]="^",
        ["7"]="&",
        ["8"]="*",
        ["9"]="(",
        ["0"]=")",
        ["-"]="_",
        ["="]="+"
    }

    local isReplaced = false

    for k,v in pairs(shiftReplace) do
        if char == k then
            char = v
            isReplaced = true
            break
        end
    end

    if not isReplaced then
        char = string.upper(char)
    end

    return char
end
return replaceChar