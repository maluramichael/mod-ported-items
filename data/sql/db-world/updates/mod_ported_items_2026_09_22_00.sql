-- mod-ported-items: two sets of new gear plus a vendor NPC that sells all of it.
--
-- Idempotent (DELETE + INSERT). Every entry below is new (no collisions with base-game or
-- other custom content on this world DB). All displayids are REUSED from existing rows in
-- this world DB - no client patch required.
--
--   Section A: Path of Exile-inspired unique items  (item_template 9002000-9002009)
--   Section B: Retail WoW-inspired backport items    (item_template 9002010-9002019)
--   Vendor:    "Planar Merchant"                      (creature_template 9002500, sells all 20)
--
-- stat_type: 3=Agility 4=Strength 5=Intellect 6=Spirit 7=Stamina 32=Crit 36=Haste
--            38=AttackPower 45=SpellPower
-- Quality:   3=blue (rare) 4=epic
--
-- The vendor is NOT spawned by default - see README.md for ".npc add 9002500".

-- --------------------------------------------------------------------------------------
--  SECTION A: Path of Exile-inspired unique items (9002000-9002009)
-- --------------------------------------------------------------------------------------

DELETE FROM `item_template` WHERE `entry` IN (9002000, 9002001, 9002002, 9002003, 9002004,
    9002007, 9002008, 9002009);

INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`,
     `maxcount`, `stackable`,
     `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`,
     `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`,
     `bonding`, `description`, `MaxDurability`)
VALUES
    -- Headhunter's Cord - PoE's "Headhunter": mixed offense stolen from everything it kills.
    (9002000, 4, 3, 'Headhunter''s Cord', 65035, 4, 600000, 150000,
     6, -1, -1, 200, 70,
     0, 1,
     3, 45, 4, 30, 32, 35,
     310, 0, 0, 0, 0, 0, 0,
     1, 'Every notch on this belt is a life it wasn''t yours to take.', 100),

    -- Kaom's Molten Heart - PoE's "Kaom's Heart": nothing but life, and a lot of it.
    (9002001, 4, 4, 'Kaom''s Molten Heart', 64580, 4, 639000, 159750,
     5, -1, -1, 213, 75,
     0, 1,
     7, 180, 0, 0, 0, 0,
     1150, 0, 0, 0, 0, 0, 0,
     1, 'Forged in a mountain''s core. Holds nothing back but heat and stamina.', 120),

    -- Goldrim's Guise - PoE's "Goldrim": the classic budget leveling helm, all-round resists.
    (9002002, 4, 3, 'Goldrim''s Guise', 27191, 3, 5000, 1250,
     1, -1, -1, 22, 9,
     0, 1,
     7, 10, 0, 0, 0, 0,
     48, 5, 5, 5, 5, 5, 5,
     1, 'A humble helm that has carried more adventurers past level ten than any other.', 60),

    -- Shavronne's Wrappings - PoE's "Shavronne's Wrappings": a caster-only cloth cocoon.
    (9002003, 4, 1, 'Shavronne''s Wrappings', 62580, 4, 639000, 159750,
     5, -1, -1, 213, 75,
     0, 1,
     5, 140, 45, 95, 0, 0,
     280, 0, 0, 0, 0, 0, 0,
     1, 'Cloth wound so tight around old magic that no spell escapes it unchanged.', 90),

    -- The Baron's Warcrown - PoE's "The Baron": a brute's helm, pure str/stamina.
    (9002004, 4, 4, 'The Baron''s Warcrown', 64587, 4, 639000, 159750,
     1, -1, -1, 213, 75,
     0, 1,
     4, 95, 7, 125, 0, 0,
     980, 0, 0, 0, 0, 0, 0,
     1, 'Worn by warlords who measured victory only in how much they could still carry.', 100),

    -- Wanderlust Treads - PoE's "Wanderlust": light boots for a restless owner.
    (9002007, 4, 2, 'Wanderlust Treads', 64437, 4, 639000, 159750,
     8, -1, -1, 213, 75,
     0, 1,
     3, 100, 7, 95, 0, 0,
     440, 0, 0, 0, 0, 0, 0,
     1, 'The soles never wear out. Neither does the urge to keep moving.', 90),

    -- Aegis Aurora - PoE's "Aegis Aurora": a shield built to absorb and outlast.
    (9002008, 4, 6, 'Aegis Aurora', 65029, 4, 639000, 159750,
     14, -1, -1, 213, 75,
     0, 1,
     7, 130, 6, 65, 0, 0,
     1750, 0, 0, 0, 0, 0, 0,
     1, 'A shimmering barrier that regrows the instant it is chipped away.', 110),

    -- Bisco's Collar - PoE's "Bisco's Leash": a bandit's charm for surviving the hunt.
    (9002009, 4, 0, 'Bisco''s Collar', 64211, 4, 600000, 150000,
     2, -1, -1, 200, 72,
     0, 1,
     7, 95, 32, 55, 0, 0,
     0, 0, 0, 0, 0, 0, 0,
     1, 'Once worn by a bandit queen who never lost a fight she started first.', 0);

-- Section A weapons (dagger/bow/2H columns differ from the armor set above)
DELETE FROM `item_template` WHERE `entry` IN (9002005, 9002006);

INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`,
     `maxcount`, `stackable`,
     `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`,
     `dmg_min1`, `dmg_max1`, `dmg_type1`, `delay`, `ammo_type`,
     `bonding`, `description`, `MaxDurability`)
