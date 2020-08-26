--[[
Copyright 2019 Seth VanHeulen

This file is part of fisher.

fisher is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

fisher is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with fisher.  If not, see <https://www.gnu.org/licenses/>.
--]]

-- luacheck: std luajit, globals windower

-- built-in libraries
local string = require('string')
-- extra libraries
require('pack')

local incoming_callbacks = {}

windower.register_event('action', function (act)
    local callback = incoming_callbacks[0x028]
    if callback then callback(act) end
end)

windower.register_event('chat message', function (_, _, _, gm)
    local callback = incoming_callbacks[0x017]
    if callback then callback({gm = gm}) end
end)

windower.register_event('incoming chunk', function (id, original)
    local callback = incoming_callbacks[id]
    if callback then
        local packet = {}
        if id == 0x00B then
            packet.type = string.byte(original, 5)
        elseif id == 0x00D then
            packet.player_id = string.unpack(original, 'I', 5)
            packet.update_vitals = string.byte(original, 11) % 8 >= 4
            packet.state_id = string.byte(original, 32)
        elseif id == 0x036 then
            packet.actor, packet.actor_index, packet.message_id = string.unpack(original, 'IHH', 5)
            packet.message_id = packet.message_id % 0x8000
        elseif id == 0x037 then
            packet.state_id = string.byte(original, 49)
            packet.fish_hook_delay = string.byte(original, 75)
        elseif id == 0x115 then
            packet.fish_hp, packet.arrow_time, packet.auto_regen, packet.movement = string.unpack(original, 'HHHH', 5)
            packet.damage, packet.healing, packet.time_limit = string.unpack(original, 'HHH', 13)
            packet.gold_arrows = string.unpack(original, 'I', 21)
        end
        callback(packet)
    end
end)

local incoming_mt = {
    __index = function (_, k)
        return {
            register = function (_, fn)
                incoming_callbacks[k] = fn
            end,
        }
    end,
}

local outgoing_callbacks = {}

windower.register_event('outgoing chunk', function (id, original, _, injected)
    local callback = outgoing_callbacks[id]
    if callback then
        local packet = {}
        local info = {}
        if id == 0x01A then
            packet.action_category = string.byte(original, 11)
        elseif id == 0x110 then
            packet.fish_hp = string.byte(original, 9)
            packet.action_type = string.byte(original, 15)
            packet.gold_arrows = string.unpack(original, 'I', 17)
            info.injected = injected
        end
        callback(packet, info)
    end
end)

local outgoing_mt = {
    __index = function (_, k)
        return {
            inject = function (_, data)
                if k == 0x029 then
                    windower.packets.inject_outgoing(k, string.pack(
                        'IICCCC', 0x629, data.count, data.current_bag_id,
                        data.target_bag_id, data.current_bag_index, data.target_bag_index
                    ))
                elseif k == 0x050 then
                    windower.packets.inject_outgoing(k, string.pack(
                        'ICCH', 0x450, data.bag_index, data.slot_id, data.bag_id
                    ))
                elseif k == 0x110 then
                    windower.packets.inject_outgoing(k, string.pack(
                        'IIIHHI', 0xB10, data.player_id, data.fish_hp,
                        data.player_index, data.action_type, data.gold_arrows
                    ))
                end
            end,
            register = function (_, fn)
                outgoing_callbacks[k] = fn
            end,
        }
    end,
}

local packets = {
    incoming = setmetatable({}, incoming_mt),
    outgoing = setmetatable({}, outgoing_mt),
}

return packets

