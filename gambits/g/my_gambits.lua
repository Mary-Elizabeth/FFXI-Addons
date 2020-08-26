gambits = {}

gambits["WAR"] = {
  --{"SELF","JA_READY","Provoke","JA","Provoke"},
  --{"SELF","NOT_STATUS","Food","ITEM","Maringna"},
  --{"SELF","NOT_STATUS","Hasso","JA","Hasso"},
  --{"SELF","NOT_STATUS","Aggressor","JA","Aggressor"},
  --{"SELF","NOT_STATUS","Defender","JA","Defender"}
}
gambits["DRG"] = {
  {"SELF","NOT_ASSISTING","Aerich","ASSIST",""},
  {"SELF","NOT_ENGAGED","","ATTACK",""}

}
gambits["PUP"] = {
  {"SELF","CAN_SC","Light","WS","Victory Smite"},
  --{"SELF","NOT_STATUS","Defender","JA","Defender"}
  {"SELF","PET_IDLE","","JA","Deploy"},
  {"SELF","FIRE_MANEUVERS <",2,"JA","Fire Maneuver"},
  {"SELF","MANEUVERS <",3,"JA","Light Maneuver"},
 -- {"SELF","NOT_STATUS","Aggressor","JA","Aggressor"},
  --{"SELF","JA_READY","Provoke","JA","Provoke"}
  --{"SELF","SHADOWS <",1,"MA","Utsusemi: Ni"},
  --{"SELF","SHADOWS <",2,"MA","Utsusemi: Ichi"},
  {"SELF","TP >=",1000,"WS","Victory Smite"}
}

gambits["MNK"] = {
  --{"SELF","CAN_SC","Fusion","WS","Shijin Spiral"},
  --{"SELF","NOT_STATUS","Defender","JA","Defender"}
 -- {"SELF","NOT_STATUS","Aggressor","JA","Aggressor"},
  --{"SELF","JA_READY","Provoke","JA","Provoke"}
  {"SELF","SHADOWS <",1,"MA","Utsusemi: Ni"},
  {"SELF","SHADOWS <",2,"MA","Utsusemi: Ichi"},
  {"SELF","TP >=",1000,"WS","Victory Smite"}
}
gambits["PLD"] = {
  --{"SELF","NOT_ASSISTING","Tedreraud","ASSIST",""}
  {"SELF","HPP <=",60,"MA","Cure IV"},
  --{"SELF","SHADOWS <",1,"MA","Utsusemi: Ni"},
  --{"SELF","SHADOWS <",2,"MA","Utsusemi: Ichi"},
  {"SELF","MA_READY","Flash","MA","Flash"},
  {"SELF","NOT_STATUS","Enmity Boost","MA","Crusade"},
  {"SELF","NOT_STATUS","Defense Boost","MA","Cocoon"},

  {"SELF","MA_READY","Jettatura","MA","Jettatura"},
  {"SELF","MA_READY","Blank Gaze","MA","Blank Gaze"},

  --{"SELF","MA_READY","Geist Wall","MA","Geist Wall"},
  --{"SELF","MA_READY","Sheep Song","MA","Sheep Song"},
  --{"SELF","MA_READY","Soporific","MA","Soporific"},


  {"PARTY","HPP <=",60,"MA","Cure IV"},
  {"SELF","NOT_STATUS","Reprisal","MA","Reprisal"},
  --[[
  {"SELF","NOT_STATUS","Haste","MA","Refueling"},
  {"SELF","NOT_STATUS","Defense Boost","MA","Cocoon"},
  --]]

  {"SELF","MPP <=",30,"JA","Chivalry"}
}
gambits["BLU"] = {
  {"PARTY","HPP <=",70,"MA","Cure IV"}
  --{"SELF","NOT_STATUS","Defender","JA","Defender"}
 -- {"SELF","NOT_STATUS","Aggressor","JA","Aggressor"},
  --{"SELF","JA_READY","Provoke","JA","Provoke"}
}
gambits["NIN"] = {
  {"SELF","JA_READY","Provoke","JA","Provoke"},
  --{"SELF","NOT_STATUS","Food","ITEM","B.E.W. Pitaru"},
  {"SELF","NOT_STATUS","Yonin","JA","Yonin"},
  --{"SELF","MA_READY","Katon: Ichi","MA","Katon: Ichi"},
  --{"SELF","MA_READY","Katon: Ni","MA","Katon: Ni"},
  --{"SELF","SHADOWS <",2,"MA","Utsusemi: Ichi"}
}