VALUES
    -- Windripper - PoE's "Windripper": a fast, cold-flavored bow for agile hunters.
    (9002005, 2, 2, 'Windripper', 64353, 4, 639000, 159750,
     15, -1, -1, 213, 75,
     0, 1,
     3, 115, 36, 60,
     310, 580, 0, 2800, 1,
     1, 'Every arrow leaves a wake of frost that never quite catches up to the shot.', 95),

    -- Atziri's Disfavour - PoE's "Atziri's Disfavour": a brutal 2H axe of pure aggression.
    (9002006, 2, 1, 'Atziri''s Disfavour', 64879, 4, 678000, 169500,
     17, -1, -1, 226, 78,
     0, 1,
     4, 145, 38, 210,
     410, 760, 0, 3400, 0,
     1, 'Its previous owner ruled from a throne of ash. It remembers the feeling.', 100);

-- --------------------------------------------------------------------------------------
--  SECTION B: Retail WoW-inspired backport items (9002010-9002019)
-- --------------------------------------------------------------------------------------

DELETE FROM `item_template` WHERE `entry` IN (9002010, 9002011, 9002012, 9002013, 9002014,
    9002015, 9002016, 9002019);

INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`,
     `maxcount`, `stackable`,
     `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`,
     `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`,
     `bonding`, `description`, `MaxDurability`)
VALUES
    -- Gauntlets of the Eternal Legion - Legion-flavored plate DPS gloves.
    (9002010, 4, 4, 'Gauntlets of the Eternal Legion', 64694, 4, 639000, 159750,
     10, -1, -1, 213, 75,
     0, 1,
     38, 165, 32, 55, 0, 0,
     660, 0, 0, 0, 0, 0, 0,
     1, 'Fel-scarred plate, backported from a war that never quite reached Azeroth.', 80),

    -- Bracers of Fel Corruption - Legion-flavored caster bracers.
    (9002011, 4, 1, 'Bracers of Fel Corruption', 64345, 4, 639000, 159750,
     9, -1, -1, 213, 75,
     0, 1,
     5, 75, 45, 65, 0, 0,
     145, 0, 0, 0, 0, 0, 0,
     1, 'The cloth wrapped around it never quite stops smoldering.', 70),

    -- Leggings of the Jailer's Chain - Shadowlands-flavored plate tank/melee legs.
    (9002012, 4, 4, 'Leggings of the Jailer''s Chain', 64588, 4, 678000, 169500,
     7, -1, -1, 226, 78,
     0, 1,
     4, 155, 7, 175, 0, 0,
     1680, 0, 0, 0, 0, 0, 0,
     1, 'Every link was forged to bind something far worse than the wearer.', 110),

    -- Ring of Domination - Shadowlands-flavored melee ring.
    (9002013, 4, 0, 'Ring of Domination', 64169, 4, 639000, 159750,
     11, -1, -1, 213, 75,
     0, 1,
     4, 65, 32, 55, 0, 0,
     0, 0, 0, 0, 0, 0, 0,
     1, 'To wear it is to command. To remove it is to be commanded instead.', 0),

    -- Signet of the Necrolord Covenant - Shadowlands-flavored caster ring.
    (9002014, 4, 0, 'Signet of the Necrolord Covenant', 63958, 4, 639000, 159750,
     11, -1, -1, 213, 75,
     0, 1,
     5, 70, 36, 50, 0, 0,
     0, 0, 0, 0, 0, 0, 0,
     1, 'A pact sealed in bone, sworn to hasten every spell cast in its name.', 0),

    -- Azerite Heart Core - BfA-flavored hybrid melee trinket.
    (9002015, 4, 0, 'Azerite Heart Core', 64244, 4, 639000, 159750,
     12, -1, -1, 213, 75,
     0, 1,
     7, 105, 38, 145, 0, 0,
     0, 0, 0, 0, 0, 0, 0,
     1, 'Still faintly glowing. Still faintly humming. Best not to ask why.', 0),

    -- Vision of Perfection Lens - BfA-flavored caster trinket.
    (9002016, 4, 0, 'Vision of Perfection Lens', 68107, 4, 639000, 159750,
     12, -1, -1, 213, 75,
     0, 1,
     5, 105, 45, 95, 0, 0,
     0, 0, 0, 0, 0, 0, 0,
     1, 'Look through it too long and it starts showing you spells you haven''t learned yet.', 0),

    -- Sigil of the Sepulcher - Shadowlands-flavored held-in-off-hand relic.
    (9002019, 4, 0, 'Sigil of the Sepulcher', 64440, 4, 639000, 159750,
     23, -1, -1, 213, 75,
     0, 1,
     7, 95, 6, 75, 0, 0,
     0, 0, 0, 0, 0, 0, 0,
     1, 'A quiet, patient thing. It has been waiting for a worthy hand for a long time.', 0);

-- Section B weapons
DELETE FROM `item_template` WHERE `entry` IN (9002017, 9002018);

INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`,
     `maxcount`, `stackable`,
     `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`,
     `dmg_min1`, `dmg_max1`, `dmg_type1`, `delay`, `ammo_type`,
     `bonding`, `description`, `MaxDurability`)
