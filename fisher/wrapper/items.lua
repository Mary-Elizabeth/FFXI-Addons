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

local bags_mt = {
    __index = function (_, k)
        local _items =  windower.ffxi.get_items(k)
        _items.max = nil
        _items.count = nil
        _items.enabled = nil
        for i = 1, #_items do
            _items[i].bag = k
            _items[i].index = _items[i].slot
            _items[i].slot = nil
        end
        return _items
    end,
}

local sizes_mt = {
    __index = function (_, k)
        return windower.ffxi.get_items(k).max
    end,
}

local items = {
    bags = setmetatable({}, bags_mt),
    sizes = setmetatable({}, sizes_mt),
}

return items

