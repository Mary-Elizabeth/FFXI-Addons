_addon.name     = 'iSpy'
_addon.author   = 'Selindrile'
_addon.version  = '1.0'
_addon.commands = {'spy','ispy'}

require('luau')
require('coroutine')
packets = require('packets')
texts = require('texts')

spy = true
setting = 'odyssey'
report = false
found = T{}
found_index = 1
best_match = nil

SpiedMobs = {
	odyssey = S{'Chest','Coffer','Aurum Strongbox'},
	nyzul = S{'Runic Lamp'},
	questions = S{'???'},
	}

windower.register_event('addon command',function (...)
    cmd = {...}
	local command

	if cmd[1] ~= nil then
		command = cmd[1]:lower()
	end

	if command == nil then
		if spy == true then
			spy = false
			windower.add_to_chat(7,'Spying is [OFF].')
		else
			spy = true
			windower.add_to_chat(7,'Spying is [ON].')
		end
	elseif command == 'target' then
		local player = windower.ffxi.get_player()
		local last_found_index
		if found_index == 1 then
			last_found_index = 3
		else
			last_found_index = found_index - 1
		end

		packets.inject(packets.new('incoming', 0x058, {
			['Player'] = player.id,
			['Target'] = found[last_found_index],
			['Player Index'] = player.index,
		}))
	elseif command == 'report' then
		if report == true then
			report = false
			windower.add_to_chat(7,'Reporting is [OFF].')
		else
			report = true
			windower.add_to_chat(7,'Reporting is [ON].')
		end
	elseif SpiedMobs[command] then
		windower.add_to_chat(7,'Spied mobs set to '..command..'.')
		setting = command
	else
		local custom = table.concat(cmd, ' ')
		windower.add_to_chat(7,'Setting not found, spying for: '..custom..'.')
		SpiedMobs.custom = S{custom}
		setting = 'custom'
    end

end)

function Spy()
	if spy then
		local player = windower.ffxi.get_player()
		local mobs = windower.ffxi.get_mob_array()
		local best_match
		for i, mob in pairs(mobs) do
			if (SpiedMobs[setting]:contains(mob.name) or SpiedMobs[setting]:contains(tostring(mob.id))) and mob.valid_target and (math.sqrt(mob.distance) < 50) then
				--windower.add_to_chat(7,mob.name)
				if best_match == nil or (found:contains(best_match.id) and not found:contains(mob.id)) or mob.distance < best_match.distance then
					best_match = mob
					--windower.add_to_chat(7,'new best: '..best_match.name..'')
				end
			end
		end

		if best_match ~= nil then
			local self_vector = windower.ffxi.get_mob_by_id(player.id)
			local angle = (math.atan2((best_match.y - self_vector.y), (best_match.x - self_vector.x))*180/math.pi)*-1

			if player.target_index == nil then windower.ffxi.turn((angle):radian())	end

			if not found:contains(best_match.id) then
				--windower.add_to_chat(7,'targetting: '..best_match.name..'')
				if player.target_index == nil then
					packets.inject(packets.new('incoming', 0x058, {
						['Player'] = player.id,
						['Target'] = best_match.id,
						['Player Index'] = player.index,
					}))
				end

				if report then
					windower.chat.input('/p Found ['..best_match.name..'] at <pos>!')
				else
					windower.add_to_chat(7,'iSpy: Found: ['..best_match.name..'] !')
				end

				found[found_index] = best_match.id
				if found_index > 3 then
					found_index = 1
				else
					found_index = found_index + 1
				end
			end

			local direction = (angle):radian()
			local directionText = "None"
			if direction < 0.3925 and direction > -0.3925 then directionText = "E"
			elseif direction >= 0.3925 and direction < 1.1775 then directionText = "SE"
			elseif direction >= 1.1775 and direction < 1.9625 then directionText = "S"
			elseif direction >= 1.9625 and direction < 2.7475 then directionText = "SW"
			elseif direction >= 2.7475 or ( direction > -3.14 and direction < -2.7475 ) then directionText = "W"
			elseif direction >= -2.7475 and direction < -1.9625 then directionText = "NW"
			elseif direction >= -1.9625 and direction < -1.1775 then directionText = "N"
			elseif direction >= -1.1775 and direction < -0.3925 then directionText = "NE" end

			update_displaybox(best_match.name, directionText, math.floor(math.sqrt(best_match.distance)))
		else
			displayBox:hide()
		end
	end
end

function create_display()
    if displayBox then displayBox:destroy() end

	local windowersettings = windower.get_windower_settings()
	x = (windowersettings["ui_x_res"] / 2) - 80
	y = windowersettings["ui_y_res"] * (3/4)

    displayBox = texts.new()
    displayBox:pos(x,y)
    displayBox:font('Arial')--Arial
    displayBox:size(12)
    displayBox:bold(true)
    displayBox:bg_alpha(0)--128
    displayBox:right_justified(false)
    displayBox:stroke_width(2)
    displayBox:stroke_transparency(192)

    update_displaybox()
end

function update_displaybox(name, direction, distance)

    -- Define colors for text in the display
    local clr = {
        h='\\cs(255,192,0)', -- Yellow for active booleans and non-default modals
		w='\\cs(255,255,255)', -- White for labels and default modals
        n='\\cs(192,192,192)', -- White for labels and default modals
        s='\\cs(96,96,96)' -- Gray for inactive booleans
    }

    local info = {}

    -- Define labels for each modal state
    local labels = {

    }

    displayBox:clear()
	if name and direction and distance then
		displayBox:append("iSpy: "..name.." - "..direction..": "..distance.."")
	end

    -- Update and display current info
    displayBox:update(info)
    displayBox:show()
end

create_display()
Spy:loop(1)
