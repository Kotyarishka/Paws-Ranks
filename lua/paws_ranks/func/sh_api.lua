/*

API functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = PAW_MODULE('ranks')
MODULE.Config = MODULE.Config or {}

MODULE.API = {}

/*
    Get current name 
    usage: MODULE.API:GetName(player Player)
*/

function MODULE.API:GetName(pPlayer)
    return pPlayer:GetNWString( 'Paws.'..MODULE.uID..'.Name', nil )
end

/*
    Get current number 
    usage: MODULE.API:GetNumber(player Player)
*/

function MODULE.API:GetNumber(pPlayer)
    return pPlayer:GetNWString( 'Paws.'..MODULE.uID..'.Number', nil )
end

/*
    Get current rank 
    usage: MODULE.API:GetRank(player Player)
*/

function MODULE.API:GetRank(pPlayer)
    return pPlayer:GetNWString( 'Paws.'..MODULE.uID..'.Rank', nil )
end

/*
    Get current rank (formatted)
    usage: MODULE.API:GetRankFormatted(player Player)
*/

function MODULE.API:GetRankFormatted(pPlayer)
    local sRankToReturn = pPlayer:GetNWString( 'Paws.'..MODULE.uID..'.Rank', nil )
    
    local tJob = RPExtraTeams[pPlayer:Team()]
    local tFactionConfig = MODULE.Config.Factions[tJob.faction]

    if tFactionConfig.Rank.Config[sRank] then
        sRankToReturn = tFactionConfig.Rank.Config[sRank]
    else
        sRankToReturn = string.upper(sRankToReturn)
    end
    
    return sRankToReturn
end

function MODULE.API:FormatRank(pPlayer, sRank)
    local sRankToReturn = sRank
    
    local tJob = RPExtraTeams[pPlayer:Team()]
    local tFactionConfig = MODULE.Config.Factions[tJob.faction]

    if table.HasValue(tFactionConfig.Rank.Config, sRank) then
        sRankToReturn = tFactionConfig.Rank.Config[sRank]
    else
        sRankToReturn = string.upper(sRankToReturn)
    end
    
    return sRankToReturn
end