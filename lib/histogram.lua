function makeHistogram(image)
    local histogram = {}
    for y = 0, image.height - 1 do
        for x = 0, image.width - 1 do
            local color = image:getPixel(x, y)
            local key = color
            if histogram[key] == nil then
                histogram[key] = 1
            else
                histogram[key] = histogram[key] + 1
            end
        end
    end
    return histogram
end

function mostCommonColor(histogram)
    local maxCount = 0
    local mostCommonColor = nil
    for key,count in pairs(histogram) do
        if count > maxCount then
            maxCount = count
            mostCommonColor = key
        end
    end
    if mostCommonColor == nil then
        return nil
    end
    return Color(mostCommonColor)
end