VALUES
    -- Dagger of the Venthyr Assassin - Shadowlands-flavored rogue/dps dagger.
    (9002017, 2, 15, 'Dagger of the Venthyr Assassin', 64678, 4, 639000, 159750,
     13, -1, -1, 213, 75,
     0, 1,
     3, 95, 32, 65,
     155, 285, 0, 1800, 0,
     1, 'It draws blood before the eye can register the swing.', 80),

    -- Staff of the Dragon Isles - Dragonflight-flavored caster staff.
    (9002018, 2, 10, 'Staff of the Dragon Isles', 64334, 4, 678000, 169500,
     17, -1, -1, 226, 78,
     0, 1,
     5, 165, 45, 185,
     205, 385, 0, 3000, 0,
     1, 'Carved from a single dragon-flame-tempered branch; still warm to the touch.', 90);

-- --------------------------------------------------------------------------------------
--  VENDOR: Planar Merchant - 9002500 (not spawned; see README.md, ".npc add 9002500")
-- --------------------------------------------------------------------------------------

DELETE FROM `creature_template` WHERE `entry` = 9002500;
INSERT INTO `creature_template`
    (`entry`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`,
     `faction`, `npcflag`, `speed_walk`, `speed_run`, `unit_class`, `unit_flags`, `type`,
     `type_flags`, `RegenHealth`, `flags_extra`, `AIName`, `ScriptName`)
VALUES
    (9002500, 'Planar Merchant', 'Ported Wares', 'Vendor', 0, 80, 80,
     35, 128, 1, 1.14286, 1, 0, 7,
     0, 1, 2, '', '');

DELETE FROM `creature_template_model` WHERE `CreatureID` = 9002500;
INSERT INTO `creature_template_model`
    (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`)
VALUES
    (9002500, 0, 27486, 1, 1);

DELETE FROM `npc_text` WHERE `ID` = 9002500;
INSERT INTO `npc_text` (`ID`, `text0_0`)
VALUES
    (9002500, 'Wares from a dozen worlds, all in one stall. Buy quickly, before this crossing closes.');

DELETE FROM `npc_vendor` WHERE `entry` = 9002500;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`)
VALUES
    (9002500, 1, 9002000, 0, 0, 0),
    (9002500, 2, 9002001, 0, 0, 0),
    (9002500, 3, 9002002, 0, 0, 0),
    (9002500, 4, 9002003, 0, 0, 0),
    (9002500, 5, 9002004, 0, 0, 0),
    (9002500, 6, 9002005, 0, 0, 0),
    (9002500, 7, 9002006, 0, 0, 0),
    (9002500, 8, 9002007, 0, 0, 0),
    (9002500, 9, 9002008, 0, 0, 0),
    (9002500, 10, 9002009, 0, 0, 0),
    (9002500, 11, 9002010, 0, 0, 0),
    (9002500, 12, 9002011, 0, 0, 0),
    (9002500, 13, 9002012, 0, 0, 0),
    (9002500, 14, 9002013, 0, 0, 0),
    (9002500, 15, 9002014, 0, 0, 0),
    (9002500, 16, 9002015, 0, 0, 0),
    (9002500, 17, 9002016, 0, 0, 0),
    (9002500, 18, 9002017, 0, 0, 0),
    (9002500, 19, 9002018, 0, 0, 0),
    (9002500, 20, 9002019, 0, 0, 0);