--[[
gambits["NIN"] = {
  --{"SELF","STATUS","Paralyzed","ITEM","Remedy"},
  {"SELF","SHADOWS <",1,"MA","Utsusemi: Ni"},
  {"SELF","SHADOWS <",2,"MA","Utsusemi: Ichi"}
}
--]]
gambits["RDM"] = {
  {"SELF","STATUS","Paralyzed","JA","Healing Waltz"},
  {"SELF","STATUS","Paralyzed","ITEM","Remedy"},
  {"AND",{{"SELF","STATUS","Silence"},{"SELF","NOT_STATUS","Amnesia"}},"","JA","Healing Waltz"},
  {"SELF","STATUS","Silence","ITEM","Echo Drops"},
  {"PARTY","HPP <=",75,"MA","Cure IV"},
  {"SELF","HPP <=",75,"JA","Curing Waltz III"},
  {"PARTY","HPP <=",75,"MA","Cure III"},
  {"SELF","NOT_STATUS","Composure","JA","Composure"},
  {"SELF","NOT_STATUS","Refresh","MA","Refresh II"},
  {"SELF","NOT_STATUS","Refresh","MA","Refresh"},
  {"SELF","NOT_STATUS","Protect","MA","Protect V"},
  {"SELF","NOT_STATUS","Haste","MA","Haste II"},
  {"SELF","NOT_STATUS","Multi Strikes","MA","Temper"},
  {"SELF","NOT_STATUS","Enwater","MA","Enwater"},
  {"SELF","NOT_STATUS","Shell","MA","Shell V"},
  {"AND",{{"SELF","TP >=",1000},{"SELF","HPP >",75}},"","WS","Savage Blade"}
}
gambits["DNC"] = {
  --{"ENEMY","PERFORMING",2696,"JA",207},
  --{"SELF","NOT_ASSISTING","Tedreraud","ASSIST",""},
  --{"SELF","NOT_ENGAGED","","ATTACK",""},
  {"SELF","STATUS","Paralyzed","JA","Healing Waltz"},
  {"SELF","STATUS","Paralyzed","ITEM","Remedy"},
  {"PARTY","HPP <=",75,"JA","Curing Waltz III"},
  {"AND",{{"SELF","TP >=",1000},{"SELF","HPP >",75}},"","WS","Rudra's Storm"}
  --{"PARTY","HPP <=",50,"JA","Curing Waltz III"},
  --{"SELF","TP >=",1000,"WS","Rudra's Storm"}
  --{"SELF","NOT_STATUS",385,"JA",239}, --- 5 Steps, No Foot Rise
  --{"SELF","NOT_STATUS","Saber Dance","JA","Saber Dance"} --- Saber Dance
}
gambits["THF"] = {
  --{"SELF","STATUS","Paralyzed","ITEM","Remedy"},
  --{"SELF","STATUS","Silenced","ITEM","Echo Drops"},
  --{"SELF","NOT_STATUS","Food","ITEM","Sole Sushi"},
  --{"AND",{{"SELF","TP >=",1000},{"SELF","JA_READY","Sneak Attack"}},"","JA","Sneak Attack"},
  --{"SELF","TP >=",1000,"WS","Rudra's Storm"},
  --{"PARTY","HPP <=",50,"JA","Curing Waltz III"},
  {"PARTY","STATUS","Plague","JA","Healing Waltz"}
}
--[[
gambits["DNC"] = {
  {"ENEMY","CASTING","Firaga IV","JA","Violent Flourish"},
  {"ENEMY","CASTING","Blizzaga IV","JA","Violent Flourish"},
  {"ENEMY","CASTING","Aeroga IV","JA","Violent Flourish"},
  {"ENEMY","CASTING","Stonega IV","JA","Violent Flourish"},
  {"ENEMY","CASTING","Thundaga IV","JA","Violent Flourish"},
  {"ENEMY","CASTING","Waterga IV","JA","Violent Flourish"},
  {"ENEMY","CASTING","Sleepga II","JA","Violent Flourish"},
  {"ENEMY","CASTING","Silencega","JA","Violent Flourish"},
  {"ENEMY","CASTING","Paralyga","JA","Violent Flourish"},
  {"ENEMY","CASTING","Breakga","JA","Violent Flourish"},
  {"ENEMY","CASTING","Dispel","JA","Violent Flourish"},
  {"SELF","STATUS","Paralyzed","ITEM","Remedy"},
  {"SELF","STATUS","Silenced","ITEM","Echo Drops"},
  {"PARTY","HPP <=",70,"JA","Curing Waltz III"},
  {"SELF","SHADOWS <",1,"MA","Utsusemi: Ni"},
  {"SELF","SHADOWS <",2,"MA","Utsusemi: Ichi"}
}
--]]
gambits["SCH"] = {
  --{"SELF","NOT_ASSISTING","Minisub","ASSIST",""},
  --{"ENEMY","READYING","Foul Breath","MA","Stun"},
  --{"PARTY","HPP <=",70,"MA","Cure IV"},
  --{"PARTY","HPP <=",80,"MA","Cure III"},
  --{"SELF","STATUS","Bind","MA","Erase"}
  {"ENEMY","READYING","Yama's Judgment","MA","Stun"},
  --{"ENEMY","READYING","Raksha: Vengeance","MA","Stun"},
  {"SELF","NOT_STATUS","Alacrity","JA","Alacrity"},
  --{"SELF","MA_READY","Blizzard IV","MA","Blizzard IV"},
  --{"SELF","MA_READY","Blizzard III","MA","Blizzard III"}
}

