_addon.name = 'Escha'
_addon.author = 'Brax(orig) - KateFF Modified - v 1.0.0.0'
_addon.version = '1.0.0.0'
_addon.command = 'escha'

require('tables')
require('chat')
require('logger')
require('functions')

packets = require('packets')
json  = require('json')
files = require('files')
config = require('config')
db = require('map')
res = require('resources')

npc_name = ""
pkt = {}
all_temp_items = {}
current_temp_items = {}

valid_zones = T{"Escha - Ru'Aun","Escha - Zi'Tah","Reisinjima"}

valid_zones = {

	[288] = {npc="Affi", menu=9701},  -- Escha Zitah
	[289] = {npc="Dremi", menu=9701},  -- Escha RuAun
	[291] = {npc="Shiftrix", menu=9701},  -- Reisinjima
}

canteen_zones = T{"Reisinjima"}
	
canteen_zones = { 
	[291] = {npc="Incantrix", menu=31}, -- Omen 
}


defaults = {}
settings = config.load(defaults)

busy = false


windower.register_event('addon command', function(...)
    local args = T{...}
    local cmd = args[1]
	args:remove(1)
	for i,v in pairs(args) do args[i]=windower.convert_auto_trans(args[i]) end
	local item = table.concat(args," "):lower()
	ki = 0
	
	-- trib
	if cmd == 'trib' then
		if not busy then
			find_missing_ki()
	
			if found_tribulens == 0 then 
				ki = 1
				windower.add_to_chat(8,"Buying KI: Tribulens")
				pkt = validate('Tribulens')
				if pkt then
					busy = true
					poke_npc(pkt['Target'],pkt['Target Index'])
				end
			else
				windower.add_to_chat(8,"You already have Tribulens!")
			end
		end
	-- rads
	elseif cmd == 'rads' then
		if not busy then
			find_missing_ki()
	
			if found_radialens == 0 then 
				ki = 1
				windower.add_to_chat(8,"Buying KI: Radialens")
				pkt = validate('Radialens')
				if pkt then
					busy = true
					poke_npc(pkt['Target'],pkt['Target Index'])
				end
			else
				windower.add_to_chat(8,"You already have Radialens!")
			end
		end
	-- elvorseal
	elseif cmd == 'vorseal' then
		if not busy then
		
			CurBuffs = windower.ffxi.get_player()["buffs"]
			got_vorseal = 0
	 
			for key,val in pairs(CurBuffs) do
				if val == 603 then
					got_vorseal = 1
				end
			end
		
			if got_vorseal == 0 then
				windower.add_to_chat(8,"Getting elvorseal")
				pkt = validate('Elvorseal')
				if pkt then
					busy = true
					
					poke_npc(pkt['Target'],pkt['Target Index'])
				end
			else
				windower.add_to_chat(8,"You already have Vorseal!")
			end
		end
	-- Canteen
	elseif cmd == 'canteen' then
		if not busy then
			find_missing_ki()
	
			--if found_canteen == 0 then 
				ki = 1
				
				windower.add_to_chat(8,"Grabbing Canteen.")
				pkt = validate_canteen('Canteen')
				if pkt then
					busy = true
					poke_npc(pkt['Target'],pkt['Target Index'])
				end

			
			--else
				--windower.add_to_chat(8,"You already have Canteen!")
			--end
		
		end
	elseif cmd == 'buyall' then
		local currentzone = windower.ffxi.get_info()['zone']
		if currentzone == 291 or currentzone == 289 or currentzone == 288 then 
			find_current_temp_items()
			find_missing_temp_items()
			number_of_missing_items = 0
			for countmissing,countitems in pairs(missing_temp_items) do
			    number_of_missing_items = number_of_missing_items +1
			end
			windower.add_to_chat(8,'Number of Missing Items: '..number_of_missing_items)
			if number_of_missing_items ~= 0 then 
				for keya,itema in pairs(missing_temp_items) do
					for keyb,itemb in pairs(db) do
						if itemb.TempItem == 1 then
							if keyb == itema then
								local item = itemb.Name:lower()
								windower.add_to_chat(8,'Buying Temp Item:'..item)
								if not busy then
									pkt = validate(item)
									if pkt then
										busy = true
										poke_npc(pkt['Target'],pkt['Target Index'])
									else 
										windower.add_to_chat(2,"Can't find item in menu")
									end
								else
									windower.add_to_chat(2,"Still buying last item")
								end
								sleepcounter = 0
								while busy and sleepcounter < 5 do
									coroutine.sleep(1)
									sleepcounter = sleepcounter + 1
									if sleepcounter == "4" then
										windower.add_to_chat(2,"Probably lost a packet, waited too long!")
									end
								end
							end
						end
					end
				end
			end
		else 
		  windower.add_to_chat(8,'You are not in a Gaes Fete Area')
		end
	
	elseif cmd == 'listtemp' then
		local currentzone = windower.ffxi.get_info()['zone']
		if currentzone == 291 or currentzone == 289 or currentzone == 288 then 
			find_current_temp_items()
			find_missing_temp_items()
			number_of_missing_items = 0
			for countmissing,countitems in pairs(missing_temp_items) do
			    number_of_missing_items = number_of_missing_items +1
			end
			windower.add_to_chat(8,'Number of Missing Items: '..number_of_missing_items)
		else 
			windower.add_to_chat(8,'You are not in a Gaes Fete Area')
		end
			
	elseif cmd == 'reset' then
		reset_me()	
	
	else 
		  windower.add_to_chat(8,'Not a command!')
	end
end)

