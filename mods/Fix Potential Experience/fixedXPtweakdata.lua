Hooks:PostHook(NarrativeTweakData, "init", "fixXP_NarrativeTweakData_init", function(self, tweak_data)

	--Original values: search for min_mission_xp here: https://raw.githubusercontent.com/mwSora/payday-2-luajit/3d26872311b571a26628b50238df72a44f5f2177/pd2-lua/lib/tweak_data/narrativetweakdata.lua

	--Rats: minimum XP on OVK- is 18,000 + required escape (garage for 4,000), mayhem+ has higher minimum
	--this is the only escape I'm considering for these numbers, min or max, since it's required
	self.jobs.alex.contract_visuals.min_mission_xp = {
		22000,
		22000,
		22000,
		22000,
		36000,
		36000,
		36000
	}
	
	--Framing Frame: minimum XP was too high (20,000), maximum XP was 1,000 too low
	--note: higher max xp possible due to day 3 stealth then loud
	--additional note: despite working identically to a table with 7 identical values,
	--the only job that doesn't use a table for its mission XP is Four Stores
	self.jobs.framing_frame.contract_visuals.min_mission_xp = 17500
	self.jobs.framing_frame.contract_visuals.max_mission_xp = 43000
	
	--Watchdogs: The 4th bag thrown in gives 1,500 XP which these numbers didn't account for
	--only 8 bags on normal and hard
	--note: the wiki says there's 16 bags but there's only 12???
	self.jobs.watchdogs_wrapper.contract_visuals.min_mission_xp = 25500
	self.jobs.watchdogs_wrapper.contract_visuals.max_mission_xp = {
		35500,
		35500,
		41500,
		41500,
		41500,
		41500,
		41500
	}
	
	--Train Heist: They did not account for the ammo objective between difficulties at all
	--these, and many other difficulty-dependent minimum numbers came straight from the wiki
	self.jobs.arm_for.contract_visuals.min_mission_xp = {
		20200,
		20200,
		23400,
		29600,
		36000,
		36000,
		36000
	}
	--Cook Off: this was 16,000 for some reason. overkill can't count to three
	self.jobs.rat.contract_visuals.min_mission_xp = 24000
	
	--Diamond Store: No difficulty variance for minimum xp, and the 2 safe money bags not accounted for in max XP of 20000
	self.jobs.family.contract_visuals.min_mission_xp = {
		6000,
		8000,
		12000,
		16000,
		16000,
		16000,
		16000
	}
	self.jobs.family.contract_visuals.max_mission_xp = 22000
	
	--Big Bank: base 30000, maximum bags = 25, stealth = +10k, stealth+bus = another +10k
	self.jobs.big.contract_visuals.max_mission_xp = 75000
	
	--GO Bank: Official minimum of 6,500 may have been based on the vault already being open, although that should be 5,000
	--I'm going with the wiki's 11,000 (8,000 base + 1 bag + 4 phone calls)
	self.jobs.roberts.contract_visuals.min_mission_xp = 11000
	
	--Shadow Raid: No difficulty variance in minimum XP
	self.jobs.kosugi.contract_visuals.min_mission_xp = {
		5500,
		6500,
		7500,
		8500,
		10000,
		10000,
		10000
	}
	
	--Skipping modifying Hotline Miami's 69000 max; it's a bit extreme but technically possible
	--Day 1's loot is very random and 69000 is funny
	
	--Art Gallery: max was 12000
	self.jobs.gallery.contract_visuals.max_mission_xp = 12500
	
	--Hoxton Breakout: minimum was just wrong, and there seems to always be 2 obstacles so the 4000 for no keycard is the only variance
	self.jobs.hox.contract_visuals.min_mission_xp = 52400
	self.jobs.hox.contract_visuals.max_mission_xp = 56400
	
	--The Diamond: max 18 artifacts
	self.jobs.mus.contract_visuals.max_mission_xp = 46000
	
	--Hoxton Revenge: Lacking difficulty variance
	self.jobs.hox_3.contract_visuals.min_mission_xp = {
		20000,
		20000,
		21000,
		22000,
		22000,
		22000,
		22000
	}
	--The Bomb: Dockyard: max 10 bags on Overkill, max 14 on Mayhem
	self.jobs.crojob1.contract_visuals.max_mission_xp = {
		31000,
		31000,
		31000,
		31000,
		33000,
		33000,
		33000
	}
	--The Bomb: Forest: listed minimum was 34000, max was 41500
	self.jobs.crojob_wrapper.contract_visuals.min_mission_xp = 38000
	self.jobs.crojob_wrapper.contract_visuals.max_mission_xp = 42500
	
	--The Alesso Heist: A doozy. Although you could begin a loud Alesso by grabbing C4 in Stealth (for +1,000 each),
	--or ruin a Stealth Alesso after getting all C4, skipping the 10,000 XP loud hack (for a lower minimum),
	--I'm ignoring all that complexity and only using pure stealth or pure loud numbers
	--Original was lacking difficulty variance both ways, and used Loud's 51,600 OVK+ max as the max xp
	--with minimum bag securing, doing the loud hack is always higher XP, so minimums are all stealth
	self.jobs.arena.contract_visuals.min_mission_xp = {
		19500,
		28000,
		28000,
		38500,
		43000,
		43000,
		43000
	}
	self.jobs.arena.contract_visuals.max_mission_xp = {
		30200, --loud
		40400, --loud
		40400, --loud
		52000, --with max C4/money, the stealth bonuses > the 10,000 XP loud hack
		52000,
		52000,
		52000
	}
	
	--Golden Grin Casino: Original max is 67,500. This is 8,250 more than a Loud Golden Grin with Silent Entry earns you
	--the 250 is an error, but the 8,000 could be from a couple of the 4,000 XP stealth objectives (like getting+sending blueprints)
	--Since this objective does not aid a loud Golden Grin attempt at all, I've decided to not include it, per Framing Frame Day 3
	--Note: With a cheeky pager loop strategy, you can just rush into the security center, making a lower minimum than 39,250
	self.jobs.kenaz.contract_visuals.max_mission_xp = 59250
	
	--Aftershock: No difficulty variance
	self.jobs.jolly.contract_visuals.min_mission_xp = {
		30000,
		31000,
		32000,
		33000,
		34000,
		34000,
		34000
	}
	self.jobs.jolly.contract_visuals.max_mission_xp = {
		30000,
		31000,
		32000,
		33000,
		34000,
		34000,
		34000
	}
	--First World Bank: No difficulty variance
	--Overvault's XP is not included in official max XP, so I'll keep it that way
	--whether it be because it's a "secret" or because it's not a realistic max XP for a normal playthrough
	self.jobs.red2.contract_visuals.min_mission_xp = {
		17500,
		17500,
		19500,
		19500,
		21500,
		21500,
		21500
	}
	--Slaughterhouse: No difficulty variance
	self.jobs.dinner.contract_visuals.min_mission_xp = {
		34000,
		36000,
		36000,
		36800,
		38400,
		38400,
		38400
	}
	--Beneath the Mountain: Original max was 32000
	self.jobs.pbr.contract_visuals.max_mission_xp = 30000
	
	--Counterfeit: idk why i'm bothering editing this but the max (3621000; 720 bags + 21000) doesn't include +2000 for defusing C4
	self.jobs.pal.contract_visuals.max_mission_xp = 3623000
	
	--Santa's Workshop: Original min was 10900, max was 6218000; seems like presents used to be worth less when they wrote this
	self.jobs.cane.contract_visuals.min_mission_xp = 12000
	self.jobs.cane.contract_visuals.max_mission_xp = 7220000
	
	--Goat Simulator: Simply inaccurate numbers, and no difficulty variance
	--It included the Farmer Miserable XP; I'm going to consider that as an irregular event like Overvault
	--Worst achievement in the damn game
	--You can technically gain infinite XP (at a horrid pace) with 1,000 per empty cage built/secured, so I'm not including any bonus cage XP
	self.jobs.peta.contract_visuals.min_mission_xp = {
		42500,
		46500,
		52500,
		58500,
		62500,
		62500,
		62500
	}
	self.jobs.peta.contract_visuals.max_mission_xp = {
		42500,
		46500,
		52500,
		58500,
		62500,
		62500,
		62500
	}
	--Undercover: An intended guaranteed +1,000 for starting each hack is actually a +1,000 per power failure (up to 3 times)
	self.jobs.man.contract_visuals.min_mission_xp = 24500
	
	--Murky Station: Listed maximum was 32,000; forgot the 2 weapon bags in basement?
	self.jobs.dark.contract_visuals.max_mission_xp = 34000
	
	--The Biker Heist: This one's always weird because it was clearly intended to be two separate heists
	--In the files it has min/max of 10000 and 14000, which is nearly accurate to Day 2
	self.jobs.born.contract_visuals.min_mission_xp = 32000
	self.jobs.born.contract_visuals.max_mission_xp = 51500
	
	--Scarface Mansion: Extremely wrong, and no level variance
	self.jobs.friend.contract_visuals.min_mission_xp = {
		23000,
		23000,
		23000,
		24000,
		24000,
		24000,
		24000
	}
	self.jobs.friend.contract_visuals.max_mission_xp = 32000
	
	--Stealing Xmas: Original max of 17800; didn't include the 9 additional loot bags?
	self.jobs.moon.contract_visuals.max_mission_xp = 26800
	
	--The Yacht Heist: Original max of 15000
	self.jobs.fish.contract_visuals.max_mission_xp = 15500
	
	--Panic Room: Normal's minimum was 12,000 for some reason
	self.jobs.flat.contract_visuals.min_mission_xp = 25000
	
	--Heat Street: mayhem's max was typo'd as 260000
	self.jobs.run.contract_visuals.max_mission_xp = 26000
	
	--Safe House Nightmare: It does have 10000 XP in the code... but then they overwrite it when they're setting its thumbnail
	self.jobs.haunted.contract_visuals.min_mission_xp = 10000
	self.jobs.haunted.contract_visuals.max_mission_xp = 10000
	
	--While we're dealing with Safe House Nightmare's bizarre 0 XP yield
	--Safe House Raid: It doesn't have contract_visuals; create it ourselves
	self.jobs.chill_combat.contract_visuals = {}
	self.jobs.chill_combat.contract_visuals.min_mission_xp = 42000
	self.jobs.chill_combat.contract_visuals.max_mission_xp = 42000
	
	--Diamond Heist: No Difficulty variance, min XP was 14200
	self.jobs.dah.contract_visuals.min_mission_xp = {
		10600,
		10600,
		11400,
		12200,
		12200,
		12200,
		12200
	}
	self.jobs.dah.contract_visuals.max_mission_xp = {
		21200,
		21200,
		21200,
		23200,
		23200,
		23200,
		23200
	}
	--Reservoir Dogs Heist: Official values were a bit low
	self.jobs.rvd.contract_visuals.min_mission_xp = 33500
	self.jobs.rvd.contract_visuals.max_mission_xp = 52500
	
	--Brookyln Bank: Minimum had a required bag for 16400, maximum had no difficulty variance
	self.jobs.brb.contract_visuals.min_mission_xp = 16000
	self.jobs.brb.contract_visuals.max_mission_xp = {
		20800,
		20800,
		20800,
		25600,
		25600,
		25600,
		25600
	}
	
	--Cursed Kill Room: Well, the wiki gives a maximum of 82000 instead of 60000, idk, I wanna see a high score run of this to prove it
	self.jobs.hvh.contract_visuals.max_mission_xp = 82000
	
	--Breakin' Feds: Max amount didn't include 8 evidence bags?
	self.jobs.tag.contract_visuals.max_mission_xp = 31000
	
	--Henry's Rock: Massively under what it actually is (min 14200, max 23200)
	self.jobs.des.contract_visuals.min_mission_xp = 26000
	self.jobs.des.contract_visuals.max_mission_xp = 44000
	
	--White House: Massively under what it actually is (min 14200, max 23200)... Wait...
	self.jobs.vit.contract_visuals.min_mission_xp = 31000
	self.jobs.vit.contract_visuals.max_mission_xp = 40000
	
	--Hell's Island: Massively under/over what it actually is (min 14200, max 23200)... So, uh...
	self.jobs.bph.contract_visuals.min_mission_xp = {
		17000,
		17000,
		17000,
		18000,
		18000,
		18000,
		18000
	}
	self.jobs.bph.contract_visuals.max_mission_xp = {
		17000,
		17000,
		17000,
		18000,
		18000,
		18000,
		18000
	}
	
	--Border Crossing: Yeah, at this point they just copy the same values for every heist...
	--Loot Bag XP Update: I don't know how many max bags can spawn, especially with crowbar crates being random
	--I also don't know if difficulty increases the number of bags spawned, and I don't care to check
	--(Having to do "day 1" to get the bag spawn info sucks)
	--min = 19,000 + 500 per bag required
	--max = 21,000 + 500 per bag (I decided to just go with 42, for 21,000. I saw 2 vids that secured 41, and a few that secured 38.)
	self.jobs.mex.contract_visuals.min_mission_xp = {
		21000,
		22000,
		22000,
		23000,
		25000,
		25000,
		25000
	}
	self.jobs.mex.contract_visuals.max_mission_xp = 42000
	
	--Border Crystals: And for some reason, those values are from Diamond Heist of all things
	--I used 6,000 bags as the basis for the max, like cook off
	self.jobs.mex_cooking.contract_visuals.min_mission_xp = 19000
	self.jobs.mex_cooking.contract_visuals.max_mission_xp = 7201000
	
	--San Martin Bank: 20,000 is the intended amount from Stealth, but 8,000 from the Manager Objective can be easily skipped
	--Bag XP update: +4000 to min, +11000 to max
	self.jobs.bex.contract_visuals.min_mission_xp = 16000
	self.jobs.bex.contract_visuals.max_mission_xp = 43000
	
	--Breakfast in Tijuana: If there's difficulty differences in any of these newer heists, I don't know them
	--The wiki doesn't have good XP info for these so it's just from Overkill+ testing for XP Briefings
	self.jobs.pex.contract_visuals.min_mission_xp = 22000
	self.jobs.pex.contract_visuals.max_mission_xp = 26000
	
	--Buluc's Mansion
	self.jobs.fex.contract_visuals.min_mission_xp = 16000
	self.jobs.fex.contract_visuals.max_mission_xp = 35500
	
	--Dragon Heist
	self.jobs.chas.contract_visuals.min_mission_xp = 16000
	self.jobs.chas.contract_visuals.max_mission_xp = 31500
	
	--Ukrainian Prisoner
	self.jobs.sand.contract_visuals.min_mission_xp = 31500
	self.jobs.sand.contract_visuals.max_mission_xp = 47000
	
	--Black Cat
	--Note: The C4 objective path can be started at any time before the vault's open,
	--making a ludicrous potential max XP that I'm not accounting for here
	--and also making a really funny way to troll loud lobbies. place a C4 right before the code is inputted
	--Minimum = Stealth; 4 bags required on VH-, 8 bags on OVK/Mayhem, 12 bags on DW+
	self.jobs.chca.contract_visuals.min_mission_xp = {
		21500,
		21500,
		21500,
		23500,
		23500,
		25500,
		25500
	}
	self.jobs.chca.contract_visuals.max_mission_xp = 45500
	
	--Mountain Master: Stealth is 36,000 + 4 bags of 500, Loud is 38,000 + 10 bags (gold 5-8 worth 1,000 instead of 500) for 7,000
	self.jobs.pent.contract_visuals.min_mission_xp = 38000
	self.jobs.pent.contract_visuals.max_mission_xp = 45000
	
	--No Mercy: Oh, it's below all the others. Both were a bit low (22400, 32000)
	self.jobs.nmh.contract_visuals.min_mission_xp = 27000
	self.jobs.nmh.contract_visuals.max_mission_xp = 41000
	
	--Shacklethorne Auction: Also a bit low (11000, 23000)
	--Bag XP Update: +1000 min, +37000 max
	self.jobs.sah.contract_visuals.min_mission_xp = 16000
	self.jobs.sah.contract_visuals.max_mission_xp = 63000
	
	
	--Bag XP Update: Wow, new heists that are inaccurate!
	self.jobs.nightclub.contract_visuals.min_mission_xp = 10000
	self.jobs.nightclub.contract_visuals.max_mission_xp = 22000
	
	--I know, it's sad
	self.jobs.firestarter.contract_visuals.min_mission_xp = {
		31000,
		31000,
		31000,
		31000,
		32000,
		32000,
		32000
	}
	--sounds like you possibly could get 16 extra evidence bags; however, 0 is most likely, and 0-4 is more realistic
	--treating it as 0-4 (+1 goat +2 server)
	self.jobs.firestarter.contract_visuals.max_mission_xp = {
		50000,
		50000,
		50000,
		50000,
		51000,
		51000,
		51000
	}
	
	local armoredTransportMin = {
		14000,
		15000,
		16000,
		17000,
		17000,
		17000,
		17000
	}
	-- number of trucks varies between difficulties... details are sparse so whatever, 4 can spawn on overkill, assume 3 on others, no one plays below overkill
	local armoredTransportMax = {
		21000,
		21000,
		21000,
		24000,
		24000,
		24000,
		24000
	}
	-- park can only have 3 trucks?
	local parkMax = {
		21000,
		21000,
		21000,
		21000,
		21000,
		21000,
		21000
	}
	
	--Crossroads' trucks apparently have RNG and can have more than 3 bags each... i don't care to test it
	self.jobs.arm_cro.contract_visuals.min_mission_xp = armoredTransportMin
	self.jobs.arm_cro.contract_visuals.max_mission_xp = armoredTransportMax
	
	self.jobs.arm_und.contract_visuals.min_mission_xp = armoredTransportMin
	self.jobs.arm_und.contract_visuals.max_mission_xp = armoredTransportMax
	self.jobs.arm_hcm.contract_visuals.min_mission_xp = armoredTransportMin
	self.jobs.arm_hcm.contract_visuals.max_mission_xp = armoredTransportMax
	self.jobs.arm_par.contract_visuals.min_mission_xp = armoredTransportMin
	self.jobs.arm_par.contract_visuals.max_mission_xp = parkMax
	self.jobs.arm_fac.contract_visuals.min_mission_xp = armoredTransportMin
	self.jobs.arm_fac.contract_visuals.max_mission_xp = armoredTransportMax
	
	
	--While checking these old jobs out, I found that they had an experience multiplier that's so out of date that it'd run out at Mayhem. I don't think this is used anymore though, as it's used on job completion, and jobs don't give XP on completion, they give little XP triggers in-heist
	
	--Midland Ranch
	--Only 6 bags needed on VH-
	self.jobs.ranc.contract_visuals.min_mission_xp = {
		28000,
		28000,
		28000,
		30000,
		30000,
		30000,
		30000
	}
	--Imma be real with you, I have no clue how many max bags there are. 12 with the asset?
	-- +2,000 for assembling the cage
	self.jobs.ranc.contract_visuals.max_mission_xp = 36000
	
	-- Lost in Transit
	-- 6 bags on Normal to Overkill, 9 on Mayhem+
	self.jobs.trai.contract_visuals.min_mission_xp = {
		26500,
		26500,
		26500,
		26500,
		27250,
		27250,
		27250
	}
	
	--[[
	
	Max bags: On Overkill, non-company trains have 2 bags inside instead of 3
	4 under-trains, 9 trains (3 for each company) always? so additional Overkill xp is 20*250, mayhem xp is 26*250
	
	]]
	self.jobs.trai.contract_visuals.max_mission_xp = {
		31500,
		31500,
		31500,
		31500,
		33750,
		33750,
		33750
	}
	
	--[[
	Hostile Takeover
	minimum: 23,500; maximum: 34,500
	20,000 for 4 objectives; escape is 1,000 or 2,000; 25 bags of 500 xp (5 required)
	
	]]
	self.jobs.corp.contract_visuals.min_mission_xp = 23500
	self.jobs.corp.contract_visuals.max_mission_xp = 34500
	
	--Crude Awakening: easy, 33,000 for finishing and 8 optional bags
	self.jobs.deep.contract_visuals.min_mission_xp = 33000
	self.jobs.deep.contract_visuals.max_mission_xp = 41000
	
end)