local Data = {}

--------------------------------------------------------------------------------
function Data.ReadInt32(bin, start)
    local value = 0
    local bytes = bin

    if bytes == nil then
        return nil
    end

    value = bit.bor(value, string.byte(bytes, start + 0))
    value = bit.bor(value, bit.lshift(string.byte(bytes, start + 1), 8))
    value = bit.bor(value, bit.lshift(string.byte(bytes, start + 2), 16))
    value = bit.bor(value, bit.lshift(string.byte(bytes, start + 3), 24))

    return value
end

--------------------------------------------------------------------------------
function Data.ReadInt16(bin, start)
    local value = 0
    local bytes = bin

    if bytes == nil then
        return nil
    end

    value = bit.bor(value, string.byte(bytes, start + 0))
    value = bit.bor(value, bit.lshift(string.byte(bytes, start + 1), 8))

    return value
end

return Data
