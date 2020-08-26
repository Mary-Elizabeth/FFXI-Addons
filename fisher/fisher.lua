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

-- luacheck: std luajit, globals _addon windower

-- built-in libraries
local bit = require('bit')
local coroutine = require('coroutine')
local io = require('io')
local math = require('math')
local os = require('os')
local string = require('string')
local table = require('table')

local function join_path(...)
    return string.gsub(string.gsub(table.concat({...}, '/'), '\\', '/'), '/+', '/')
end

if _addon then
    local package = require('package')
    package.path = join_path(windower.addon_path, 'wrapper/?.lua;') .. package.path
    _addon.windower = 4
end

local _addon = _addon or {windower=5}
_addon.name = 'fisher'
_addon.author = 'Seth VanHeulen'
_addon.version = '4.6.1.1'
_addon.command = 'fisher'

-- core libraries
local chat = require('core.chat')
local command = require('core.command')
local windower = require('core.windower')
-- extra libraries
local equipment = require('equipment')
local items = require('items')
require('pack')
local packets = require('packets')
local player = require('player')
local settings = require('settings')
local world = require('world')
-- local libraries
local data = require('data')

local options = settings.load({
    equip_delay=2, move_delay=0, cast_attempt_delay=3, cast_attempt_max=3,
    release_delay=3, catch_delay_min=3, catch_delay_override=0, recast_delay=3,
    fatigue_start=os.date('!%Y-%m-%d', os.time() + 9 * 60 * 60), fatigue_count=0,
    unknown_items={}, catch_unknown=false, debug_messages=false,
})

local session = {
    running=false, coroutine_key=math.random(), item_by_id={}, bait_by_id={},
    player_state=player.state_id, message_error=false, catch_limit=0, fishing_status={},
}

local MESSAGE_INFO = 207
local MESSAGE_WARN = 200
local MESSAGE_ERROR = 167
local MESSAGE_DEBUG = 160

local function message(text, level)
    local _type = level or MESSAGE_INFO
    if options.debug_messages or _type ~= MESSAGE_DEBUG then
        chat.add_text(string.format('[%s] %s', _addon.name, text), _type)
    end
end

local function stop_fishing(reason)
    if session.running then
        session.running = false
        session.coroutine_key = math.random()
        if reason then
            message(string.format('stopped automated fishing (%s)', reason), MESSAGE_ERROR)
        else
            message('stopped automated fishing', MESSAGE_WARN)
        end
    end
end

local function is_valid_equipment()
    if equipment[13].item.id == 15556 or equipment[14].item.id == 15556 then return false end
    return data.rod_modifier_by_id[equipment[2].item.id] ~= nil
end

local equip_bait
do
    local equipable_bags = {0, 8, 10, 11, 12}

    local function equip_item(slot_id, item)
        packets.outgoing[0x050]:inject({bag_index=item.index, slot_id=slot_id, bag_id=item.bag})
    end

    function equip_bait()
        if session.bait_by_id[equipment[3].item.id] then return true end
        for i = 1, #equipable_bags do
            local bag_id = equipable_bags[i]
            for index = 1, items.sizes[bag_id] do
                local item = items.bags[bag_id][index]
                if item.status == 0 and session.bait_by_id[item.id] then
                    message(string.format(
                        'equipping item: bag_id = %d, bag_index = %d, item_id = %d',
                        item.bag, item.index, item.id
                    ), MESSAGE_DEBUG)
                    equip_item(3, item)
                    coroutine.sleep(options.equip_delay)
                    return true
                end
            end
        end
        return false
    end
end

local clear_inventory
do
    local function move_item(target_item, item)
        packets.outgoing[0x029]:inject({
            count=item.count, current_bag_id=item.bag, target_bag_id=target_item.bag,
            current_bag_index=item.index, target_bag_index=target_item.index,
        })
    end

    function clear_inventory()
        for i = 1, items.sizes[0] do
            if items.bags[0][i].id == 0 then return true end
        end
        local index = items.sizes[0]
        local moved = false
        for target_bag = 5, 7 do
            for target_index = 1, items.sizes[target_bag] do
                local target_item = items.bags[target_bag][target_index]
                if target_item.id == 0 then
                    for source_index = index, 1, -1 do
                        index = source_index - 1
                        local item = items.bags[0][source_index]
                        if item.status == 0 and session.item_by_id[item.id] then
                            message(string.format(
                                'moving item: bag_index = %d, item_id = %d -> bag_id = %d, bag_index = %d',
                                source_index, item.id, target_bag, target_index
                            ), MESSAGE_DEBUG)
                            move_item(target_item, item)
                            moved = true
                            coroutine.sleep(options.move_delay)
                            break
                        end
                    end
                    if not moved then return false end
                    if index == 0 then return true end
                end
            end
        end
        return moved
    end
