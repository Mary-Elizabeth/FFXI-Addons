local NilInteraction = require('model/interaction/nil')

--------------------------------------------------------------------------------
local function CreateItemPacket(item, count, slot, index)
    local pkt = packets.new('outgoing', 0x034)
    pkt['Count'] = count
    pkt['Item'] = item
    pkt['Inventory Index'] = index
    pkt['Slot'] = slot
    return pkt
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local AddTradeItem = NilInteraction:NilInteraction()
AddTradeItem.__index = AddTradeItem

--------------------------------------------------------------------------------
function AddTradeItem:AddTradeItem(item, count, slot, index)
    local o = NilInteraction:NilInteraction()
    setmetatable(o, self)
    o._item = item
    o._count = count
    o._slot = slot
    o._index = index
    o._to_send = { [1] = function() return {CreateItemPacket(o._item, o._count, o._slot, o._index)} end }
    o._idx = 1
    o._type = 'AddTradeItem'

    setmetatable(o._to_send,
            { __index = function() return function() return {} end end })
    return o
end

--------------------------------------------------------------------------------
function AddTradeItem:_GeneratePackets(data)
    local pkts = self._to_send[self._idx](data)
    self._idx = self._idx + 1
    return pkts
end

--------------------------------------------------------------------------------
function AddTradeItem:__call(data)
    data.player:Bag():Update()
    local pkts = self:_GeneratePackets(data)
    for _, pkt in pairs(pkts) do
        packets.inject(pkt)
    end
    self._on_success()
end

return AddTradeItem