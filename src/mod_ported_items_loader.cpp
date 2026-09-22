/*
 * mod-ported-items loader.
 *
 * The playerbots fork auto-globs every module's sources into one lib and looks
 * up a loader symbol derived from the folder name: for folder "mod-ported-items"
 * that symbol is exactly "Addmod_ported_itemsScripts". It must exist and call our
 * real registration function.
 *
 * Released under GNU GPL v2 or (at your option) any later version.
 */

void AddPortedItemsScripts();

void Addmod_ported_itemsScripts()
{
    AddPortedItemsScripts();
}