function validate_canteen(item)
	local zone = windower.ffxi.get_info()['zone']
	local me,target_index,target_id,distance
	local result = {}

	if canteen_zones[zone] then
		for i,v in pairs(windower.ffxi.get_mob_array()) do
			if v['name'] == windower.ffxi.get_player().name then
				result['me'] = i
			elseif v['name'] == canteen_zones[zone].npc then
				target_index = i
				target_id = v['id']
				npc_name = v['name']
				result['Menu ID'] = canteen_zones[zone].menu
				distance = windower.ffxi.get_mob_by_id(target_id).distance
			end
		end

		if math.sqrt(distance)<6 then
            local ite = fetch_db(item)
			
			if ite then
				result['Target'] = target_id
				result['Option Index'] = ite['Option']
				result['_unknown1'] = ite['Index']
				result['Target Index'] = target_index
				result['Zone'] = zone 
															log(ite['Option'],ite['Index'])
			end
		else
		windower.add_to_chat(10,"Too far from Omen npc")
		end
	else
	windower.add_to_chat(10,"Not in Reisinjima for Omen npc")
	end
	if result['Zone'] == nil then result = nil end
	return result


end


function validate(item)
	local zone = windower.ffxi.get_info()['zone']
	local me,target_index,target_id,distance
	local result = {}

	if valid_zones[zone] then
		for i,v in pairs(windower.ffxi.get_mob_array()) do
			if v['name'] == windower.ffxi.get_player().name then
				result['me'] = i
			elseif v['name'] == valid_zones[zone].npc then
				target_index = i
				target_id = v['id']
				npc_name = v['name']
				result['Menu ID'] = valid_zones[zone].menu
				distance = windower.ffxi.get_mob_by_id(target_id).distance
			end
		end

		if math.sqrt(distance)<6 then
            local ite = fetch_db(item)
			if ite then
				result['Target'] = target_id
				result['Option Index'] = ite['Option']
				result['_unknown1'] = ite['Index']
				result['Target Index'] = target_index
				result['Zone'] = zone 
			end
		else
		windower.add_to_chat(10,"Too far from npc")
		end
	else
	windower.add_to_chat(10,"Not in a zone with proper npc")
	end
	if result['Zone'] == nil then result = nil end
	return result
end




function fetch_db(item)

 for i,v in pairs(db) do

  if string.lower(v.Name) == string.lower(item) then

	return v

  end

 end

end

