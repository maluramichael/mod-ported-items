/*
 * mod-ported-items
 *
 * Pure content module: two sets of new item entries (9002000-9002019) plus a
 * "Planar Merchant" vendor NPC (creature_template entry 9002500) that sells all of
 * them. All the actual gameplay data lives in SQL
 * (data/sql/db-world/updates/mod_ported_items_2026_09_22_00.sql); this file only
 * exists so the module has a src/ target (required for the fork's module loader to
 * register the module, and for its SQL update to be picked up by the DB updater)
 * and so the feature can be toggled without touching the database.
 *
 *   - Section A: Path of Exile-inspired unique items (entries 9002000-9002009)
 *   - Section B: Retail WoW-inspired backport items (entries 9002010-9002019)
 *   - Vendor: "Planar Merchant" (creature_template entry 9002500, not spawned by
 *     default - see README.md for ".npc add 9002500")
 *
 * PortedItems.Enable only gates the startup log line below; the item rows and the
 * vendor's npc_vendor list are always present once the SQL update has applied
 * (items are inert until someone has them; the vendor NPC has to be spawned by a
 * GM either way). Released under GNU GPL v2 or (at your option) any later version.
 */

#include "Config.h"
#include "Log.h"
#include "ScriptMgr.h"

namespace PortedItems
{
    struct Config
    {
        bool Enable = true;
    };

    Config& GetConfig()
    {
        static Config cfg;
        return cfg;
    }
}

class PortedItemsWorldScript : public WorldScript
{
public:
    PortedItemsWorldScript() : WorldScript("PortedItems_WorldScript") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        PortedItems::Config& cfg = PortedItems::GetConfig();
        cfg.Enable = sConfigMgr->GetOption<bool>("PortedItems.Enable", true);
    }

    void OnStartup() override
    {
        PortedItems::Config const& cfg = PortedItems::GetConfig();
        if (cfg.Enable)
        {
            LOG_INFO("server.loading", "mod-ported-items: enabled - items 9002000-9002019, "
                "vendor NPC 9002500 (Planar Merchant, spawn with '.npc add 9002500')");
        }
        else
        {
            LOG_INFO("server.loading", "mod-ported-items: disabled via PortedItems.Enable");
        }
    }
};

void AddPortedItemsScripts()
{
    new PortedItemsWorldScript();
}