end

local function input_fish_command(coroutine_key)
    local cast_attempt = 0
    while session.running and coroutine_key == session.coroutine_key and cast_attempt < options.cast_attempt_max do
        if session.message_error then
            stop_fishing('incorrect client path')
        elseif not next(session.item_by_id) then
            stop_fishing('nothing set to catch')
        elseif not next(session.bait_by_id) then
            stop_fishing('no bait set to use')
        elseif not is_valid_equipment() then
            stop_fishing('invalid equipment')
        elseif not equip_bait() then
            stop_fishing('out of bait')
        elseif not clear_inventory() then
            stop_fishing('out of inventory space')
        else
            cast_attempt = cast_attempt + 1
            message(string.format(
                'casting fishing rod: attempt = %d, max = %d',
                cast_attempt, options.cast_attempt_max
            ), MESSAGE_DEBUG)
            command.input('/fish')
            coroutine.sleep(options.cast_attempt_delay)
        end
    end
    if coroutine_key == session.coroutine_key and cast_attempt >= options.cast_attempt_max then
        stop_fishing('unable to cast')
    end
end

local function schedule_cast()
    message(string.format('casting in %d seconds', options.recast_delay))
    local coroutine_key = math.random()
    session.coroutine_key = coroutine_key
    coroutine.schedule(function () input_fish_command(coroutine_key) end, options.recast_delay)
end

local function stop_cast_attempts()
    session.coroutine_key = math.random()
end

local function send_fishing_action(stamina_percent, gold_arrow_chance, coroutine_key)
    if session.running and coroutine_key == session.coroutine_key then
        message(string.format(
            'sending fishing action: stamina_percent = %d, gold_arrow_chance = %d',
            stamina_percent, gold_arrow_chance
        ), MESSAGE_DEBUG)
        packets.outgoing[0x110]:inject({
            player_id=player.id, fish_hp=stamina_percent, player_index=player.index,
            action_type=3, gold_arrows=gold_arrow_chance,
        })
    end
end

local schedule_catch
do
    local function calculate_catch_delay(packet)
        if options.catch_delay_override > 0 then
            return math.min(options.catch_delay_override, packet.time_limit - 3)
        end
        local gold_arrow_chance = math.min(packet.gold_arrows, 100) / 100
        local depletion_per_arrow = packet.damage + packet.damage * gold_arrow_chance
        local recovery_per_arrow = packet.healing - (packet.healing / 4 * 3) * gold_arrow_chance
        local correct_chance = packet.arrow_time / (packet.arrow_time + 1)
        local regen_per_arrow = recovery_per_arrow * (1 - correct_chance) - depletion_per_arrow * correct_chance
        local arrows_per_second = (packet.movement + 5) / 25
        local regen_per_second = (packet.auto_regen - 128) * 60 + arrows_per_second * regen_per_arrow
        local catch_delay = packet.time_limit - 3
        if regen_per_second < 0 then
            catch_delay = math.min(math.abs(packet.fish_hp / regen_per_second), catch_delay)
        end
        return math.max(options.catch_delay_min, catch_delay)
    end

    function schedule_catch(packet)
        local delay = calculate_catch_delay(packet)
        message(string.format('catching in %d seconds', delay))
        local gold_arrow_chance = packet.gold_arrows
        local coroutine_key = math.random()
        session.coroutine_key = coroutine_key
        coroutine.schedule(function () send_fishing_action(0, gold_arrow_chance, coroutine_key) end, delay)
    end
end

local function schedule_release()
    message(string.format('releasing in %d seconds', options.release_delay))
    local coroutine_key = math.random()
    session.coroutine_key = coroutine_key
    coroutine.schedule(function () send_fishing_action(200, 0, coroutine_key) end, options.release_delay)
end

local function update_fatigue(operation, value)
    local now = os.time() + 9 * 60 * 60
    local today = os.date('!%Y-%m-%d', now)
    now = os.date('!*t', now)
    local save = operation ~= nil
    if options.fatigue_start ~= today then
        options.fatigue_start = today
        options.fatigue_count = 0
        save = true
    end
    if operation == '=' then
        options.fatigue_count = value
    elseif operation == '+' then
        options.fatigue_count = math.max(options.fatigue_count + value, 0)
    end
    if save then settings.save() end
    local reset = (24 * 60) - (now.hour * 60 + now.min)
    message(string.format(
        'fishing fatigue = %d/200, resets in %dh%dm',
        options.fatigue_count, math.floor(reset / 60), reset % 60
    ))
    if options.fatigue_count >= 200 then stop_fishing('fatigued') end
