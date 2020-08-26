--[[
        Copyright © 2017, SirEdeonX
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

            * Redistributions of source code must retain the above copyright
              notice, this list of conditions and the following disclaimer.
            * Redistributions in binary form must reproduce the above copyright
              notice, this list of conditions and the following disclaimer in the
              documentation and/or other materials provided with the distribution.
            * Neither the name of xivbar nor the
              names of its contributors may be used to endorse or promote products
              derived from this software without specific prior written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
        ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
        WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
        DISCLAIMED. IN NO EVENT SHALL SirEdeonX BE LIABLE FOR ANY
        DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
        (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
        LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
        ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
        (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
        SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]


local ui = {}

local text_setup = {
    flags = {
        draggable = false
    }
}

local images_setup = {
    draggable = false
}

-- ui variables
ui.background = images.new(images_setup)
ui.p0 = {}
ui.p0.hp_bar = images.new(images_setup)
ui.p0.mp_bar = images.new(images_setup)
ui.p0.hp_text = texts.new(text_setup)
ui.p0.mp_text = texts.new(text_setup)
ui.p0.tp_text = texts.new(text_setup)
ui.p0.name_text = texts.new(text_setup)
ui.p0.zone_text = texts.new(text_setup)
ui.p0.leader_text = texts.new(text_setup)

ui.p1 = {}
ui.p1.hp_bar = images.new(images_setup)
ui.p1.mp_bar = images.new(images_setup)
ui.p1.hp_text = texts.new(text_setup)
ui.p1.mp_text = texts.new(text_setup)
ui.p1.tp_text = texts.new(text_setup)
ui.p1.name_text = texts.new(text_setup)
ui.p1.zone_text = texts.new(text_setup)
ui.p1.leader_text = texts.new(text_setup)

ui.p2 = {}
ui.p2.hp_bar = images.new(images_setup)
ui.p2.mp_bar = images.new(images_setup)
ui.p2.hp_text = texts.new(text_setup)
ui.p2.mp_text = texts.new(text_setup)
ui.p2.tp_text = texts.new(text_setup)
ui.p2.name_text = texts.new(text_setup)
ui.p2.zone_text = texts.new(text_setup)
ui.p2.leader_text = texts.new(text_setup)

ui.p3 = {}
ui.p3.hp_bar = images.new(images_setup)
ui.p3.mp_bar = images.new(images_setup)
ui.p3.hp_text = texts.new(text_setup)
ui.p3.mp_text = texts.new(text_setup)
ui.p3.tp_text = texts.new(text_setup)
ui.p3.name_text = texts.new(text_setup)
ui.p3.zone_text = texts.new(text_setup)
ui.p3.leader_text = texts.new(text_setup)

ui.p4 = {}
ui.p4.hp_bar = images.new(images_setup)
ui.p4.mp_bar = images.new(images_setup)
ui.p4.hp_text = texts.new(text_setup)
ui.p4.mp_text = texts.new(text_setup)
ui.p4.tp_text = texts.new(text_setup)
ui.p4.name_text = texts.new(text_setup)
ui.p4.zone_text = texts.new(text_setup)
ui.p4.leader_text = texts.new(text_setup)

ui.p5 = {}
ui.p5.hp_bar = images.new(images_setup)
ui.p5.mp_bar = images.new(images_setup)
ui.p5.hp_text = texts.new(text_setup)
ui.p5.mp_text = texts.new(text_setup)
ui.p5.tp_text = texts.new(text_setup)
ui.p5.name_text = texts.new(text_setup)
ui.p5.zone_text = texts.new(text_setup)
ui.p5.leader_text = texts.new(text_setup)

-- setup images
function setup_image(image, path)
    image:path(path)
    image:repeat_xy(1, 1)
    image:draggable(false)
    image:fit(true)
    image:show()
end

-- setup text
function setup_text(text, theme_options)
    text:bg_alpha(0)
    text:bg_visible(false)
    text:font(theme_options.font)
    text:size(theme_options.font_size)
    text:color(theme_options.font_color_red, theme_options.font_color_green, theme_options.font_color_blue)
    text:stroke_transparency(theme_options.font_stroke_alpha)
    text:stroke_color(theme_options.font_stroke_color_red, theme_options.font_stroke_color_green, theme_options.font_stroke_color_blue)
    text:stroke_width(theme_options.font_stroke_width)
    text:right_justified()
    text:show()
end

-- load the images and text
function ui:load(theme_options)
	setup_image(self.background, theme_options.bar_background)
	for i = 0, 5 do
		setup_image(self['p'..i].hp_bar, theme_options.bar_hp)
		setup_image(self['p'..i].mp_bar, theme_options.bar_mp)
		
		setup_text(self['p'..i].hp_text, theme_options)
		setup_text(self['p'..i].mp_text, theme_options)
		setup_text(self['p'..i].tp_text, theme_options)
		setup_text(self['p'..i].name_text, theme_options)
		setup_text(self['p'..i].zone_text, theme_options)
		setup_text(self['p'..i].leader_text, theme_options)
	end
	
	self:position(theme_options)
end

-- position the images and text
function ui:position(theme_options)
    local x = windower.get_windower_settings().x_res / 2 - (theme_options.total_width / 2) + theme_options.offset_x
    
	local y = windower.get_windower_settings().y_res - 160 + theme_options.offset_y
    self.background:pos(x, y)

	for i = 0, 5 do
		self['p'..i].hp_bar:width(0)
		self['p'..i].mp_bar:width(0)
		self['p'..i].hp_bar:pos(x + 5 + theme_options.hpbar_offset, y + 2 + (theme_options.hpbar_spacing * i))
		self['p'..i].mp_bar:pos(x + 55 + theme_options.mpbar_offset, y + 12 + (theme_options.mpbar_spacing * i))
		self['p'..i].name_text:pos(x - 25 + theme_options.text_offset, self.background:pos_y() - 20)
		self['p'..i].hp_text:pos(x + 55 + theme_options.text_offset, self.background:pos_y() - 18)
		self['p'..i].mp_text:pos(x + 88 + theme_options.text_offset, self.background:pos_y() - 8)
		self['p'..i].tp_text:pos(x - 15 + theme_options.text_offset, self.background:pos_y() - 7)
		self['p'..i].zone_text:pos(x + 35 + theme_options.text_offset, self.background:pos_y() - 15)
		self['p'..i].leader_text:pos(x - 33 + theme_options.text_offset, self.background:pos_y() - 17)
	end
end

-- hide ui
function ui:hide()
    self.background:hide()
	for i = 0, 5 do	
		self['p'..i].hp_bar:hide()
		self['p'..i].hp_text:hide()
		self['p'..i].mp_bar:hide()
		self['p'..i].mp_text:hide()
		self['p'..i].tp_text:hide()
		self['p'..i].name_text:hide()
		self['p'..i].zone_text:hide()
		self['p'..i].leader_text:hide()
	end
end

-- show ui
function ui:show()
	self.background:show()
	for i = 0, 5 do	
		self['p'..i].hp_bar:show()
		self['p'..i].hp_text:show()
		self['p'..i].mp_bar:show()
		self['p'..i].mp_text:show()
		self['p'..i].tp_text:show()
		self['p'..i].name_text:show()
		self['p'..i].zone_text:show()
		self['p'..i].leader_text:show()
	end
end

return ui