gambits["BLM"] = {
  --{"SELF","NOT_ASSISTING","Minisub","ASSIST","Hanatori"},
  --{"ENEMY","READYING","Blistering Roar","MA","Stun"},
  --{"ENEMY","READYING","Incinerating Lahar","MA","Stun"},
  --{"ENEMY","READYING","Tetsudo Tremor","MA","Stun"},
  --{"SELF","CAN_MB","Ice","MA","Water VI"},
  --{"SELF","CAN_MB","Ice","MA","Water V"},
  {"SELF","CAN_MB","Earth","MA","Stone VI"},
  {"SELF","CAN_MB","Earth","MA","Stone V"},

  --{"SELF","CAN_MB","Lightning","MA","Thunder VI"},
  --{"SELF","CAN_MB","Lightning","MA","Thunder V"},
  {"SELF","CAN_MB","Fire","MA","Fire VI"},
  {"SELF","CAN_MB","Fire","MA","Fire V"},
  {"SELF","CAN_MB","Wind","MA","Aero VI"},
  {"SELF","CAN_MB","Wind","MA","Aero V"},
  --[[
  {"ENEMY","READYING","Extremely Bad Breath","MA","Stun"},
  {"ENEMY","READYING","Deathly Glare","MA","Stun"},
  {"ENEMY","READYING","Danse Macabre","MA","Stun"},
  {"ENEMY","READYING","Tainting Breath","MA","Stun"},
  {"ENEMY","READYING","Vampiric Lash","MA","Stun"},
  {"ENEMY","READYING","Static Prison","MA","Stun"},
  {"ENEMY","CASTING","Benthic Typhoon","MA","Stun"},
  {"ENEMY","READYING","Thousand Spears","MA","Stun"},
  {"ENEMY","READYING","Infernal Bulwark","MA","Stun"},
  {"ENEMY","READYING","Mayhem Lantern","MA","Stun"},
  {"ENEMY","READYING","Hell Scissors","MA","Stun"},
  --]]
  {"SELF","NOT_STATUS","Haste","MA","Haste"},
  {"SELF","MA_READY","Fire","MA","Fire"},
  --{"PARTY","NOT_STATUS","Refresh","MA","Refresh"}
  --{"SELF","NOT_ASSISTING","Minisub","ASSIST",""},
  --{"SELF","CAN_SC","Light","MA","Thunder VI"},
  --{"SELF","CAN_SC","Light","MA","Thunder V"},
  --{"SELF","CAN_SC","Light","MA","Aero VI"},
  --{"SELF","CAN_SC","Light","MA","Aero V"}
}
--[[
gambits["SCH"] = {
  {"ENEMY","READYING","Incinerating Lahar","MA","Stun"},
  {"ENEMY","READYING","Searing Serration","MA","Stun"},
  {"ENEMY","READYING","Batholithic Shell","MA","Stun"},
  {"ENEMY","READYING","Volcanic Stasis","MA","Stun"},
  {"ENEMY","READYING","Tyrannical Blow","MA","Stun"},
  {"ENEMY","READYING","Blistering Roar","MA","Stun"},
  {"ENEMY","READYING","Testudo Tremor","MA","Stun"},
  {"ENEMY","READYING","Calcifying Mist","MA","Stun"},
  {"ENEMY","READYING","Whirling Inferno","MA","Stun"},
  {"ENEMY","READYING","Chomp Rush","MA","Stun"},
  {"ENEMY","CASTING","Breakga","MA","Stun"},
  {"ENEMY","CASTING","Dispelga","MA","Stun"},
  {"ENEMY","CASTING","Stonega V","MA","Stun"},
  {"ENEMY","CASTING","Stonega IV","MA","Stun"},
  {"ENEMY","CASTING","Aeroga V","MA","Stun"},
  {"ENEMY","CASTING","Aeroga IV","MA","Stun"},
  {"ENEMY","CASTING","Thundaga IV","MA","Stun"},
  {"ENEMY","CASTING","Thundaga V","MA","Stun"},
  {"ENEMY","CASTING","Thundaja","MA","Stun"},
  {"ENEMY","CASTING","Firaja","MA","Stun"},
  {"ENEMY","CASTING","Meteor","MA","Stun"},
  {"ENEMY","CASTING","Flare","MA","Stun"},
  {"ENEMY","CASTING","Comet","MA","Stun"},
  {"ENEMY","CASTING","Impact","MA","Stun"},
  {"ENEMY","CASTING","Kaustra","MA","Stun"},
  {"ENEMY","CASTING","Stone V","MA","Stun"},
  {"ENEMY","CASTING","Fire V","MA","Stun"},
  {"ENEMY","CASTING","Aero V","MA","Stun"},
  {"SELF","NOT_STATUS","Alacrity","JA","Alacrity"},
  {"SELF","NOT_STATUS","Thunderstorm","MA","Thunderstorm"}
  --{"SELF","MA_READY","Barstonra","MA","Barwatera"},
  --{"SELF","MA_READY","Barstonra","MA","Baraera"}
}
--]]
gambits["WHM"] = {
  {"SELF","STATUS","Silence","ITEM","Echo Drops"},
  {"SELF","STATUS","Paralysis","MA","Paralyna"},
  {"CLUSTER","HPP <=",55,"MA","Curaga V"}, -- Oh my god, everyone is dying.
  {"CLUSTER","HPP <=",75,"MA","Curaga IV"},
  {"CLUSTER","HPP <=",85,"MA","Curaga III"},
  {"TANK","STATUS","Doom","MA","Cursna"}, -- Need to keep the tank up.
  {"SELF","STATUS","Doom","MA","Cursna"}, -- Need to keep us up so we can keep tank up.
  {"TANK","HPP <=",45,"MA","Cure V"},
  {"TANK","HPP <=",55,"MA","Cure IV"},
  {"TANK","HPP <=",55,"MA","Cure III"},
  {"MELEE","STATUS","Doom","MA","Cursna"}, -- Weakened melees hurts our DPS moreso than weak mages.
  {"PARTY","STATUS","Doom","MA","Cursna"}, -- Everyone else is expendable.
  {"MELEE","HPP <=",40,"MA","Cure V"},
  {"MELEE","HPP <=",50,"MA","Cure IV"},
  {"MELEE","HPP <=",50,"MA","Cure III"},
  {"PARTY","HPP <=",40,"MA","Cure V"},
  {"PARTY","HPP <=",50,"MA","Cure IV"},
  {"PARTY","HPP <=",50,"MA","Cure III"},
  {"SELF","NOT_STATUS","Reraise","MA","Reraise IV"},
  {"SELF","NOT_STATUS","Reraise","MA","Reraise III"},
  {"SELF","NOT_STATUS","Afflatus Solace","JA","Afflatus Solace"},
  {"SELF","NOT_STATUS","Light Arts","JA","Light Arts"},
  {"CLUSTER","STATUS","Sleep","MA","Curaga"},
  --{"AND",{{"PARTY","STATUS","Sleep"},{"PARTY","NOT_STATUS","Charm"}},"","MA","Cure"}
  {"PARTY","STATUS","Petrification","MA","Stona"},
  {"MAGE","STATUS","Silence","MA","Silena"},
  {"TANK","STATUS","Curse","MA","Cursna"},
  {"TANK","STATUS","Bane","MA","Cursna"},
  {"TANK","STATUS","Max HP Down","MA","Erase"},
  {"MELEE","STATUS","Curse","MA","Cursna"},
  {"MELEE","STATUS","Bane","MA","Cursna"},
  {"MELEE","STATUS","Max HP Down","MA","Erase"},
  {"PARTY","HPP <=",75,"MA","Cure IV"},
  {"PARTY","STATUS","Curse","MA","Cursna"},
  {"PARTY","STATUS","Bane","MA","Cursna"},
  {"PARTY","STATUS","Max HP Down","MA","Erase"},
  {"PARTY","STATUS","Sleep","MA","Cure"},
  {"SELF","NOT_STATUS","Haste","MA","Haste"},
  {"SELF","STATUS","Slow","MA","Erase"}, -- Slow on us will slow down removal on everyone.
  {"SELF","STATUS","Addle","MA","Erase"}, -- Same for Addle
  {"TANK","STATUS","Silence","MA","Silena"},
  {"TANK","STATUS","Slow","MA","Erase"},
  {"MELEE","STATUS","Slow","MA","Erase"},
  {"PARTY","STATUS","Slow","MA","Erase"},
  {"TANK","STATUS","Paralysis","MA","Paralyna"},
  {"MELEE","STATUS","Paralysis","MA","Paralyna"},
  {"PARTY","STATUS","Paralysis","MA","Paralyna"},
  {"SELF","STATUS","Bind","MA","Erase"}, -- We may need to move into/out of range. Us first.
  {"MELEE","STATUS","Bind","MA","Erase"},
  {"TANK","STATUS","Bind","MA","Erase"},
  {"PARTY","STATUS","Bind","MA","Erase"},
  {"TANK","STATUS","Magic Def. Down","MA","Erase"},
  {"MELEE","STATUS","Magic Def. Down","MA","Erase"},
  {"TANK","STATUS","Magic Evasion Down","MA","Erase"},
  {"MELEE","STATUS","Magic Evasion Down","MA","Erase"},
  {"TANK","STATUS","Defense Down","MA","Erase"},
  {"MELEE","STATUS","Defense Down","MA","Erase"},
  {"PARTY","STATUS","Magic Def. Down","MA","Erase"},
  {"PARTY","STATUS","Defense Down","MA","Erase"},
  {"PARTY","STATUS","Magic Evasion Down","MA","Erase"},
  {"MAGE","STATUS","Addle","MA","Erase"},
  {"MELEE","STATUS","Weight","MA","Erase"},
  {"TANK","STATUS","Weight","MA","Erase"},
  {"PARTY","STATUS","Weight","MA","Erase"},
  {"MELEE","STATUS","Blindness","MA","Blindna"},
  {"RANGED","STATUS","Blindness","MA","Blindna"},
  {"TANK","STATUS","Blindness","MA","Blindna"},
  {"MELEE","STATUS","Plague","MA","Viruna"},
  {"TANK","STATUS","Plague","MA","Viruna"},
  {"MELEE","STATUS","Accuracy Down","MA","Erase"},
  {"TANK","STATUS","Accuracy Down","MA","Erase"},
  {"RANGED","STATUS","Accuracy Down","MA","Erase"},
  {"MAGE","STATUS","Magic Acc. Down","MA","Erase"},
  {"MELEE","STATUS","Attack Down","MA","Erase"},
  {"MAGE","STATUS","Magic Atk. Down","MA","Erase"},
  {"RANGED","STATUS","Attack Down","MA","Erase"},
  --{"PARTY","STATUS","Poison","MA","Poisona"},
  {"MELEE","STATUS","Blindness","MA","Blindna"},
  {"SELF","STATUS","Plague","MA","Viruna"},
  {"PARTY","STATUS","Plague","MA","Viruna"},
  {"TANK","STATUS","Blindness","MA","Blindna"},
  {"PARTY","HPP <=",80,"MA","Cure III"},
  --{"CLUSTER","NOT_STATUS","Regen","CHAIN",{
                                        --{"JA","Accession"},
                                        --{"MA","Regen IV"}}}
  --{"MAGE","NOT_STATUS","Haste","MA","Haste"},
  {"TANK","NOT_STATUS","Haste","MA","Haste"},
  --{"MELEE","NOT_STATUS","Regen","MA","Regen IV"},
  --{"PARTY","NOT_STATUS","Regen","MA","Regen IV"},
  {"PARTY","STATUS","Poison","MA","Poisona"}
  --{"MAGE","NOT_STATUS","Hailstorm","MA","Hailstorm"},
}

