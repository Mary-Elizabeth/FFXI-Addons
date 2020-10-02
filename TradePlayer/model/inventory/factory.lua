local NilInventory = require('model/inventory/nil')
local PlayerInventory = require('model/inventory/player')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local InventoryFactory = {}

--------------------------------------------------------------------------------
function InventoryFactory.CreateInventory(bag_num)
    if not bag_num then
        return NilInventory:NilInventory()
    end

    local inv = windower.ffxi.get_items()
    local bag = resources.bags[bag_num]
    local inventory
    if inv and inv.gil >= 0 and inv[bag.command] then
        inventory = PlayerInventory:PlayerInventory(bag)
    else
        inventory = NilInventory:NilInventory()
    end

    inventory:Update()
    return inventory
end

return InventoryFactory
