/*

Permissions system for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = PAW_MODULE('ranks')
local cfg = MODULE.Config or {}

MODULE.Perms = {}

function MODULE.Perms:HasPermission(pPlayer, sRank)
    
    local sPlayerRank = MODULE.API:GetRank(pPlayer)
    local sPlayerUserGroup = pPlayer:GetUserGroup()
    
    local tPlayerRankPerms = cfg.Permissions[sPlayerRank] or {}
    local tPlayerGroupPerms = cfg.Permissions[sPlayerUserGroup] or {}

    if table.HasValue(tPlayerRankPerms, sRank) then
        return true
    end

    if table.HasValue(tPlayerGroupPerms, sRank) then
        return true
    end

    if table.HasValue(tPlayerRankPerms, '*') then
        return true
    end

    if table.HasValue(tPlayerGroupPerms, '*') then
        return true
    end

    return false
end