end

local function start_fishing(catch_limit)
    if not session.running and player.state_id == 0 then
        message('started automated fishing', MESSAGE_WARN)
        session.running = true
        local coroutine_key = math.random()
        session.coroutine_key = coroutine_key
        update_fatigue()
        if catch_limit then
            session.catch_limit = catch_limit
            message(string.format('catch limit = %d', catch_limit))
        else
            session.catch_limit = 0
        end
        coroutine.schedule(function () input_fish_command(coroutine_key) end, 0)
    end
end

local function update_catch_limit()
    if session.running and session.catch_limit > 0 then
        session.catch_limit = session.catch_limit - 1
        if session.catch_limit > 0 then
            message(string.format('remaining catch limit = %d', session.catch_limit))
        else
            stop_fishing('catch limit')
        end
    end
end

local function player_state_changed(state_id)
    message(string.format(
        'player state changed: state_id = %d -> state_id = %d',
        session.player_state, state_id
    ), MESSAGE_DEBUG)
    if state_id == 56 then
        session.fishing_status = {}
    elseif state_id == 58 or state_id == 61 then
        update_fatigue('+', 1)
        update_catch_limit()
    elseif state_id == 60 and session.fishing_status.lost_skill then
        update_fatigue('+', 0.5)
    end
    if session.running then
        if state_id == 0 then
            schedule_cast()
        elseif state_id == 56 then
            stop_cast_attempts()
        elseif not (state_id >= 56 and state_id <= 62 or state_id == 0) then
            stop_fishing('invalid player state')
        end
    end
    session.player_state = state_id
end

local is_message
do
    local message_id_by_zone = {}

    local message_dat_by_zone = data.message_dat_by_zone

    local function read_file(path)
        local handle = io.open(path, 'rb')
        if handle then
            local contents = handle:read('*a')
            handle:close()
            return contents
        end
    end

    local base_message = string.char(
        0xd9,0xef,0xf5,0xa0,0xec,0xef,0xf3,0xf4,0xa0,0xf9,0xef,0xf5,0xf2,0xa0,0xe3,0xe1,
        0xf4,0xe3,0xe8,0xa0,0xe4,0xf5,0xe5,0xa0,0xf4,0xef,0xa0,0xf9,0xef,0xf5,0xf2,0xa0,
        0xec,0xe1,0xe3,0xeb,0xa0,0xef,0xe6,0xa0,0xf3,0xeb,0xe9,0xec,0xec,0xae,0xff,0xb1,
        0x80,0x87
    )

    local function format_offset(offset)
        offset = string.pack('i', bit.bxor(offset - 5, 0x80808080))
        return string.gsub(offset, '([%^%$%(%)%%%.%[%]%*%+%-%?])', '%%%1')
    end

    local function find_message_id()
        local zone_id = world.zone_id
        if not message_id_by_zone[zone_id] then
            local message_dat = message_dat_by_zone[zone_id]
            if message_dat then
                message(string.format('updating message id cache: zone_id = %d', zone_id), MESSAGE_DEBUG)
                local message_dat_path = join_path(windower.client_path, message_dat)
                local message_dat_file = read_file(message_dat_path)
                if not message_dat_file then
                    session.message_error = true
                    message(string.format('error reading message dat: path = %q', message_dat_path), MESSAGE_DEBUG)
                    return false
                end
                local offset = string.find(message_dat_file, base_message)
                local index = string.find(message_dat_file, format_offset(offset))
                message_id_by_zone[zone_id] = (index - 5) / 4
            else
                message_id_by_zone[zone_id] = true
            end
        end
        return message_id_by_zone[zone_id]
    end

    local message_id_offsets = {lost_skill=0, hooked_monster=32}

    function is_message(name, message_id)
        return find_message_id() == message_id - message_id_offsets[name]
    end
end

