local NilInteraction = require('model/interaction/nil')
local Data = require('util/data')

--------------------------------------------------------------------------------
local function CreateFinishPacket(_)
    local pkt = packets.new('outgoing', 0x033)
    pkt['Type'] = 2
    return pkt
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local FinishTrade = NilInteraction:NilInteraction()
FinishTrade.__index = FinishTrade

--------------------------------------------------------------------------------
function FinishTrade:FinishTrade(pid)
    local o = NilInteraction:NilInteraction()
    setmetatable(o, self)
    o._to_send = { [1] = function(data) return {CreateFinishPacket(data)} end }
    o._idx = 1
    o._pid = pid
    o._type = 'FinishTrade'

    setmetatable(o._to_send,
            { __index = function() return function() return {} end end })
    return o
end

--------------------------------------------------------------------------------
function FinishTrade:OnIncomingData(id, pkt)
    if id == 0x022 then
        local type = Data.ReadInt32(pkt, 9)
        local player = Data.ReadInt32(pkt, 5)
        if type == 9 then
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
function FinishTrade:_GeneratePackets(data)
    local pkts = self._to_send[self._idx](data)
    self._idx = self._idx + 1
    return pkts
end

--------------------------------------------------------------------------------
function FinishTrade:__call(data)
    local pkts = self:_GeneratePackets(data)
    for _, pkt in pairs(pkts) do
        packets.inject(pkt)
    end
end

return FinishTrade