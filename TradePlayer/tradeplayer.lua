_addon.name = 'TradePlayer'
_addon.author = 'Tny5989'
_addon.version = '0.1.1b'
_addon.commands = {'tradeplayer', 'tp'}

--------------------------------------------------------------------------------
require('logger')
packets = require('util/packets')
settings = require('util/settings')
resources = require('resources')

local CommandFactory = require('command/factory')
local NilCommand = require('command/nil')

--------------------------------------------------------------------------------
local command = NilCommand:NilCommand()

--------------------------------------------------------------------------------
local function OnSuccess()
    command = NilCommand:NilCommand()
    log('Accepted')
end

--------------------------------------------------------------------------------
local function OnFailure()
    command = NilCommand:NilCommand()
    log('Rejected')
end

--------------------------------------------------------------------------------
local function OnLoad()
    settings.load()
end

--------------------------------------------------------------------------------
local function OnCommand(...)
    if command:Type() == 'NilCommand' then
        command = CommandFactory.CreateCommand(unpack(arg))
        command:SetSuccessCallback(OnSuccess)
        command:SetFailureCallback(OnFailure)
        command()
    else
        log('Already running a complex command')
    end
end

--------------------------------------------------------------------------------
local function OnIncomingData(id, _, pkt, b, i)
    if not packets.is_duplicate(id, pkt) then
        return command:OnIncomingData(id, pkt)
    else
        return false
    end
end

--------------------------------------------------------------------------------
local function OnOutgoingData(id, _, pkt, b, i)
    return command:OnOutgoingData(id, pkt)
end

--------------------------------------------------------------------------------
windower.register_event('load', OnLoad)
windower.register_event('addon command', OnCommand)
windower.register_event('incoming chunk', OnIncomingData)
windower.register_event('outgoing chunk', OnOutgoingData)
