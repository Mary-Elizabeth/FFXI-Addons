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

local player_mt = {
    __index = function (_, k)
        if windower.ffxi.get_info().logged_in then
            local player = windower.ffxi.get_player()
            return k == 'state_id' and player.status or player[k]
        end
        return 0
    end,
}

return setmetatable({}, player_mt)

