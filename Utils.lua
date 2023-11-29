local _, u = ...

-- Hex formatted as "AARRGGBB"
local COLOR = {
    blue = "FF" .. "0000FF",
    green = "FF" .. "00FF00",
    red = "FF" .. "FF0000",
    legendary = "FF" .. "A335EE",
    heirloom = "FF" .. "E6CC80",
    warning = "FF" .. "EED202",
}

-- Wrap the text in a color code
local function colorWrap(text, colorCode)
    return "|c" .. colorCode .. text .. "|r"
end

-- Special case of the color function
local function prefix()
    return colorWrap("ImbusBinds> ", COLOR.legendary)
end

-- Special print
local function bprint(msg)
    print(prefix() .. msg)
end

-- Prints some separators
function u.guards() 
    local accum = ""
    for _ = 1, 30 do
        accum = accum .. "="
    end
    print(colorWrap(accum, COLOR.legendary))
end

function u.info(msg)
    bprint(colorWrap(msg, COLOR.heirloom))
end

function u.warn(msg)
    bprint(colorWrap(msg, COLOR.warning))
end

function u.error(msg)
    bprint(colorWrap(msg, COLOR.red))
end

function u.success(msg)
    bprint(colorWrap(msg, COLOR.green))
end