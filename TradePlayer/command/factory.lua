local NilCommand = require('command/nil')
local OfferCommand = require('command/offer')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CommandFactory = {}

--------------------------------------------------------------------------------
local function GetItemResource(name)
    for key, value in pairs(resources.items) do
        if value.en:lower() == name:lower() then
            return value
        end
    end
    return nil
end

--------------------------------------------------------------------------------
function CommandFactory.CreateCommand(...)
    local args = {...}
    local player = windower.ffxi.get_player()
    if not player then
        log('Not logged in')
        return NilCommand:NilCommand()
    end

    local target = nil
    if #args % 2 == 0 then
        local mob = windower.ffxi.get_mob_by_target('t')
        target = mob
    else
        local mob = windower.ffxi.get_mob_by_name((tostring(table.remove(args, #args)):gsub("^%l", string.upper)))
        target = mob
    end

    if not target or target.is_npc then
        log('Could not determine trade partner')
        return NilCommand:NilCommand()
    end

    local items = {}
    while #args > 0 do
        local count = table.remove(args, 1)
        local item = table.remove(args, 1)
        local converted = windower.convert_auto_trans(item)
        local res = GetItemResource(converted and converted or item)

        if count and not tonumber(count) or item and not res then
            log('Unable to parse items')
            return NilCommand:NilCommand()
        end

        table.insert(items, { item = res, count = count })
    end

    return OfferCommand:OfferCommand(target.id, items)
end

return CommandFactory