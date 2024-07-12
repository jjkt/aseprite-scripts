function findReferenceLayer(sprite)
    for k,layer in ipairs(sprite.layers) do
        if layer.isReference then
        return layer
        end
    end
    return nil
end

function findFirstLayer(sprite)
    for k,layer in ipairs(sprite.layers) do
        if not layer.isReference then
        return layer
        end
    end
    return nil
end