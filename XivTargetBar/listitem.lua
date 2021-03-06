--[[
	Copyright © 2020, Tylas
	All rights reserved.

	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:

		* Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		* Redistributions in binary form must reproduce the above copyright
		  notice, this list of conditions and the following disclaimer in the
		  documentation and/or other materials provided with the distribution.
		* Neither the name of XivParty nor the
		  names of its contributors may be used to endorse or promote products
		  derived from this software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
	DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

local bar = require('bar')

local listitem = {}
listitem.__index = listitem

function listitem:init()
	utils:log('Initializing party list element', 1)

	local obj = {}
	setmetatable(obj, listitem) -- make handle lookup

	obj.hidden = false

	obj.hpBar = bar:init(layout.bar.hp)
	--obj.mpBar = bar:init(layout.bar.mp)
	--obj.tpBar = bar:init(layout.bar.tp)

	obj.hpText = utils:createText(layout.text.numbers, true)
	--obj.mpText = utils:createText(layout.text.numbers, true)
	--obj.tpText = utils:createText(layout.text.numbers, true)

	obj.nameText = utils:createText(layout.text.name)
	obj.zoneText = utils:createText(layout.text.zone)

	--obj.jobText = utils:createText(layout.text.job)
	--obj.subJobText = utils:createText(layout.text.subJob)

	-- obj.rangeInd = utils:createImage(layout.range.img, layout.scale)
	-- obj.rangeInd:opacity(0)
	-- obj.rangeInd:show()
	obj.isInRange = false

	-- obj.cursor = utils:createImage(layout.cursor.img, layout.scale)
	-- obj.cursor:opacity(0)
	-- obj.cursor:show()
	-- obj.isSelected = false
	-- obj.isSubTarget = false

	obj.numbersColor = utils:colorFromHex(layout.text.numbers.color)
	obj.nameColor = utils:colorFromHex(layout.text.name.color)
	--obj.tpFullColor = utils:colorFromHex(layout.text.tpFullColor)
	obj.hpYellowColor = utils:colorFromHex(layout.text.hpYellowColor)
	obj.hpOrangeColor = utils:colorFromHex(layout.text.hpOrangeColor)
	obj.hpRedColor = utils:colorFromHex(layout.text.hpRedColor)


	obj.barOffset = utils:coord(layout.bar.offset)
	obj.rangeOffset = utils:coord(layout.range.offset)
	--obj.cursorOffset = utils:coord(layout.cursor.offset)
	--obj.buffOffset = utils:coord(layout.buffIcons.offset)
	--obj.buffSpacing = utils:coord(layout.buffIcons.spacing)
	--obj.buffSize = utils:coord(layout.buffIcons.size)

	obj.numbersOffset = utils:coord(layout.text.numbers.offset)
	obj.nameOffset = utils:coord(layout.text.name.offset)
	obj.zoneOffset = utils:coord(layout.text.zone.offset)
	--obj.jobOffset = utils:coord(layout.text.job.offset)
	--obj.subJobOffset = utils:coord(layout.text.subJob.offset)

	-- obj.buffImages = {}
	-- for i = 1, 32 do
	-- 	obj.buffImages[i] = img:init('', obj.buffSize.x, obj.buffSize.y, layout.scale)
	-- 	obj.buffImages[i]:opacity(0)
	-- 	obj.buffImages[i]:show()
	-- end
	-- obj.currentBuffs = {}

	return obj
end

function listitem:dispose()
	utils:log('Disposing party list element', 1)

	self.hpBar:dispose()
	--self.mpBar:dispose()
	--self.tpBar:dispose()

	texts.destroy(self.hpText)
	--texts.destroy(self.mpText)
	--texts.destroy(self.tpText)

	texts.destroy(self.nameText)
	texts.destroy(self.zoneText)

	--texts.destroy(self.jobText)
	--texts.destroy(self.subJobText)

	--self.rangeInd:dispose()
	--self.cursor:dispose()

	-- for i = 1, 32 do
	-- 	self.buffImages[i]:dispose()
	-- end

	setmetatable(self, nil)
end

function listitem:pos(x, y)
	local hpPosX = x + self.barOffset.x
--	local mpPosX = hpPosX + self.hpBar.size.width + layout.bar.spacingX
--	local tpPosX = mpPosX + self.mpBar.size.width + layout.bar.spacingX

	self.hpBar:pos(hpPosX, y + self.barOffset.y)
--	self.mpBar:pos(mpPosX, y + self.barOffset.y)
--	self.tpBar:pos(tpPosX, y + self.barOffset.y)

	--self.cursor:pos(hpPosX - self.cursor:scaledSize().width + self.cursorOffset.x, y + self.cursorOffset.y)

	-- right aligned text coordinates start at the right side of the screen
	local screenResX = windower.get_windower_settings().ui_x_res

    self.hpText:pos(hpPosX - screenResX + self.hpBar.size.width + self.numbersOffset.x, y + self.numbersOffset.y)
--	self.mpText:pos(mpPosX - screenResX + self.mpBar.size.width + self.numbersOffset.x, y + self.numbersOffset.y)
--	self.tpText:pos(tpPosX - screenResX + self.tpBar.size.width + self.numbersOffset.x, y + self.numbersOffset.y)

	self.nameText:pos(hpPosX + self.nameOffset.x, y + self.nameOffset.y)
	--self.zoneText:pos(tpPosX + self.zoneOffset.x, y + self.zoneOffset.y)
	--self.jobText:pos(hpPosX + self.jobOffset.x, y + self.jobOffset.y)
	--self.subJobText:pos(hpPosX + self.subJobOffset.x, y + self.subJobOffset.y)

	--self.rangeInd:pos(hpPosX + self.rangeOffset.x, y + self.rangeOffset.y)

	-- for i = 1, 32 do
	-- 	if i <= layout.buffIcons.wrap then -- wrap buffs to next line
	-- 		self.buffImages[i]:pos(
	-- 			tpPosX + (i - 1) * (self.buffImages[i]:scaledSize().width + self.buffSpacing.x) + self.buffOffset.x,
	-- 			y + self.buffOffset.y)
	-- 	else
	-- 		self.buffImages[i]:pos(
	-- 			tpPosX + (i - layout.buffIcons.wrap + layout.buffIcons.wrapOffset - 1) *
	-- 			(self.buffImages[i]:scaledSize().width + self.buffSpacing.x) + self.buffOffset.x,
	-- 			y + self.buffOffset.y + self.buffImages[i]:scaledSize().height + self.buffSpacing.y)
	-- 	end
	-- end
end

function listitem:update(player)

	local target = windower.ffxi.get_mob_by_target('t')
	local mainPlayer = windower.ffxi.get_player()
	local nameColor = self.nameColor

	if target then
	self:updateBarAndText(self.hpBar, self.hpText, target.hpp, target.distance, 'hp')

	self.nameText:text(target.name)


	self.zoneText:text(player.zone)
	self:select(player.isSelected, player.isSubTarget)
	self.isInRange = settings.rangeIndicator > 0 and player.distance:sqrt() <= settings.rangeIndicator
	self:updateRange()
	end

	-- if player then
	-- 	self:updateBarAndText(self.hpBar, self.hpText, player.hp, player.hpp, player.distance, 'hp')
	-- 	--self:updateBarAndText(self.mpBar, self.mpText, player.mp, player.mpp, player.distance, 'mp')
	-- 	--self:updateBarAndText(self.tpBar, self.tpText, player.tp, player.tpp, player.distance, 'tp')
	--
	-- 	self.nameText:text(player.name)
	-- 	self.zoneText:text(player.zone)
	--
	-- 	self:select(player.isSelected, player.isSubTarget)
	-- 	--self:updateBuffs(player.filteredBuffs)
	--
	-- 	self.isInRange = settings.rangeIndicator > 0 and player.distance:sqrt() <= settings.rangeIndicator
	-- 	self:updateRange()
	--
	-- 	-- if player.jobLvl > 0 then
	-- 	-- 	self.jobText:text(player.job) --..' '..tostring(player.jobLvl)) --remove main job level Mary
	-- 	-- else
	-- 	-- 	self.jobText:text('')
	-- 	-- end
	--
	-- 	-- if player.subJobLvl > 0 then
	-- 	-- 	self.subJobText:text(player.subJob) --..' '..tostring(player.subJobLvl)) --remove subjob level Mary
	-- 	-- else
	-- 	-- 	self.subJobText:text('')
	-- 	-- end
	-- end
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function listitem:updateBarAndText(bar, text, valPercent, distance, barType)
	bar:update(valPercent / 100)

	local target = windower.ffxi.get_mob_by_target('t')
	local me = windower.ffxi.get_mob_by_target('me')
	local mainPlayer = windower.ffxi.get_player()

	local color = self.numbersColor
	local playerMovementSpeed = round(100*(me.movement_speed / 5 - 1),1)
	local targetMovementSpeed = round(100*(target.movement_speed / 5 - 1),1)

	if valPercent < 0  or target.spawn_type == 2 or target.spawn_type == 34 then --or not (target and target.valid_target and (target.claim_id ~= 0 or target.spawn_type == 16)) then
		text:text('')
	else

		-- if targetMovementSpeed > playerMovementSpeed then
		-- 	text:text(tostring(valPercent)..'%   Speed:'..targetMovementSpeed)
		-- else
				text:text(tostring(valPercent)..'%')
		--end
	end

	if barType == 'hp' then
		if valPercent >= 0 then
			if valPercent < 25 then
				self.hpBar:changeFg('assets/hp_25.png') --- Addition made by the great MASTER NICHOLAS!!
				color = self.hpRedColor
			elseif valPercent < 50 then
				self.hpBar:changeFg('assets/hp_50.png') --- Addition made by the great MASTER NICHOLAS!!
				color = self.hpOrangeColor
			elseif valPercent < 75 then
				self.hpBar:changeFg('assets/hp_75.png') --- Addition made by the great MASTER NICHOLAS!!
				color = self.hpYellowColor
			else
				self.hpBar:changeFg('assets/hp_fg.png')
			end
		end
		if target.spawn_type == 2 or target.spawn_type == 34 then --if npc or door
				self.hpBar:changeFg('assets/mp_fg.png') --- Addition made by the great MASTER NICHOLAS!!
		end
	-- elseif barType == 'tp' then
	-- 	if val >= 1000 then
	-- 		color = self.tpFullColor
	-- 		self.tpBar:changeFg('assets/tp_full.png')
	-- 	else
	-- 		self.tpBar:changeFg('assets/tp_fg.png')
	-- 	end
	end

	text:color(color.r, color.g, color.b)
	text:alpha(color.a)

	-- distance indication
	if distance:sqrt() > 50 then -- cannot target, over 50 distance, mob table not set
		bar:opacity(0.25)
	elseif distance:sqrt() > 20.79 then -- out of heal range
		bar:opacity(0.5)
	else
		bar:opacity(1)
	end
