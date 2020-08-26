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

local equipment_slot_by_id = {
    [0]='main', [1]='sub', [2]='range', [3]='ammo',
    [4]='head', [5]='body', [6]='hands', [7]='legs',
    [8]='feet', [9]='neck', [10]='waist', [11]='left_ear',
    [12]='right_ear', [13]='left_ring', [14]='right_ring', [15]='back',
}

local equipment_mt = {
    __index = function (_, k)
        local _equipment = windower.ffxi.get_items().equipment
        local slot_name = equipment_slot_by_id[k]
        local bag_id = _equipment[slot_name .. '_bag']
        local item = windower.ffxi.get_items(bag_id, _equipment[slot_name])
        item.bag = bag_id
        item.index = item.slot
        item.slot = nil
        return {slot = k, item = item}
    end,
}

return setmetatable({}, equipment_mt)

