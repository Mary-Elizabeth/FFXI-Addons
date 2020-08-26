local party = {}
party.leader_id = nil
party.alliance_id = nil

party.p0 = {}
party.p0.id = nil
party.p0.is_leader = false
party.p0.name = nil
party.p0.zone = nil
party.p0.hpp = 0
party.p0.mpp = 0
party.p0.current_hp = 0
party.p0.current_mp = 0
party.p0.current_tp = 0
party.p0.hp_bar_width = 0
party.p0.mp_bar_width = 0

party.p1 = {}
party.p1.id = nil
party.p1.is_leader = false
party.p1.name = nil
party.p1.zone = nil
party.p1.hpp = 0
party.p1.mpp = 0
party.p1.current_hp = 0
party.p1.current_mp = 0
party.p1.current_tp = 0
party.p1.hp_bar_width = 0
party.p1.mp_bar_width = 0

party.p2 = {}
party.p2.id = nil
party.p2.is_leader = false
party.p2.name = nil
party.p2.zone = nil
party.p2.hpp = 0
party.p2.mpp = 0
party.p2.current_hp = 0
party.p2.current_mp = 0
party.p2.current_tp = 0
party.p2.hp_bar_width = 0
party.p2.mp_bar_width = 0

party.p3 = {}
party.p3.id = nil
party.p3.is_leader = false
party.p3.name = nil
party.p3.zone = nil
party.p3.hpp = 0
party.p3.mpp = 0
party.p3.current_hp = 0
party.p3.current_mp = 0
party.p3.current_tp = 0
party.p3.hp_bar_width = 0
party.p3.mp_bar_width = 0

party.p4 = {}
party.p4.id = nil
party.p4.is_leader = false
party.p4.name = nil
party.p4.zone = nil
party.p4.hpp = 0
party.p4.mpp = 0
party.p4.current_hp = 0
party.p4.current_mp = 0
party.p4.current_tp = 0
party.p4.hp_bar_width = 0
party.p4.mp_bar_width = 0

party.p5 = {}
party.p5.id = nil
party.p5.is_leader = false
party.p5.name = nil
party.p5.zone = nil
party.p5.hpp = 0
party.p5.mpp = 0
party.p5.current_hp = 0
party.p5.current_mp = 0
party.p5.current_tp = 0
party.p5.hp_bar_width = 0
party.p5.mp_bar_width = 0

-- function party.p0:calculate_tpp() -- NOT USING A BAR FOR TP SO DON'T NEED TPP
    -- self.tpp = math.min(self.current_tp / 10, 100)
-- end

return party