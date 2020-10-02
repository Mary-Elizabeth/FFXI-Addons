local NilInteraction = require('model/interaction/nil')
local Data = require('util/data')

--------------------------------------------------------------------------------
local function CreateOfferPacket(data)
    local pkt = packets.new('outgoing', 0x032)
    pkt['Target'] = data.target:Id()
    pkt['Target Index'] = data.target:Index()
    return pkt
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local OfferTrade = NilInteraction:NilInteraction()
OfferTrade.__index = OfferTrade

--------------------------------------------------------------------------------
function OfferTrade:OfferTrade(pid)
    local o = NilInteraction:NilInteraction()
    setmetatable(o, self)
    o._to_send = { [1] = function(data) return {CreateOfferPacket(data)} end }
    o._idx = 1
    o._pid = pid
    o._type = 'OfferTrade'

    setmetatable(o._to_send,
            { __index = function() return function() return {} end end })
    return o
end

--------------------------------------------------------------------------------
function OfferTrade:OnIncomingData(id, pkt)
    if id == 0x022 then
        local type = Data.ReadInt32(pkt, 9)
        local player = Data.ReadInt32(pkt, 5)
        if type == 0 then
            if player == self._pid then
                self._on_success()
            else
                self._on_failure()
                return false
            end
        else
            self._on_failure()
        end
        return true
    else
        return false
    end
end

--------------------------------------------------------------------------------
function OfferTrade:_GeneratePackets(data)
    local pkts = self._to_send[self._idx](data)
    self._idx = self._idx + 1
    return pkts
end

--------------------------------------------------------------------------------
function OfferTrade:__call(data)
    local pkts = self:_GeneratePackets(data)
    for _, pkt in pairs(pkts) do
        packets.inject(pkt)
    end
end

return OfferTrade