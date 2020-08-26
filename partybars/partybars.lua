_addon.author = 'Icy, based off xivbar'
_addon.name = 'PartyBars'
_addon.commands = {'partybars','pbars'}
_addon.version = '1.0.0.0'

config = require('config')
texts  = require('texts')
images = require('images')
res = require('resources')

-- User settings
local defaults = require('defaults')
local settings = defaults
local settings = config.load(defaults)
config.save(settings)

-- Load theme options according to settings
local theme = require('theme')
local theme_options = theme.apply(settings)

local ui = require('ui')
local party = require('party')
local partybars = require('variables')

-- initialize addon
function initialize()
    ui:load(theme_options)

	set_party_info()

    partybars.initialized = true
end

-- update a bar
function update_bar(party_index, bar, text, width, current, pp, flag)
	if flag < 3 then -- don't have a bar for TP so dont try to update it..
		local barwidth = 0
		if flag == 1 then
			barwidth = theme_options.hpbar_width
		else
			barwidth = theme_options.mpbar_width
		end
		
		local old_width = width
		local new_width = math.floor((pp / 100) * barwidth)
		

		if new_width ~= nil and new_width >= 0 then
			if old_width == new_width then
				if new_width == 0 then
					bar:hide()
				end
			else
				local x = old_width

				if old_width < new_width then
					x = old_width + math.ceil((new_width - old_width) * 0.1)

					x = math.min(x, barwidth)
				elseif old_width > new_width then
					x = old_width - math.ceil((old_width - new_width) * 0.1)

					x = math.max(x, 0)
				end

				if flag == 1 then
					party[party_index].hp_bar_width = x
				elseif flag == 2 then
					party[party_index].mp_bar_width = x
				end

				bar:size(x, theme_options.total_height)
				bar:show()
			end
		end
	end
	
	if flag == 6 and current ~= '' then
		text:color(255, 128, 0)
		text:size(14)
	elseif flag == 5 and current ~= '' then
		text:color(160, 160, 160)
		ui[party_index].name_text:color(160, 160, 160)
    elseif flag == 3 and current >= 1000 then
        text:color(theme_options.full_tp_color_red, theme_options.full_tp_color_green, theme_options.full_tp_color_blue)
	elseif flag == 1 and pp <= 75 then
		text:color(255, 255, 0)
	elseif flag == 1 and pp <= 35 then
		text:color(255, 0, 0)
    else
        text:color(theme_options.font_color_red, theme_options.font_color_green, theme_options.font_color_blue)
        if bar and theme_options.dim_tp_bar then bar:alpha(180) end
    end
	
    text:text(tostring(current))
end

-- hide the addon
function hide()
    ui:hide()
    partybars.ready = false
end

-- show the addon
function show()
    if partybars.initialized == false then
        initialize()
    end

    ui:show()
    partybars.ready = true
end

function set_party_info()
	local windower_party = windower.ffxi.get_party()

    if windower_party then
		party.leader_id = windower_party.party1_leader
		party.alliance_id = windower_party.alliance_leader
		
		for i=0, 5 do
			if windower_party['p'..i] then
				local mob = windower_party['p'..i].mob
				if mob and mob.name == windower_party['p'..i].name then
					party['p'..i].id = mob.id
				end
				party['p'..i].is_leader = (party['p'..i].id and party.leader_id == party['p'..i].id) or (party['p'..i].id and party.alliance_id == party['p'..i].id)
				
				party['p'..i].name = windower_party['p'..i].name
				party['p'..i].zone = windower_party['p'..i].zone
				party['p'..i].hpp = windower_party['p'..i].hpp
				party['p'..i].mpp = windower_party['p'..i].mpp
				party['p'..i].current_hp = windower_party['p'..i].hp
				party['p'..i].current_mp = windower_party['p'..i].mp
				party['p'..i].current_tp = windower_party['p'..i].tp
			else
				party['p'..i].id = nil
				party['p'..i].is_leader = false
				party['p'..i].name = nil
				party['p'..i].zone = nil
				party['p'..i].hpp = 0
				party['p'..i].mpp = 0
				party['p'..i].current_hp = 0
				party['p'..i].current_mp = 0
				party['p'..i].current_tp = 0
			end
        end
    end
end

-- Bind Events
-- ON LOAD
windower.register_event('load', function()
    if windower.ffxi.get_info().logged_in then
        initialize()
        show()
    end
end)

-- ON LOGIN
windower.register_event('login', function()
    show()
end)

-- ON LOGOUT
windower.register_event('logout', function()
    hide()
end)

windower.register_event('prerender', function()
    if partybars.ready == false then
        return
    end
	
	if not partybars.busy then
		partybars.busy = true
		
		set_party_info()
		
		for i = 0, 5 do
			if party['p'..i] and party['p'..i].name then
				update_bar('p'..i, ui['p'..i].hp_bar, ui['p'..i].hp_text, party['p'..i].hp_bar_width, party['p'..i].current_hp, party['p'..i].hpp, 1)
				update_bar('p'..i, ui['p'..i].mp_bar, ui['p'..i].mp_text, party['p'..i].mp_bar_width, party['p'..i].current_mp, party['p'..i].mpp, 2)
				update_bar('p'..i, nil, ui['p'..i].tp_text, 0, party['p'..i].current_tp, 0, 3)
				update_bar('p'..i, nil, ui['p'..i].name_text, 0, party['p'..i].name, 0, 4)
				if party['p'..i].is_leader then
					update_bar('p'..i, nil, ui['p'..i].leader_text, 0, '*', 0, 6)
				else
					update_bar('p'..i, nil, ui['p'..i].leader_text, 0, '', 0, 6)
				end
				
				if party['p'..i].zone ~= party['p0'].zone then
					update_bar('p'..i, nil, ui['p'..i].zone_text, 0, res.zones[party['p'..i].zone].en, 0, 5)
					ui['p'..i].hp_text:hide()
					ui['p'..i].mp_text:hide()
					ui['p'..i].tp_text:hide()
				else
					update_bar('p'..i, nil, ui['p'..i].zone_text, 0, '', 0, 5)
					ui['p'..i].hp_bar:show()
					ui['p'..i].mp_bar:show()
					ui['p'..i].hp_text:show()
					ui['p'..i].mp_text:show()
					ui['p'..i].tp_text:show()
					ui['p'..i].name_text:show()
					ui['p'..i].zone_text:show()
				end 
			else
				ui['p'..i].hp_bar:hide()
				ui['p'..i].mp_bar:hide()
				ui['p'..i].hp_text:hide()
				ui['p'..i].mp_text:hide()
				ui['p'..i].tp_text:hide()
				ui['p'..i].name_text:hide()
				ui['p'..i].zone_text:hide()
			end
		end
		
		partybars.busy = false
	end
end)