local identify_hooked_item
do
    local item_by_rod_and_uid = {}

    local function find_item(stamina_base, packet)
        local rod_id = equipment[2].item.id
        if not item_by_rod_and_uid[rod_id] then
            local item_by_uid = {}
            local rod_modifier = data.rod_modifier_by_id[rod_id]
            message(string.format('updating item uid cache: rod_id = %d', rod_id), MESSAGE_DEBUG)
            for i = 1, #data.item_fishing_parameters do
                local item = data.item_fishing_parameters[i]
                item_by_uid[rod_modifier(item)] = item
            end
            item_by_rod_and_uid[rod_id] = item_by_uid
        end
        local uid = table.concat({stamina_base, packet.arrow_time, packet.movement, packet.damage}, ',')
        return item_by_rod_and_uid[rod_id][uid]
    end

    function identify_hooked_item(packet)
        message(string.format(
            'identifying hooked item: stamina = %d, arrow_duration = %d, arrow_frequency = %d, stamina_depletion = %d',
            packet.fish_hp, packet.arrow_time, packet.movement, packet.damage
        ), MESSAGE_DEBUG)
        local identified = {}
        for i = 95, 105 do
            if packet.fish_hp % i == 0 then
                local item = find_item(math.floor(packet.fish_hp / i), packet)
                if item then table.insert(identified, item) end
            end
        end
        return identified
    end
end

packets.incoming[0x00B]:register(function (packet)
    if packet.type == 1 then
        stop_fishing('log out')
        session.item_by_id = {}
        session.bait_by_id = {}
        session.message_error = false
    else
        stop_fishing('zone change')
    end
end)

packets.incoming[0x00D]:register(function (packet)
    if packet.player_id == player.id and packet.update_vitals and packet.state_id ~= session.player_state then
        player_state_changed(packet.state_id)
    end
end)

packets.incoming[0x017]:register(function (packet)
    if packet.gm then stop_fishing('chat message from gm') end
end)

--[[
packets.incoming[0x028]:register(function (packet)
    if session.running then
        local targets = packet.targets
        for i = 1, packet.target_count do
            if targets[i].id == player.id then stop_fishing('targeted by action') end
        end
    end
end)
--]]

packets.incoming[0x036]:register(function (packet)
    if is_message('hooked_monster', packet.message_id) then
        session.fishing_status.hooked_monster = true
    elseif is_message('lost_skill', packet.message_id) then
        session.fishing_status.lost_skill = true
    end
end)

packets.incoming[0x037]:register(function (packet)
    if packet.state_id ~= session.player_state then
        if packet.state_id == 56 then
            message(string.format('fishing rod casted: hook_delay = %d', packet.fish_hook_delay), MESSAGE_DEBUG)
        end
        player_state_changed(packet.state_id)
    end
end)

packets.incoming[0x115]:register(function (packet)
    if session.fishing_status.started_minigame then
        message('skipping duplicate fishing minigame packet', MESSAGE_DEBUG)
    elseif session.message_error then
        if session.running then
            stop_fishing('incorrect client path')
        else
            message('unable to identify hooked item (incorrect client path)', MESSAGE_ERROR)
        end
--monster releasing function
    elseif session.fishing_status.hooked_monster then
        message('hooked = monster', MESSAGE_WARN)
        if session.running then schedule_release() end
    elseif is_valid_equipment() then
        local identified = identify_hooked_item(packet)
        local catch = false
        if #identified == 0 then
            local item_data = {
                world.zone_id, equipment[2].item.id, equipment[3].item.id, packet.fish_hp,
                packet.arrow_time, packet.movement, packet.damage, packet.healing,
            }
            table.insert(options.unknown_items, table.concat(item_data, ','))
            settings.save()
            message('unable to identify hooked item (logged to settings)', MESSAGE_WARN)
            catch = options.catch_unknown
        end
        for i = 1, #identified do
            local item = identified[i]
            message(string.format('hooked = %s x%d', item.name, item.count or 1), MESSAGE_WARN)
            if session.running and not catch then
                for j = 1, #item.id do
                    if session.item_by_id[item.id[j]] then catch = true end
                end
            end
        end
        if session.running then
            if catch then schedule_catch(packet) else schedule_release() end
        end
    elseif session.running then
        stop_fishing('invalid equipment')
    else
        message('unable to identify hooked item (invalid equipment)', MESSAGE_ERROR)
    end
    session.fishing_status.started_minigame = true
end)

packets.outgoing[0x01A]:register(function (packet)
    if packet.action_category ~= 14 then stop_fishing('performed another action') end
end)

packets.outgoing[0x110]:register(function (packet, info)
    message(string.format(
        'fishing action sent: stamina = %d, action = %d, gold_arrow_chance = %d',
        packet.fish_hp, packet.action_type, packet.gold_arrows
    ), MESSAGE_DEBUG)
    if packet.action_type == 3 then
        if packet.fish_hp == 300 then
            stop_fishing('fishing timed out')
        elseif not info.injected then
            stop_fishing('manual fishing action')
        end
    end
end)

