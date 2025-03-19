Hooks:Add("LocalizationManagerPostInit", "oui", function(loc)
	LocalizationManager:add_localized_strings({
	
		bm_w_amcar_desc = "Low Accuracy and rate of fire",			                        -- AMCAR
		bm_w_m4_desc = "Good stability and ok-ish rate of fire",				        -- CAR-4
		bm_w_m16_desc = "Great rate of fire and good damage",				                -- AMR-16
		bm_w_ak74_desc = "Decent rate of fire and accuracy",			                        -- AK
		bm_w_ak5_desc = "Good stability and dammage",				                        -- Ak5
		bm_w_aug_desc = "Good damage and accuracy, ok-ish stability",				        -- UAR
		bm_w_g36_desc = "Medium damage and high ammo capacity",				                -- JP36
		bm_w_s552_desc = "Good rate of fire but low damage",			                        -- Commando 553
		bm_w_famas_desc = "Excellent rate of fire and ok-ish damage output",			        -- Clarion
		bm_w_l85a2_desc = "High stability and good accuracy but with an lengthy reload",                  -- Queen's Wrath
		bm_w_vhs_desc = " Good accurate, damage and stability",				                -- Lion's Roar
		bm_w_ak12_desc = "Great damage and ok-ish ammo pool",			                        -- AK17
		bm_w_tecci_desc = "Biggest magazine in its class but has poor accuracy",			-- Bootleg
		bm_w_hajk_desc = "Good damage and rate of fire",			                        -- CR 805B
		bm_w_corgi_desc = "high stability and good accuracy",			                        -- Union 5.56
		bm_w_asval_desc = "Integrally-suppressed",			                                -- Valkyria
		bm_w_akm_desc = "Great damage but low rate of fire and low ammo capacity",			-- AK.762
		bm_w_akm_gold_desc = "Trades concealment for fashion",		                                -- Golden AK.762
		bm_w_m14_desc = "High damage and accuracy but small mag size",				        -- M308
		bm_w_scar_desc = "High damage but low magazine size",			                        -- Eagle Heavy
		bm_w_fal_desc = "Great damage and accuracy with good rate of fire as well ",	                -- Falcon
		bm_w_g3_desc = "An battle rifle with an DMR and assault conversion kit",	                -- Gewehr 3
		bm_w_galil_desc = "Good damage and stability with a large pool of exclusive mods",              -- Gecko 7.62
		bm_w_contraband_desc = "Has a underbarreled grenade launcher attached to it",		        -- Little Friend
		bm_w_ching_desc = "High damage but low magazine size",			                        -- Galant
		bm_w_sub2000_desc = "Great damage and magazine size but low total ammo",			-- Cavity
		bm_w_komodo_desc = "Good damage, rate of fire and stability",			                -- MTAR 21
                bm_w_sks_desc = "Great damage and mag size but a semi slow rate of fire",
                bm_w_r0991_desc = "Large ammo pool and great rate of fire to lay waste",
                bm_w_sg416_desc = "Great damage and good ammo pool with ok rate of fire",
                bm_w_spike_desc = "Good damage accuracy and stability",
                bm_w_aknato_desc = "Great damage but low accuracy and ok-ish ammo pickup",
                bm_w_bdgr_desc = "High damage with a internal suppressor build into it",
                bm_w_groza_desc = "An lighter version of an little friend from germany",                           -- KETCHNOV Byk-1 
                bm_w_shak12_desc = "high damage and ok-ish accuracy but low rate of fire and very poor stability", -- KS12 
                bm_w_akm_tkb = "Can fire 3 bullets at the same time in single fire",                         -- Rodion 3B

		
		bm_w_tti_desc = "Good rate of fire and mag size",				                -- Contractor 308
		bm_w_wa2000_desc = "Good rate of fire but poor reload speed",			                -- Lebensauger
		bm_w_mosin_desc = "Great damage but poor ammo pool",			                        -- Nagant
		bm_w_siltstone_desc = "Good rate of fire but poor accuracy",		                        -- Grom
		bm_w_model70_desc = "Great damage and accuracy",			                        -- Platypus 70
		bm_w_msr_desc = "Good damage and ammo pool",				                        -- Rattlesnake
		bm_w_r93_desc = "Great damage and ok-ish mag size",				                -- R93
		bm_w_desertfox_desc = "Great concealment rating but poor accuracy",		                -- Desert Fox
		bm_w_winchester1874_desc = "Each round is loaded one at a time like a tube fed shotgun",	-- Repeater 1874
		bm_w_m95_desc = "Extreme damage but low total ammo",				                -- Thanatos 50
                bm_w_sgs_desc = "Good damage and rate of fire with only slightly worse ammo pickup for its class",
		bm_w_r700_desc = "Ok rate of fire with great accuracy",                                         -- R700
                bm_w_sbl_desc = "Has a bigger ammo pickup then its pears but has a smaller damage ramp-up bonus",                               -- Bernetti Rangehitter
                bm_w_qbu88_desc = "Good rate of fire and stability but poor concealment",                       -- Kang Army X1
                bm_w_scout_desc = "Compact enough to fit as a secondary",                                       -- Pronghorn
                bm_w_victor_desc = "higher rate of fire in exchange for damage and accuracy",                   -- North Star
                bm_w_contender_desc = "Great damage but holds only 1 bullet",                                   -- Aren G2


		bm_w_r870_desc = "High damage and decent accuracy",			                        -- Reinfeld 880
		bm_w_saiga_desc = "Fully automatic but low damage and magazine size",			        -- IZHMA
		bm_w_huntsman_desc = "Great damage but holds only 2 shots",		                        -- Mosconi
		bm_w_benelli_desc = "Great rate of fire but low damage",			                -- M1014
		bm_w_ksg_desc = "High magazine size and damage",				                -- Raven
		bm_w_spas12_desc = "Low damage but good rate of fire",			                        -- Predator
		bm_w_b682_desc = "High damage but low total ammo",			                        -- Joceline O/U
		bm_w_aa12_desc = "Fully automatic but poor damage",			                        -- Steakout
		bm_w_judge_desc = "Great damage but poor ammo pick-up",			                        -- Judge
		bm_w_serbu_desc = "High damage and good concealment",			                        -- Locomotive
		bm_w_striker_desc = "Great magazine size and rate of fire",			                -- Street Sweeper
		bm_w_basset_desc = "Good rate of fire and ammo pool but poor damage",			        -- Grimm
		bm_w_rota_desc = "ok-ish magazine size and damage",			                        -- Goliath
		bm_w_m37_desc = "Great damage but small ammo pool",				                -- GSPS
		bm_w_boot_desc = "Great damage and good mag size but small ammo pool and pick-up",		-- Breaker
		bm_w_coach_desc = "Great damage and good ammo pool at the cost of mag size",			-- Claire 12G
                bm_w_novas_desc = "A weapon fit for a counter-strike",
                bm_w_trench_desc = "Great damage and is able to equip a bayonet",
                bm_w_beck_desc = "A blast from the past... or from 2011 to be more precise",
                bm_w_amr12_desc = "Semi-automatic mag fed shotgun with ok damage",
                bm_w_m1897_desc = "Good damage, rate of fire and ammo pool",                                    -- Reinfeld 88
                bm_w_bs23_desc = "Extreme damage but slow rate of fire and low ammo pick-up",
                bm_w_minibeck_desc = "A mix of the locomotive and the predator in a small package",
                bm_w_m590_desc = "Great rate of fire and damage with a swift reload",                           -- Mosconi 12G Tactical
                bm_w_ultima_desc = "Loads 2 shells at a time",                                                  -- Argos III
                bm_w_sko12_desc = "Sports an big mag size to compensate for its slugish rate of fire",            -- VD-12

		
		bm_w_jowi_desc = "Double the damage and rate of fire at the cost of stability",			-- Akimbo Chimano Compact
		bm_w_x_b92fs_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Bernetti 9
		bm_w_x_g17_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Chimano 88
		bm_w_x_packrat_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Contractor
		bm_w_x_legacy_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo M13 9mm
		bm_w_x_shrew_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Crosskill Guard
		bm_w_x_g22c_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Chimano Custom
		bm_w_x_usp_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Interceptor 45
		bm_w_x_1911_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Crosskill
		bm_w_x_chinchilla_desc = "Double the damage and rate of fire at the cost of stability",	        -- Akimbo Castigo 44
		bm_w_x_deagle_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Deagle
		bm_w_x_rage_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Bronco 44
		bm_w_x_2006m_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Matever 357
		bm_w_x_sparrow_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Baby Deagle
		bm_w_x_pl14_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo White Streak
		bm_w_x_c96_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Broomstick
		bm_w_x_hs2000_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo LEO
		bm_w_x_p226_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Signature 40
		bm_w_x_ppk_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Gruber Kurz
		bm_w_x_breech_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Parabellum
                bm_w_x_beer_desc = "Double the damage and rate of fire at the cost of stability",               -- Akimbo Bernetti Auto Pisto
                bm_w_x_czech_desc = "Double the damage and rate of fire at the cost of stability",              -- Akimbo Czech 92 Pistol  
                bm_w_x_stech_desc = "Double the damage and rate of fire at the cost of stability",              -- Akimbo Igor Automatik Pistol
                bm_w_x_cold_desc = "Double the damage and rate of fire at the cost of stability",
                bm_w_x_lebman_desc = "Double the damage and rate of fire at the cost of stability",
                bm_w_smolak_desc = "Double the damage and rate of fire at the cost of stability",
                bm_w_x_holt_desc = "Double the damage and rate of fire at the cost of stability",               -- Akimbo HOLT 9mm
                bm_w_x_m1911_desc = "Double the damage and rate of fire at the cost of stability",              -- Crosskill Chuncky Compact
                bm_w_x_model3_desc = "Double the damage and rate of fire at the cost of stability",             -- Frenchman Model 87 
                bm_w_x_smolak_desc = "Double the damage and rate of fire at the cost of stability",     
                bm_w_x_type54_desc = "Double the damage and rate of fire at the cost of stability",             -- Akimbo Kang Arms Model 54 
                bm_w_x_korth_desc = "Double the damage and rate of fire at the cost of stability",              -- Akimbo Kahn .357        
                
		
		bm_w_x_sr2_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Heather
		bm_w_x_mp5_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Compact-5
		bm_w_x_akmsu_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Krinkov
		bm_w_x_olympic_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Para
		bm_w_x_coal_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Tatonka
		bm_w_x_m45_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Swedish K
		bm_w_x_mp7_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo SpecOps
		bm_w_x_scorpion_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Cobra
		bm_w_x_tec9_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Blaster
		bm_w_x_p90_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Kobus 90
		bm_w_x_mp9_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo CMP
		bm_w_x_uzi_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Uzi
		bm_w_x_erma_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo MP40
		bm_w_x_sterling_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Patchett L2A1
		bm_w_x_cobray_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Jacket's Piece
		bm_w_x_baka_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Micro Uzi
		bm_w_x_g18c_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo STRYK 18c
		bm_w_x_m1928_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Chicago Typewriter
		bm_w_x_mac10_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Mark 10
		bm_w_x_polymer_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Kross Vertex
		bm_w_x_schakal_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Jackal
		bm_w_x_shepheard_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Signature
                bm_w_x_hajk_desc = "Double the damage and rate of fire at the cost of stability",               -- Akimbo CR 805B
                bm_w_x_ak5s_desc = "Double the damage and rate of fire at the cost of stability",
                bm_w_x_car9_desc = "Double the damage and rate of fire at the cost of stability",
                bm_w_x_vityaz_desc = "Double the damage and rate of fire at the cost of stability",             -- Akimbo AK Gen 21 Tactical
                bm_w_x_pm9_desc = "Double the damage and rate of fire at the cost of stability",                -- Akimbo Miyaka 10 Special
		
		bm_w_x_basset_desc = "Double the damage and rate of fire at the cost of stability",		-- Brothers Grimm
		bm_w_x_judge_desc = "Double the damage and rate of fire at the cost of stability",		-- Akimbo Judge
		bm_w_x_rota_desc = "Double the damage and rate of fire at the cost of stability",	        -- Akimbo Goliath
                bm_w_x_sko12_desc = "Double the damage and rate of fire at the cost of stability",	        -- Akimbo VD-12
		
		bm_w_glock_17_desc = "Large mag size and ok-ish accuracy",		-- Chimano 88
		bm_w_b92fs_desc = "Ok-ish accuracy and damage but backs it up with high concealment",		-- Bernetti 9
		bm_w_ppk_desc = "Has good concealment but poor accuracy",				        -- Gruber Kurz
		bm_wp_pis_g26_desc = "May have nothing that stands out but thats the charm of it",		-- Chimano Compact
		bm_w_pl14_desc = "Great damage and accuracy but a slow rate of fire",			        -- White Streak
		bm_w_packrat_desc = "Good damage, accuracy and stability and only rate of fire and ammo pool to hold it down",			-- Contractor
		bm_w_legacy_desc = "Has great rate of fire but poor accuracy and stability",			-- M13 9mm
		bm_w_lemming_desc = "Can penetrate shields and enemies armor but has poor ammo pick-up and accuracy",			        -- 5/7 AP
		bm_w_breech_desc = "Great damage and accuracy but small mag size",			        -- Parabellum
		bm_w_shrew_desc = "Great mag size and ok-ish accuracy",			                        -- Crosskill Guard
		bm_w_hs2000_desc = "Excellent mag size and great accuracy",			                -- LEO
		bm_w_p226_desc = "Great accuracy and ok-ish stability",			                        -- Signature 40
		bm_w_g22c_desc = "Good mag size and damage",			                                -- Chimano Custom
		bm_w_sparrow_desc = "Great damage and accuray but small ammo pool and ok-ish stability",	-- Baby Deagle
		bm_w_usp_desc = "Good damage and ok-ish rate of fire",				                -- Interceptor 45
		bm_w_colt_1911_desc = "Good damage, great accuracy and ok-ish rate of fire",		        -- Crosskill
		bm_w_peacemaker_desc = "Great damage and accuracy but a very slow reload",		        -- Peacemaker 45
		bm_w_mateba_desc = "Supports gadgets unlike the other revolvers",			        -- Matever 357
		bm_w_chinchilla_desc = "Excellent damage but very poor stability and mag size",		        -- Castigo 44
		bm_w_deagle_desc = "High damage and ok-ish mag size",			                        -- Deagle
		bm_w_raging_bull_desc = "Excellent damage but holds only 6 shots",		                -- Bronco 44
                bm_w_beer_desc = "Fully-automatic with excellent rate of fire and ammo pool but very poor damage",                               -- Bernetti Auto Pistol
                bm_w_czech_desc = "Full-auto pistol with good accuracy and great rate of fire",                 -- Czech 92 Pistol
                bm_w_stech_desc = "Great damage and fully-automatic with ok-ish ammo pool",                     -- Igor Automatik Pistol 
                bm_w_cold_desc = "The best from the compact and full size modells in one packet",
                bm_w_lebman_desc = "Fully auto pistol with a slow rate of fire",
                bm_w_smolak_desc = "A assault rifle cut down to legaly qualify it as a machine pistol",
                bm_w_holt_desc = "Good stability and damage",                                                   -- HOLT 9mm
                bm_w_m1911_desc = "Great damage and good rate of fire",                                         -- Crosskill Chunky Compact
                bm_w_model3_desc = "Better ammo pool and pickup then its bigger brothers but lower damage",     -- Frenchman Model 87
                bm_w_type54_desc = "Can equip an underbarrel shotgun that holds one shell and can be loaded with custom ammunition",             --  Kang Arms Model 54 
                bm_w_korth_desc = "Bigger mag size compared to the other revolvers",                            -- Kahn .357
                
                
		
		bm_w_mp9_desc = "Great rate of fire but low accuracy",				                -- CMP
		bm_w_glock_18c_desc = "Fires fully-automatic and sports great rate of fire to boot",		-- STRYK 18c
		bm_w_p90_desc = "Large mag size and great rate of fire",				        -- Kobus 90
		bm_w_mp5_desc = "Large ammo pool and average accuracy",				                -- Compact-5
		bm_w_m45_desc = "Great mag size and damage but sluggish rate of fire",				-- Swedish K
		bm_w_akmsu_desc = "Great damage and good rate of fire but low stability",			-- Krinkov
		bm_w_olympic_desc = "Decent stability and damage",			                        -- Para
		bm_w_mp7_desc = "Good stability and accuracy but small mag size",				-- SpecOps
		bm_w_scorpion_desc = "High rate of fire and good concealment",		                        -- Cobra
		bm_w_tec9_desc = "lacks accuracy but makes up for it with good stability, rate of fire, concealment and ammo pool",		-- Blaster
		bm_w_uzi_desc = "Good stability and decently accurate",				                -- Uzi
		bm_w_c96_desc = "great accuracy and good stability but low mag size and slow reload",		-- Broomstick
		bm_w_sterling_desc = "Great damage and decent accuracy at the cost of rate of fire",		-- Patchett L2A1
		bm_w_cobray_desc = "Great rate of fire and good ammo pool but a slow dry reload",		-- Jacket's Piece
		bm_w_baka_desc = "Has excellent rate of fire and concealment",			                -- Micro Uzi
		bm_w_sr2_desc = "Decent accuracy and good damage",				                -- Heather
		bm_w_erma_desc = "Slow rate of fire but great damage",			                        -- MP40
		bm_w_coal_desc = "Great damage and mag size but low accuracy",			                -- Tatonka
		bm_w_m1928_desc = "large mag size and good-ish stability",			                -- Chicago Typewriter
		bm_w_mac10_desc = "Great rate of fire and a large mag size to keep it fed",			-- Mark 10
		bm_w_polymer_desc = "Excellent stability and rate of fire",			                -- Kross Vertex
		bm_w_schakal_desc = "Great damage and ok-ish rate of fire",			                -- Jackal
		bm_w_shepheard_desc = "Has nothing that really sticks out",		                        -- Signature
                bm_w_ak5s_desc = "Less damage then its bigger brother but higher ammo pool and rate of fire",
                bm_w_car9_desc = "Execellent rate of fire with good mag size but below average accuracy and stability",
                bm_w_vityaz_desc = "Lacks smg tier rate of fire but makes up for it with good accuracy, stability and ammo pool",               -- AK Gen 21 Tactical
                bm_w_pm9_desc = "High rate of fire with a low mag size to keep it from wasting ammo",           -- Miyaka 10 Special
                bm_w_fmg9_desc = "Great for mag-dumping bulldozers at close range",                             -- Wasp-DS

		
		bm_w_rpk_desc = "ok-ish rate of fire but good reload speed and great damage",		        -- RPK
		bm_w_m249_desc = "great rate of fire and mag size",			                        -- KSP
		bm_w_hk21_desc = "slow-ish rate of fire and long reload time but has good accuracy",		-- Brennet 21
		bm_w_mg42_desc = "excellent rate of fire and good mag size",			                -- Buzzsaw 42
		bm_w_par_desc = "Great mag size and rate of fire but slow-ish reload",				-- Ksp 58
                bm_w_negev_desc = "Excellent accuracy with a hard kick",
                bm_w_bar_desc = "Fast reload and great damage but small mag size and ammo pool",
                bm_w_m60_desc = "High damage with a large ammo pool and mag size but really slow fire rate",    -- M60
                bm_w_hk51b_desc = "Offers high concealment for its class in exchange for a lower ammo pool",    -- 51D
                bm_w_akm_hcar = "Very high damage that can be boosted even higher with a DMR kit",             -- Akron HC

		
                bm_w_hunter_desc = "Like a miniature bow that you can hold in one hand",			-- Pistol Crossbow
                bm_w_plainsrider_desc = "A bow that has really survived the test of time",		        -- Plainsrider Bow
                bm_w_long_desc = "May not have the fire rate of the plainsrider but has the damage",		-- English Longbow
                bm_w_arblast_desc = "Has extreme damage at the cost of a really slow reload time",		-- Heavy Crossbow
		bm_w_frankish_desc = "When the heavy is to slow",		                                -- Light Crossbow
                bm_w_ecp_desc = "When 1 arrow isen't enough",				                        -- Airbow
                bm_w_elastic_desc = "A bow made for the modern era",			                        -- Compound Bow
		bm_w_saw_desc = "Can be used to open deposit boxes and doors",				        -- OVE9000
		bm_w_m134_desc = "Large ammo pool and a extremely high rate of fire",			        -- Vulcan
                bm_w_shuno_desc = "Fires slower then the vulcan but those more damage",			        -- Microgun
		bm_w_flamethrower_mk2_desc = "A thing that sets stuff on fire, what more do you need",	        -- Flamethrower Mk2
		bm_w_gre_m79_desc = "Fires a explosive grenade and can be some what concealable",		-- GL40
                bm_w_m32_desc = "Has room for 6 grenades but has a slow reload",				-- Piglet
                bm_w_china_desc = "A pump-action style grenade lancher that holds 3 shells and reloads swiftly",                                -- China Puff
		bm_w_arbiter_desc = "May not pack the punch of the other grenade lanchers but sure as hell goes the mile",		        -- Arbiter
		bm_w_slap_desc = "Compact and lethal",			                                        -- Compact 40mm
		bm_w_rpg7_desc = "when you wanna make that bulldozer go up in smoke",			        -- HRL-7
		bm_w_ray_desc = "Holds more rockets then the HLR-7 but does less damage",			-- Commando 10
                bm_w_system_desc = "May not hold the same ammo pool as its bigger brother but has more concealment",
                bm_w_maxim9_desc = "Fires its entire mag in a single burst",                                    -- Basilisk 3V
                bm_w_hailstorm_desc = "Features an unique slug mode that fires 30 shield piercing rounds in a quick burst"                   -- Hailstorm MK5

       
               

		
		
	})
end)