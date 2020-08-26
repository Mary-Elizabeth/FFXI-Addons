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
local table = require('table')

local registered_commands = {}

windower.register_event('addon command', function (names, ...)
    local _command = registered_commands[names]
    local args = {...}
    if _command and _command.args then
        if #args > 0 then
            if string.find(_command.args, ':integer%(') then
                args[1] = tonumber(args[1])
                local min, max = string.match(_command.args, ':integer%((%d+),(%d+)%)')
                if not args[1] or args[1] < tonumber(min) or args[1] > tonumber(max) then
                    return
                end
            elseif string.find(_command.args, ':string%(') then
                local pattern = string.match(_command.args, ':string%((.*)%)')
                if not string.find(args[1], '^' .. pattern .. '$') then
                    return
                end
            elseif string.find(_command.args, ':text') then
                args = {table.concat(args, ' ')}
            end
        elseif string.sub(_command.args, 1, 1) == '<' then
            return
        end
    end
    if _command then
        _command.fn(unpack(args))
    end
end)

local command = {}

function command.input(_command)
    _command = string.gsub(_command, '/' .. _addon.command, '//' .. _addon.command)
    windower.send_command('input ' .. _command)
end

function command.new()
    return {
        register = function (_, names, fn, args)
            registered_commands[names] = {fn=fn, args=args}
        end,
    }
end

return command

