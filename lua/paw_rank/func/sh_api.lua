/*

API functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')
MODULE.Rank = MODULE.Rank or {}
MODULE.Config = MODULE.Config or {}

MODULE.API = {}

/*
    Get current name 
    usage: MODULE.API:GetName(player Player)
*/

function MODULE.API:GetName(pPlayer)
    return pPlayer:GetNWString( 'Paws.'..MODULE.UID..'.Name', false )
end

/*
    Get current number 
    usage: MODULE.API:GetName(player Player)
*/

function MODULE.API:GetNumber(pPlayer)
    return pPlayer:GetNWString( 'Paws.'..MODULE.UID..'.Number', false )
end

/*
    Get current rank 
    usage: MODULE.API:GetName(player Player)
*/

function MODULE.API:GetRank(pPlayer)
    return pPlayer:GetNWString( 'Paws.'..MODULE.UID..'.Rank', false )
end

/*
    Get current rank (formatted)
    usage: MODULE.API:GetName(player Player)
*/

function MODULE.API:GetRankFormatted(pPlayer)
    local sRankToReturn = pPlayer:GetNWString( 'Paws.'..MODULE.UID..'.Rank', false )
    
    local tJob = RPExtraTeams[pPlayer:Team()]
    local tFactionConfig = MODULE.Config.Factions[tJob.faction]

    if tFactionConfig.Rank.Config[sRank] then
        sRankToReturn = tFactionConfig.Rank.Config[sRank]
    else
        sRankToReturn = string.upper(sRankToReturn)
    end
    
    return sRankToReturn
end