local fisher_command = command.new('fisher')

fisher_command:register('start', start_fishing, '[catch_limit:integer(1,210)]')

fisher_command:register('stop', stop_fishing)

fisher_command:register('add', function (item_name)
    item_name = string.lower(item_name)
    if item_name == 'all' then
        command.input('/fisher add all fish')
        command.input('/fisher add all item')
        command.input('/fisher add all bait')
    elseif item_name == 'all fish' then
        for item_name, item_id in pairs(data.fish_by_name) do -- luacheck: ignore 422
            session.item_by_id[item_id] = item_name
        end
        message('added all fishes to catch')
    elseif item_name == 'all item' then
        for item_name, item_id in pairs(data.item_by_name) do -- luacheck: ignore 422
            session.item_by_id[item_id] = item_name
        end
        message('added all items to catch')
    elseif item_name == 'all bait' then
        for item_name, item_id in pairs(data.bait_by_name) do -- luacheck: ignore 422
            session.bait_by_id[item_id] = item_name
        end
        message('added all baits to use')
    elseif data.fish_by_name[item_name] then
        local item_id = data.fish_by_name[item_name]
        session.item_by_id[item_id] = item_name
        message(string.format('added fish to catch = %s (%d)', item_name, item_id))
    elseif data.item_by_name[item_name] then
        local item_id = data.item_by_name[item_name]
        session.item_by_id[item_id] = item_name
        message(string.format('added item to catch = %s (%d)', item_name, item_id))
    elseif data.bait_by_name[item_name] then
        local item_id = data.bait_by_name[item_name]
        session.bait_by_id[item_id] = item_name
        message(string.format('added bait to use = %s (%d)', item_name, item_id))
    else
        message('invalid fish, item or bait name', MESSAGE_ERROR)
    end
end, '<item_name:text>')

fisher_command:register('remove', function (item)
    local item_name = string.lower(item)
    local item_id = tonumber(item)
    item_id = item_id or data.fish_by_name[item_name]
    item_id = item_id or data.item_by_name[item_name]
    item_id = item_id or data.bait_by_name[item_name]
    if item_name == 'all' then
        command.input('/fisher remove all fish')
        command.input('/fisher remove all item')
        command.input('/fisher remove all bait')
    elseif item_name == 'all fish' then
        for _, item_id in pairs(data.fish_by_name) do -- luacheck: ignore 421
            session.item_by_id[item_id] = nil
        end
        message('removed all fishes to catch')
    elseif item_name == 'all item' then
        for _, item_id in pairs(data.item_by_name) do -- luacheck: ignore 421
            session.item_by_id[item_id] = nil
        end
        message('removed all items to catch')
    elseif item_name == 'all bait' then
        session.bait_by_id = {}
        message('removed all baits to use')
    elseif session.item_by_id[item_id] then
        item_name = session.item_by_id[item_id]
        session.item_by_id[item_id] = nil
        if data.fish_by_name[item_name] then
            message(string.format('removed fish to catch = %s (%d)', item_name, item_id))
        else
            message(string.format('removed item to catch = %s (%d)', item_name, item_id))
        end
    elseif session.bait_by_id[item_id] then
        item_name = session.bait_by_id[item_id]
        session.bait_by_id[item_id] = nil
        message(string.format('removed bait to use = %s (%d)', item_name, item_id))
    else
        message('invalid fish, item or bait', MESSAGE_ERROR)
    end
end, '<item:text>')

fisher_command:register('list', function ()
    for item_id, item_name in pairs(session.item_by_id) do
        if data.fish_by_name[item_name] then
            message(string.format('fish to catch = %s (%d)', item_name, item_id))
        else
            message(string.format('item to catch = %s (%d)', item_name, item_id))
        end
    end
    if not next(session.item_by_id) then
        message('nothing set to catch')
    end
    for item_id, item_name in pairs(session.bait_by_id) do
        message(string.format('bait to use = %s (%d)', item_name, item_id))
    end
    if not next(session.bait_by_id) then
        message('no bait set to use')
    end
end)

fisher_command:register('fatigue', function (value)
    if not value then
        update_fatigue()
    else
        local operation = string.sub(value, 1, 1)
        update_fatigue((operation == '+' or operation == '-') and '+' or '=', tonumber(value))
    end
end, '[value:string([%+%-\\]?%d+)]')

message(string.format('loaded v%s in windower %d', _addon.version, _addon.windower), MESSAGE_WARN)
