-- Aseprite script to pixelate the active sprite using the reference layer as a source.
dofile("./lib/layers.lua")
dofile("./lib/histogram.lua")
dofile("./lib/colors.lua")

local referenceLayer = findReferenceLayer(app.activeSprite)

if referenceLayer == nil then
    app.alert("No reference layer found.")
    return
end

-- get the cel from the reference layer (the first cel):
local referenceCel = referenceLayer:cel(1)
if referenceCel == nil then
    app.alert("No cel found in the reference layer.")
    return
end

-- get the resolution of the reference cel:
local referenceImage = referenceCel.image
local referenceWidth = referenceImage.width
local referenceHeight = referenceImage.height

-- get the size of the active sprite:
local spriteWidth = app.activeSprite.width
local spriteHeight = app.activeSprite.height

-- create a new image to store the pixelated version of the reference layer:
local img = Image(spriteWidth, spriteHeight)

local referenceXSize = referenceWidth / spriteWidth
local referenceYSize = referenceWidth / spriteWidth

-- analyze the reference layer to find the background color. The background color is the most common color in the reference layer.
-- calculate the histogram of the reference layer:

local histogram = makeHistogram(referenceImage)

-- find the most common color in the reference layer:
local backgroundColor = mostCommonColor(histogram)

if backgroundColor == nil then
    app.alert("Could not determine background color.")
    return
end

math.randomseed(os.time())

-- for each pixel in the target sprite, get the corresponding pixel in the reference layer by sampling 
-- the pixel randomly. 
for y = 0, spriteHeight - 1 do
    for x = 0, spriteWidth - 1 do
        local referenceX = math.floor(x * referenceWidth / spriteWidth)
        local referenceY = math.floor(y * referenceHeight / spriteHeight)
        local sampleX = math.floor(referenceX + math.random() * referenceXSize)
        local sampleY = math.floor(referenceY + math.random() * referenceYSize)
        local color = Color(referenceImage:getPixel(sampleX, sampleY))
        -- skip background colors:
        if humanPerceivedSameness(color, backgroundColor) > 20 then
            img:drawPixel(x, y, color)
        end
    end
end
-- place the image to the active sprite:
local layer = findFirstLayer(app.activeSprite)
if layer == nil then
    app.alert("No layer found in the active sprite.")
    return
end

app.activeSprite:newCel(layer, 1, img, 0, 0)