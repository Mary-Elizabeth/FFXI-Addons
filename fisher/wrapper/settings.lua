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
local config = require('config')

local options = {}
local defaults = {}

local shared_options = setmetatable({}, {
    __index = function (t, k)
        local settings_path = rawget(t, 'settings_path')
        if settings_path and options[settings_path] then
            return options[settings_path][k]
        end
    end,
    __newindex = function (t, k, v)
        local settings_path = rawget(t, 'settings_path')
        if settings_path and options[settings_path] then
            options[settings_path][k] = v
        end
    end,
})

local function get_settings_path(character)
    return string.format('data/%s.xml', character or windower.ffxi.get_player().name)
end

local function load_options(character)
    local settings_path = get_settings_path(character)
    if not options[settings_path] then
        options[settings_path] = config.load(settings_path, defaults)
    end
    rawset(shared_options, 'settings_path', settings_path)
end

local function save_options()
    local settings_path = get_settings_path()
    if options[settings_path] then
        config.save(options[settings_path], 'all')
    end
end

windower.register_event('login', function (name)
    load_options(name)
end)

local settings = {}

function settings.load(_defaults)
    defaults = _defaults
    if windower.ffxi.get_info().logged_in then
        load_options()
    end
    return shared_options
end

function settings.save()
    if windower.ffxi.get_info().logged_in then
        save_options()
    end
end

return settings