gambits["BRD"] = {
  {"SELF","NOT_STATUS","Haste","MA","Haste"},
  {"SELF","MA_READY","Advancing March","MA","Advancing March"},
  {"SELF","MA_READY","Victory March","MA","Victory March"},
  {"SELF","MA_READY","Sword Madrigal","MA","Sword Madrigal"},
  {"SELF","MA_READY","Valor Minuet","MA","Valor Minuet"}
}

gambits["GEO_SKILL"] = {
  {"SELF","NOT_STATUS","Food","ITEM","B.E.W. Pitaru"},
  {"SELF","NOT_STATUS","geo refresh","MA","Indi-Refresh"},
  {"SELF","NOT_STATUS","Haste","MA","Haste"},
  {"SELF","MA_READY","Dia","MA","Dia"},
  {"SELF","MA_READY","Dia II","MA","Dia II"},
}

gambits["GEO"] = {
  --{"SELF","NOT_ASSISTING","Jacki","ASSIST","Hanatori"},
  --{"SELF","NOT_ENGAGED","","ATTACK",""},

  --{"SELF","NOT_STATUS","geo refresh","MA","Indi-Refresh"},
  {"SELF","NOT_STATUS","geo magic atk. boost","MA","Indi-Acumen"},
  --{"SELF","NOT_STATUS","geo attack boost","MA","Indi-Fury"},


  --{"SELF","NOT_STATUS","geo magic evasion boost","MA","Indi-Attunement"},

  --{"SELF","NOT_STATUS","geo haste","MA","Indi-Haste"},
  --{"SELF","NO_PET","","MA","Geo-Vex"},
  --{"SELF","NOT_STATUS","geo attack boost","MA","Indi-Fury"},
  --{"ENEMY","NOT_TAGGED","","MA","Dia II"},

  --{"SELF","NO_PET","","MA","Geo-Fury"},
  --[[
  {"AND",{ {"SELF","NO_PET",""}, {"SELF","JA_READY","Blaze of Glory"}},"","CHAIN",{
                                        {"JA","Blaze of Glory"},
                                        {"MA","Geo-Malaise"}}},
--]]

  --{"SELF","NO_PET","","MA","Geo-Acumen"},
  {"SELF","NO_PET","","MA","Geo-Malaise"},
  --{"SELF","NO_PET","","MA","Geo-Frailty"},
  --{"SELF","NO_PET","","MA","Geo-Haste"},
  --{"SELF","NO_PET","","MA","Geo-Vex"},


  --{"ENEMY","READYING","Bubble Curtain","MA","Dispel"},
  --{"AND",{{"SELF","CAN_MB","Darkness"},{"SELF","MPP <=",30}},"","MA","Aspir II"},
  --{"SELF","CAN_MB","Ice","MA","Blizzard V"},
  --{"SELF","CAN_MB","Ice","MA","Blizzard IV"},
  --{"SELF","CAN_MB","Water","MA","Water V"},
  --{"SELF","CAN_MB","Earth","MA","Stone V"},
  --{"SELF","CAN_MB","Lightning","MA","Thunder V"},
  --{"SELF","CAN_MB","Lightning","MA","Thunder IV"},
  --{"SELF","CAN_MB","Fire","MA","Fire IV"},
  --{"SELF","CAN_MB","Wind","MA","Aero V"},
  --{"SELF","NOT_STATUS","Stoneskin","MA","Stoneskin"},


  {"MAGE","STATUS","Sleep","MA","Cure"},

  --[[
  {"PARTY","STATUS","Petrification","MA","Stona"},
  {"MAGE","STATUS","Silence","MA","Silena"},
  {"TANK","STATUS","Curse","MA","Cursna"},
  {"TANK","STATUS","Bane","MA","Cursna"},
  {"TANK","STATUS","Max HP Down","MA","Erase"},
  {"MELEE","STATUS","Curse","MA","Cursna"},
  {"MELEE","STATUS","Bane","MA","Cursna"},
  {"MELEE","STATUS","Max HP Down","MA","Erase"},
  --]]

  --{"PARTY","HPP <=",75,"MA","Cure IV"},


  --{"PARTY","STATUS","Curse","MA","Cursna"},
  --{"PARTY","STATUS","Bane","MA","Cursna"},
  --{"PARTY","STATUS","Max HP Down","MA","Erase"},
  {"PARTY","STATUS","Sleep","MA","Cure"},

  --{"SELF","NOT_STATUS","Haste","MA","Haste"},

  --[[
  {"SELF","STATUS","Slow","MA","Erase"}, -- Slow on us will slow down removal on everyone.
  {"SELF","STATUS","Addle","MA","Erase"}, -- Same for Addle
  {"TANK","STATUS","Silence","MA","Silena"},
  {"TANK","STATUS","Slow","MA","Erase"},
  {"MELEE","STATUS","Slow","MA","Erase"},
  {"PARTY","STATUS","Slow","MA","Erase"},
  {"TANK","STATUS","Paralysis","MA","Paralyna"},
  {"MELEE","STATUS","Paralysis","MA","Paralyna"},
  {"PARTY","STATUS","Paralysis","MA","Paralyna"},
  {"SELF","STATUS","Bind","MA","Erase"}, -- We may need to move into/out of range. Us first.
  {"MELEE","STATUS","Bind","MA","Erase"},
  {"TANK","STATUS","Bind","MA","Erase"},
  {"PARTY","STATUS","Bind","MA","Erase"},
  {"TANK","STATUS","Magic Def. Down","MA","Erase"},
  {"MELEE","STATUS","Magic Def. Down","MA","Erase"},
  {"TANK","STATUS","Magic Evasion Down","MA","Erase"},
  {"MELEE","STATUS","Magic Evasion Down","MA","Erase"},
  {"TANK","STATUS","Defense Down","MA","Erase"},
  {"MELEE","STATUS","Defense Down","MA","Erase"},
  {"PARTY","STATUS","Magic Def. Down","MA","Erase"},
  {"PARTY","STATUS","Defense Down","MA","Erase"},
  {"PARTY","STATUS","Magic Evasion Down","MA","Erase"},
  {"MAGE","STATUS","Addle","MA","Erase"},
  {"MELEE","STATUS","Weight","MA","Erase"},
  {"TANK","STATUS","Weight","MA","Erase"},
  {"PARTY","STATUS","Weight","MA","Erase"},
  {"MELEE","STATUS","Blindness","MA","Blindna"},
  {"RANGED","STATUS","Blindness","MA","Blindna"},
  {"TANK","STATUS","Blindness","MA","Blindna"},
  {"MELEE","STATUS","Plague","MA","Viruna"},
  {"TANK","STATUS","Plague","MA","Viruna"},
  {"MELEE","STATUS","Accuracy Down","MA","Erase"},
  {"TANK","STATUS","Accuracy Down","MA","Erase"},
  {"RANGED","STATUS","Accuracy Down","MA","Erase"},
  {"MAGE","STATUS","Magic Acc. Down","MA","Erase"},
  {"MELEE","STATUS","Attack Down","MA","Erase"},
  {"MAGE","STATUS","Magic Atk. Down","MA","Erase"},
  {"RANGED","STATUS","Attack Down","MA","Erase"},
  --{"PARTY","STATUS","Poison","MA","Poisona"},
  {"MELEE","STATUS","Blindness","MA","Blindna"},
  {"SELF","STATUS","Plague","MA","Viruna"},
  {"PARTY","STATUS","Plague","MA","Viruna"},
  {"TANK","STATUS","Blindness","MA","Blindna"},
  --{"PARTY","HPP <=",80,"MA","Cure III"},
  --]]

  --{"SELF","MA_READY","Fire II","MA","Fire II"},
  --{"SELF","NOT_STATUS","Haste","MA","Haste"},
  --{"TANK","NOT_STATUS","Haste","MA","Haste"},
  --{"RANGED","NOT_STATUS","Flurry","MA","Flurry"},
  --{"MAGE","NOT_STATUS","Haste","MA","Haste"}
  --{"SELF","NOT_STATUS","Food","ITEM","Pear Crepe"},
  --{"SELF","MA_READY","Fire","MA","Fire"},
}

gambits["COR"] = {

}

gambits["RDM"] = {
  {"PARTY","HPP <=",75,"MA","Cure IV"},
}

return gambits
