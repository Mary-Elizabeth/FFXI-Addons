_addon.name     = 'unmi'
_addon.author   = 'Elidyr'
_addon.version  = '1.20191220'
_addon.command  = 'unmi'

packets = require 'packets'
require 'tables'

local f,ff = false, false
local x,y  = nil, 1
local d = false
local uitems = {
    [1]  = {name="Refractive Crystal", choose=3,   buy=8164}, --32, 8192
    [2]  = {name="Gobbiedial Key",     choose=35,  buy=8196},
    [3]  = {name="Instant Warp",       choose=67,  buy=8260},
    [4]  = {name="Instant Raise",      choose=99,  buy=8292},
    [5]  = {name="Instant Protect",    choose=131, buy=8324},
    [6]  = {name="Instant Shell",      choose=163, buy=8356},
    [7]  = {name="Moist Rolanberry",   choose=195, buy=8388},
    [8]  = {name="Ravaged moko Grass", choose=227, buy=8420},
    [9]  = {name="Cavorting Worm",     choose=259, buy=8452},
    [10] = {name="Levigated Rock",     choose=291, buy=8484},
    [11] = {name="Little Lugworm",     choose=323, buy=8516},
    [12] = {name="Training Manual",    choose=355, buy=8548},
    [13] = {name="Prize Powder",       choose=387, buy=8580},
    [13] = {name="Pieuje",             choose=419, buy=8612},
    [13] = {name="Ayame",              choose=451, buy=8644},
    [13] = {name="Invincible Shield",  choose=483, buy=8676},
    [13] = {name="Apururu",            choose=515, buy=8708},
    [13] = {name="Maat",               choose=547, buy=8740},
    [13] = {name="Aldo",               choose=579, buy=8772},
    [13] = {name="Jakoh Wahcondalo",   choose=611, buy=8804},
    [13] = {name="Naja Salaheem",      choose=643, buy=8836},
    [13] = {name="Flaviria",           choose=675, buy=8868},
    [13] = {name="Yoran-Oran",         choose=707, buy=8900},
    [13] = {name="Sylvie",             choose=739, buy=8932},
}
local npcs = {
    [230]={id={17719646},menuid=3529},
    [235]={id={17739961},menuid=598},
    [241]={id={17764611,17764612},menuid=879},
    [256]={id={17826181},menuid=5149},
}

--Commands Handler.
windower.register_event('addon command', function(...)
    local a = T{...}
    if a[1] then
        local c = a[1]:lower() or false
        if c == "buy" then
            if a[2] then
                local target = getNPC(npcs)
                x = a[2]:lower() or false
                y = tonumber(a[3]) or 1
                poke(target)
            end
        elseif c == "reload" or c == "r" then
            windower.send_command('lua reload unmi')
        else
            windower.add_to_chat(10,"Invalid commands used!")
        end
    else
        windower.add_to_chat(10,"Invalid commands used!")
    end
end)

windower.register_event('incoming chunk',function(id,data,modified,injected,blocked)

    if id == 0x032 or id == 0x034 and f then
        local target = getNPC(npcs)
        if target and math.sqrt(target.distance) < 6 then
            if d then print("Buying...") end
            buyItem(x,y)
        end
        return true
    elseif id == 0x032 or id == 0x034 and f then
        f,x,y = nil,nil,nil
    end

end)

windower.register_event('outgoing chunk',function(id,data,modified,injected,blocked)

    if id == 0x05B and f and ff then
        if d then print("Resetting Status") end
        f, ff, x, y = false, false, nil, nil
    end

end)

function getNPC(npcs)
    for i,v in ipairs(npcs[windower.ffxi.get_info().zone]['id']) do
        if windower.ffxi.get_mob_by_id(v) then
            return windower.ffxi.get_mob_by_id(v)
        end
    end
    return false
end

function getMenuID()
    if npcs[windower.ffxi.get_info().zone] then
        return npcs[windower.ffxi.get_info().zone].menuid
    end
    return false
end

function poke(target)
    if target then
        local poke = packets.new('outgoing', 0x1a, {
            ['Target'] = target.id,
            ['Target Index'] = target.index,
        })
        f = true
        packets.inject(poke)
        if d then print("Poking...") end
    end
    return false
end

function buyItem(item, q)
    for i,v in pairs(uitems) do
        if type(v) == 'table' then
            for ii,vv in pairs(v) do
                if ii == "name" then
                    local target = getNPC(npcs)
                    local name = item:lower()
                    local compare = vv:lower()
                    local zone = windower.ffxi.get_info().zone
                    local menuid = getMenuID()
                    if name and compare and name == compare:match(name) then
                        if q == 1 then
                            quantity = v.buy
                        else
                            quantity = (v.buy+(8192*(q-1)))
                        end
                        if d then print("Target: " .. target.name .. ", Item: " .. item .. ", Quantity: " .. q .. ", Zone: " .. zone .. ", Menu ID: " .. menuid .. ".") end
                        local items = packets.new('outgoing', 0x05b, {
                            ['Target']            = target.id,
                            ['Option Index']      = 10,
                            ['Target Index']      = target.index,
                            ['Automated Message'] = true,
                            ['Zone']              = windower.ffxi.get_info().zone,
                            ['Menu ID']           = menuid,
                        })
                        packets.inject(items)

                        local choose = packets.new('outgoing', 0x05b, {
                            ['Target']            = target.id,
                            ['Option Index']      = v.choose,
                            ['Target Index']      = target.index,
                            ['Automated Message'] = true,
                            ['Zone']              = windower.ffxi.get_info().zone,
                            ['Menu ID']           = menuid,
                        })
                        packets.inject(choose)

                        local buy = packets.new('outgoing', 0x05b, {
                            ['Target']            = target.id,
                            ['Option Index']      = quantity,
                            ['Target Index']      = target.index,
                            ['Automated Message'] = true,
                            ['Zone']              = windower.ffxi.get_info().zone,
                            ['Menu ID']           = menuid,
                        })
                        packets.inject(buy)

                        local exit = packets.new('outgoing', 0x05b, {
                            ['Target']            = target.id,
                            ['Option Index']      = 0,
                            ['_unknown1']         = 16384,
                            ['Target Index']      = target.index,
                            ['Automated Message'] = false,
                            ['Zone']              = windower.ffxi.get_info().zone,
                            ['Menu ID']           = menuid,
                        })
                        packets.inject(exit)
                        ff = true
                        return true
                    end
                end
            end
        end
    end
    local target = getNPC(npcs)
    local zone = windower.ffxi.get_info().zone
    local menuid = getMenuID()

    local items = packets.new('outgoing', 0x05b, {
        ['Target']            = target.id,
        ['Option Index']      = 10,
        ['Target Index']      = target.index,
        ['Automated Message'] = true,
        ['Zone']              = windower.ffxi.get_info().zone,
        ['Menu ID']           = menuid,
    })
    packets.inject(items)

    local exit = packets.new('outgoing', 0x05b, {
        ['Target']            = target.id,
        ['Option Index']      = 0,
        ['_unknown1']         = 16384,
        ['Target Index']      = target.index,
        ['Automated Message'] = false,
        ['Zone']              = windower.ffxi.get_info().zone,
        ['Menu ID']           = menuid,
    })
    packets.inject(exit)
    ff = true
    windower.add_to_chat(10,"Unable to buy items!")
    return true
end