end

function listitem:select(isSel, isSub)
	if self.isSelected == isSel and self.isSubTarget == isSub then return end

	self.isSelected = isSel
	self.isSubTarget = isSub

	--self:updateCursor()
end

function listitem:updateRange()
	if self.isInRange then
		--self.rangeInd:opacity(1)
	else
		--self.rangeInd:opacity(0)
	end
end

-- function listitem:updateCursor()
-- 	if self.isSelected then
-- 		self.cursor:opacity(1)
-- 	elseif self.isSubTarget then
-- 		self.cursor:opacity(0.5)
-- 	else
-- 		self.cursor:opacity(0)
-- 	end
-- end

-- function listitem:updateBuffs(buffs)
-- 	for i = 1, 32 do
-- 		local image = self.buffImages[i]
-- 		local buff = buffs[i]
-- 		local current = self.currentBuffs[i]
--
-- 		if current ~= buff then -- only update if actually changed
-- 			if not buff or buff == 1000 or buff == 255 then
-- 				image:path('')
-- 				image:opacity(0)
-- 			else
-- 				image:path(windower.addon_path .. layout.buffIcons.path .. tostring(buff) .. '.png')
-- 				image:opacity(1)
-- 			end
--
-- 			self.currentBuffs[i] = buff
-- 		end
-- 	end
-- end

function listitem:show()
	self.hpBar:show()
	--self.mpBar:show()
	--self.tpBar:show()

	self.hpText:show()
	--self.mpText:show()
	--self.tpText:show()

	self.nameText:show()
	--self.zoneText:show()

	--self.jobText:show()
	--self.subJobText:show()

	--self.rangeInd:show()
	--self.cursor:show()

	-- for i = 1, 32 do
	-- 	self.buffImages[i]:show()
	-- end
end

function listitem:hide()
	self.hpBar:hide()
	--self.mpBar:hide()
	--self.tpBar:hide()

	self.hpText:hide()
	--self.mpText:hide()
	--self.tpText:hide()

	self.nameText:hide()
	--self.zoneText:hide()

	--self.jobText:hide()
	--self.subJobText:hide()

	--self.rangeInd:hide()
	--self.cursor:hide()

	-- for i = 1, 32 do
	-- 	self.buffImages[i]:hide()
	-- end
end

return listitem
