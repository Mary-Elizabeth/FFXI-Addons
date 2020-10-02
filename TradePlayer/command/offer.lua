local NilCommand = require('command/nil')
local EntityFactory = require('model/entity/factory')
local DialogueFactory = require('model/dialogue/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local OfferCommand = NilCommand:NilCommand()
OfferCommand.__index = OfferCommand

--------------------------------------------------------------------------------
function OfferCommand:OfferCommand(id, items)
    local o = NilCommand:NilCommand()
    setmetatable(o, self)
    o._id = id
    o._items = items
    o._type = 'OfferCommand'
    o._dialogue = DialogueFactory.CreateOfferDialogue(
            EntityFactory.CreateMob(o._id),
            EntityFactory.CreatePlayer(), o._items)
    o._dialogue:SetSuccessCallback(function() o._on_success() end)
    o._dialogue:SetFailureCallback(function() o._on_failure() end)
    return o
end

--------------------------------------------------------------------------------
function OfferCommand:OnIncomingData(id, pkt)
    return self._dialogue:OnIncomingData(id, pkt)
end

--------------------------------------------------------------------------------
function OfferCommand:OnOutgoingData(id, pkt)
    return self._dialogue:OnOutgoingData(id, pkt)
end

--------------------------------------------------------------------------------
function OfferCommand:__call(state)
    self._dialogue:Start()
end

return OfferCommand
