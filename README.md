# mod-ported-items

An [AzerothCore](https://www.azerothcore.org/) module (WotLK 3.3.5a) that adds two small sets
of new gear, plus a vendor NPC that sells all of it. No client patch required - every item
reuses an existing in-game model.

## What it does

Adds 20 new items (entries `9002000`-`9002019`), split into two themed sets:

### Section A - Path of Exile-inspired uniques (`9002000`-`9002009`)

Ten items translating well-known [Path of Exile](https://www.pathofexile.com/) unique items
into WotLK-balanced stats and flavor text - same signature identity, sane 3.3.5a numbers.

| Item | Slot | Identity |
|------|------|----------|
| Headhunter's Cord | Belt | Mixed offense: Agility, Strength, Crit |
| Kaom's Molten Heart | Chest (plate) | Pure Stamina, nothing else |
| Goldrim's Guise | Helm | Low-level leveling helm, small all-resist |
| Shavronne's Wrappings | Chest (cloth) | Intellect + Spell Power |
| The Baron's Warcrown | Helm (plate) | Strength + Stamina |
| Windripper | Bow | Agility + Haste |
| Atziri's Disfavour | Two-handed axe | Strength + Attack Power |
| Wanderlust Treads | Boots | Agility + Stamina |
| Aegis Aurora | Shield | Stamina + Spirit |
| Bisco's Collar | Neck | Stamina + Crit |

### Section B - Retail WoW-inspired backports (`9002010`-`9002019`)

Ten items with modern-retail flavor (Legion, Shadowlands, Battle for Azeroth, Dragonflight),
backported to WotLK item budgets.

| Item | Slot | Identity |
|------|------|----------|
| Gauntlets of the Eternal Legion | Gloves (plate) | Attack Power + Crit |
| Bracers of Fel Corruption | Wrist (cloth) | Intellect + Spell Power |
| Leggings of the Jailer's Chain | Legs (plate) | Strength + Stamina |
| Ring of Domination | Ring | Strength + Crit |
| Signet of the Necrolord Covenant | Ring | Intellect + Haste |
| Azerite Heart Core | Trinket | Stamina + Attack Power |
| Vision of Perfection Lens | Trinket | Intellect + Spell Power |
| Dagger of the Venthyr Assassin | Dagger | Agility + Crit |
| Staff of the Dragon Isles | Staff | Intellect + Spell Power |
| Sigil of the Sepulcher | Held in off-hand | Stamina + Spirit |

All 20 items are epic quality (blue for the low-level `Goldrim's Guise`), bind on pickup, and
reuse an existing `displayid` from the world database - nothing is a "red cube".

## Vendor NPC

**Planar Merchant** (`creature_template` entry `9002500`) sells all 20 items and nothing else.
It is **not spawned anywhere by default** - the SQL only creates the template. To use it,
spawn one where you like from an in-game GM account:

```
.npc add 9002500
```

## Configuration

`conf/mod_ported_items.conf.dist`:

| Key                   | Default | Description                                          |
|------------------------|---------|-------------------------------------------------------|
| `PortedItems.Enable`   | `1`     | Master on/off switch (gates only the startup log line) |

The item rows and the vendor's stock are always present once the SQL update has applied -
`PortedItems.Enable = 0` doesn't remove them, it just silences the module's own startup
message. Items are inert until someone has them; the vendor NPC still needs a GM to spawn it
either way.

## Installation

Clone into your AzerothCore `modules/` directory and rebuild the worldserver. The module's SQL
(item entries + vendor NPC) is applied automatically by the DB updater on the next world start.

## License

Released under the GNU GPL v2 (or later).
