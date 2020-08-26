_addon.name    = 'RandomMount'
_addon.author  = 'Carleigh/'
_addon.version = '1.0.0 - Beta ALL the way!'
_addon.commands = {'rm'}

res = require('resources')
config = require('config')
owned_kis = {}
owned_mounts = {}
settings = config.load({
['prevent_music'] = 0
})


-- Use the below data to set example key items and mounts for quick and easy debugging of the for loops.
--
-- owned_kis = { --tmp test data
--   3073, --raptor mount
--   3082, --beetle
--   3076, --red crab
-- }
-- res.key_items = {
--   [3056] = {id=3056,en="Mog Kupon W-EMI",ja="クーポンW-EMI",category="Temporary Key Items"},
--   [3073] = {id=3073,en="♪Raptor companion",ja="♪ラプトル",category="Mounts"},
--   [3082] = {id=3082,en="♪Beetle companion",ja="♪甲虫",category="Mounts"},
--   [3055] = {id=3055,en="trainer's whistle",ja="呼子霊笛",category="Mounts"},
--   [3076] = {id=3076,en="♪Red crab companion",ja="♪赤クラブ",category="Mounts"},
-- }
-- res.mounts = {
--   [1] = {id=1,en="Raptor",ja="ラプトル",endesc="Calls forth a raptor.",icon_id=87,jadesc="ラプトルを呼び出す。",prefix="/mount"},
--   [10] = {id=10,en="Beetle",ja="甲虫",endesc="Calls forth a beetle.",icon_id=87,jadesc="甲虫を呼び出す。",prefix="/mount"},
--   [3] = {id=3,en="Crab",ja="クラブ",endesc="Calls forth a crab.",icon_id=87,jadesc="クラブを呼び出す。",prefix="/mount"},
--   [4] = {id=4,en="Red Crab",ja="赤クラブ",endesc="Calls forth a red crab.",icon_id=87,jadesc="赤クラブを呼び出す。",prefix="/mount"}, --in test data due to duplication of "crab"
-- }

-- Returns all key items under the "mount" category
function get_mount_kis_from_resources()
local mount_kis = {}
for _, ki in pairs(res.key_items) do
  if ki.category == "Mounts" then
    table.insert(mount_kis, ki.en)
  end
end

return mount_kis
end


-- Returns all mounts owned by the player
function get_owned_mounts()
if #owned_mounts == 0 then
  -- Generates a list of owned mounts by inserting the command name into a 'owned mounts' table
  -- to add mounts copy the line and change the mount name to be as it is displayed in the game
      table.insert(owned_mounts, 'Raptor');
      table.insert(owned_mounts, 'Red Crab');
      table.insert(owned_mounts, 'Dhalmel');
      table.insert(owned_mounts, 'Crawler');
      table.insert(owned_mounts, 'Tulfaire');
      table.insert(owned_mounts, 'Hippogryph');
      table.insert(owned_mounts, 'Coeurl');
      table.insert(owned_mounts, 'Fenrir');
      table.insert(owned_mounts, 'Bomb');
      table.insert(owned_mounts, 'Tiger');
      table.insert(owned_mounts, 'Beetle');

      table.insert(owned_mounts, 'Raaz');
      table.insert(owned_mounts, 'Spheroid');
      table.insert(owned_mounts, 'Xzomit');
      --table.insert(owned_mounts, 'Ram');


      ---- Not yet owned mounts
      -- table.insert(owned_mounts, 'Chocobo');
      -- table.insert(owned_mounts, 'Crab');
      -- table.insert(owned_mounts, 'Moogle');
      -- table.insert(owned_mounts, 'Spectral Chair');
      -- table.insert(owned_mounts, 'Omega');
      -- table.insert(owned_mounts, 'Levitus');
      -- table.insert(owned_mounts, 'Adamantoise');
      --Dont like --  table.insert(owned_mounts, 'Warmachine');
      --Dont like --  table.insert(owned_mounts, 'Morbol');
      --Dont like --  table.insert(owned_mounts, 'Goobbue');
      --Dont like --  table.insert(owned_mounts, 'Magic Pot');
  end
return owned_mounts
end

-- Check on each tick of game time to see if there are KIs loaded or new ones obtained
-- windower.register_event('time change', function()
-- local ki_check = windower.ffxi.get_key_items()
-- if table.getn(ki_check) > table.getn(owned_kis) or table.getn(owned_kis) == 0 then --player loading or new KI obtained
--   owned_kis = windower.ffxi.get_key_items()
-- end
-- end)

-- Generate random numbers based on the OS time
math.randomseed(os.time())

-- When player uses //rm [setting]
windower.register_event('addon command', function(...)
local args = {...}
if args[1] == nil then
  local player = windower.ffxi.get_player()
  local was_mounted = false

  -- If the player is mounted, dismount now
  for _, buff in pairs(player.buffs) do
    if buff == 252 then --mounted buff
      windower.send_command('send @all /dismount')
      was_mounted = true
    end
  end

  -- If the player was not mounted, attempt to select a random mount
  if was_mounted == false then
    local mounts = get_owned_mounts()

    -- If no KIs are found, use the raptor as a fallback. Player may have just logged in and KIs are still loading.
    if table.getn(mounts) == 0 then
      windower.add_to_chat(4, 'Unable to find mounts. Using raptor mount instead.')
      windower.add_to_chat(4, 'Maybe key items have not loaded yet.')
      windower.send_command('send @all /mount raptor')
      -- print('/mount raptor')
      return
    end

    -- Generate random number and use it to choose a mount
    local mount_index = math.ceil(math.random() * table.getn(mounts))
    windower.send_command('input /mount ' .. mounts[mount_index])
    windower.send_command("wait .01; send @all /mount raptor")
    -- print('/mount ' .. mounts[mount_index].en)
  end
elseif args[1] == 'music' then
  -- Toggle mount music
  if settings.prevent_music == 1 then
    print('RandomMount: Mount music enabled')
    settings.prevent_music = 0
  else
    print('RandomMount: Mount music disabled')
    settings.prevent_music = 1
  end
end
end)

-- Prevent mount music from activating if settings.prevent_music is 1
windower.register_event('incoming chunk', function(id, data)
if id == 0x5F and data:byte(5) == 4 and data:byte(7) == 84 and settings.prevent_music == 1 then
  return true
end
end)

windower.register_event('gain buff', function(buff_id)
if buff_id == 252 then
  windower.send_command('timers c Mount 60 down')
end
end)
