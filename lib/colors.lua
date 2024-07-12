
-- function that calculates how same two colors are perceived by humans
function humanPerceivedSameness(color1, color2)
    local r1, g1, b1, a1 = color1.red, color1.green, color1.blue, color1.alpha
    local r2, g2, b2, a2 = color2.red, color2.green, color2.blue, color2.alpha
    local rmean = (r1 + r2) / 2
    local r = r1 - r2
    local g = g1 - g2
    local b = b1 - b2
    return math.sqrt((((512 + rmean) * r * r) / 256) + 4 * g * g + (((767 - rmean) * b * b) / 256))
end
