local OfferDialogue = require('model/dialogue/offer')
local NilDialogue = require('model/dialogue/nil')
local NilInventory = require('model/inventory/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local DialogueFactory = {}

--------------------------------------------------------------------------------
function DialogueFactory.CreateOfferDialogue(npc, player, items)
    if not npc or npc:Type() == 'NilEntity' then
        log('Unable to find npc')
        return NilDialogue:NilDialogue()
    end

    if not player or player:Type() == 'NilEntity' then
        log('Unable to find player')
        return NilDialogue:NilDialogue()
    end

    if npc:Distance() > settings.config.maxdistance then
        log('Player too far away')
        return NilDialogue:NilDialogue()
    end

    if not items or items == {} then
        log('No items being traded')
        return NilDialogue:NilDialogue()
    end

    if player:Bag():FreeSlots() < 1 then
        log('Inventory full')
        return NilDialogue:NilDialogue()
    end

    local slots = {}
    local size = 0
    for _, data in pairs(items) do
        local c = tonumber(data.count)
        local item = data.item
        if player:Bag():ItemCount(tonumber(item.id)) < c then
            log('Not enough items('..data.item.en..')')
            return NilDialogue:NilDialogue()
        end

        local stack_size = tonumber(item.stack) and tonumber(item.stack) or math.huge
        local exclusions = {}
        while c > stack_size do
            local index = player:Bag():ItemIndex(tonumber(item.id), stack_size, exclusions)
            if index == nil then
                log('Unable to find items to trade')
                return NilDialogue:NilDialogue()
            end
            slots[size + 1] = { count = stack_size, item = item, index = index }
            size = size + 1
            c = c - stack_size
            exclusions[slots[#slots].index] = true
        end
        if c > 0 then
            local index = player:Bag():ItemIndex(tonumber(item.id), c, exclusions)
            if index == NilInventory.INVALID_INDEX then
                log('Unable to find items to trade')
                return NilDialogue:NilDialogue()
            end

            if item.id == 65535 then
                slots['0'] = { count = c, item = item, index = index }
            else
                slots[size + 1] = { count = c, item = item, index = index }
                size = size + 1
            end
        end
    end

    if size > 8 then
        log('Attempting to trade too many items')
        return NilDialogue:NilDialogue()
    end

    return OfferDialogue:OfferDialogue(npc, player, slots)
end

return DialogueFactory