function find_all_tempitems()
	for i,v in pairs(db) do
		if v.TempItem == 1 then
			all_temp_items[#all_temp_items+1] = i
		end
	end
end


function find_current_temp_items()
	 count = 0
	 current_temp_items = {}
	 tempitems = windower.ffxi.get_items().temporary
	 for key,item in pairs(tempitems) do

		 if key ~= 'max' and key ~= 'count'  and key ~= 'enabled' then
			for ida,itema in pairs(item) do
				if itema ~= 0 and ida == 'id' then 
					count = count + 1
					current_temp_items[#current_temp_items+1] = itema
				end
			end
		 end
	 end
end

function find_missing_temp_items()
	 missing_temp_items = {}
	 for key,item in pairs(all_temp_items) do
		itemmatch = 0
		for keya,itema in pairs(current_temp_items) do
			if item == itema then
				itemmatch = 1
			end
		end
		if itemmatch == 0 then
			missing_temp_items[#missing_temp_items+1] = item
		end
	 end
end

function find_missing_ki()
	missing_ki = {}
 	
	found_radialens = 0
	found_tribulens = 0
	found_canteen = 0
	local keyitems = windower.ffxi.get_key_items()
	for id,ki in pairs(keyitems) do
		if ki == 3031 then
			found_radialens = 1
		elseif ki == 2894 then
			found_tribulens = 1
		elseif ki == 3137 then
			found_canteen = 1
		end
	end

end


windower.register_event('incoming chunk',function(id,data,modified,injected,blocked)

	if id == 0x034 or id == 0x032 then

	 if busy == true and pkt then

		local packet = packets.new('outgoing', 0x05B)

		-- request item
		packet["Target"]=pkt['Target']

		if npc_name ~= 'Dremi' and npc_name ~= 'Affi' and npc_name ~= 'Shiftrix' and npc_name ~= 'Incantrix' then
			packet["Option Index"]=pkt['Option Index']
			packet["_unknown1"]=pkt['_unknown1']
			packet["Target Index"]=pkt['Target Index']
			packet["Automated Message"]=true
			packet["_unknown2"]=0
			packet["Zone"]=pkt['Zone']
			packet["Menu ID"]=pkt['Menu ID']
			packets.inject(packet)
			
			local packet = packets.new('outgoing', 0x05B)
			packet["Target"]=pkt['Target']
			packet["Option Index"]=0
			packet["_unknown1"]=16384
			packet["Target Index"]=pkt['Target Index']
			packet["Automated Message"]=false
			packet["_unknown2"]=0
			packet["Zone"]=pkt['Zone']
			packet["Menu ID"]=pkt['Menu ID']
			packets.inject(packet)
			
		else  -- reisinjima does it different....

			packet["Option Index"]=pkt['Option Index']
			packet["_unknown1"]=pkt['_unknown1']
			packet["Target Index"]=pkt['Target Index']
			packet["Automated Message"]=true
			packet["_unknown2"]=0
			packet["Zone"]=pkt['Zone']
			packet["Menu ID"]=pkt['Menu ID']
																		log(pkt['Target Index'],pkt['Menu ID'],pkt['Zone'],pkt['me'])
			packets.inject(packet)
			if ki == 0 then
				--log(pkt['Target'], pkt['_unknown1'], pkt['Target Index'])
				packet["Target"]=pkt['Target']
				packet["Option Index"]=14
				packet["_unknown1"]=pkt['_unknown1']
				packet["Target Index"]=pkt['Target Index']
				packet["Automated Message"]=true
				packet["_unknown2"]=0
				packet["Zone"]=pkt['Zone']
				packet["Menu ID"]=pkt['Menu ID']
				packets.inject(packet)
			elseif ki == 1 then 
				packet["Target"]=pkt['Target']
				packet["Option Index"]=3
				packet["_unknown1"]=pkt['_unknown1']
				packet["Target Index"]=pkt['Target Index']
				packet["Automated Message"]=true
				packet["_unknown2"]=0
				packet["Zone"]=pkt['Zone']
				packet["Menu ID"]=pkt['Menu ID']
				packets.inject(packet)
			end 
		-- send exit menu
			packet["Target"]=pkt['Target']
			packet["Option Index"]=0
			packet["_unknown1"]=pkt['_unknown1']
			packet["Target Index"]=pkt['Target Index']
			packet["Automated Message"]=false
			packet["_unknown2"]=0
			packet["Zone"]=pkt['Zone']
			packet["Menu ID"]=pkt['Menu ID']
			packets.inject(packet)
		end
		

		local packet = packets.new('outgoing', 0x016, {["Target Index"]=pkt['me'],})
		packets.inject(packet)
		busy = false
		lastpkt = pkt
		pkt = {}
		return true
	 end
	end

end)

function reset_me()
	local packet = packets.new('outgoing', 0x05B)
	packet["Target"]=lastpkt['Target']
	packet["Option Index"]=lastpkt['Option Index']
	packet["_unknown1"]="16384"
	packet["Target Index"]=lastpkt['Target Index']
	packet["Automated Message"]=false
	packet["_unknown2"]=0
	packet["Zone"]=lastpkt['Zone']
	packet["Menu ID"]=lastpkt['Menu ID']
	packets.inject(packet)
end


function poke_npc(npc,target_index)

	if npc and target_index then

		local packet = packets.new('outgoing', 0x01A, {
			["Target"]=npc,
			["Target Index"]=target_index,
			["Category"]=0,
			["Param"]=0,
			["_unknown1"]=0})
		packets.inject(packet)

	end

end

windower.register_event('load', function()
	find_all_tempitems()
end)
