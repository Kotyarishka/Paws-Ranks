/*

Player functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')
MODULE.Config = MODULE.Config or {}

local db = MODULE.Database

MODULE.Ply = {}

/*
    Player init function
*/

function MODULE.Ply:Init(pPlayer)

    if !db:Init() then db:Init() end

    local sSteamID64 = tostring(pPlayer:SteamID64())
    
    local path = 'paws/'..MODULE.UID..'/'..sSteamID64..'.txt'

    if file.Exists(path, 'DATA') then
        local data = util.JSONToTable(file.Read(path, 'DATA'))
        return data
    else
        file.Write(path, util.TableToJSON({}))
        return {}
    end
    
    return {}

end

/*
    Utils: Defaul Rank, Deafault Number, Default Name, Write Player File
*/

local function getDefaultName(pPlayer, nOldJob, nNewJob)

    nOldJob = RPExtraTeams[nOldJob]
    nNewJob = RPExtraTeams[nNewJob]

    if nOldJob.category == nNewJob.category then
        return MODULE.API:GetName(pPlayer)
    end

    if !MODULE.API:GetName(pPlayer) then
        return MODULE.API:GetName(pPlayer)
    end

    return pPlayer:Nick()
end

local function getDefaultNumber(pPlayer, nOldJob, nNewJob)

    nOldJob = RPExtraTeams[nOldJob]
    nNewJob = RPExtraTeams[nNewJob]

    if nOldJob.category == nNewJob.category then
        return MODULE.API:GetNumber(pPlayer)
    end
    
    local sSteamID64 = tostring(pPlayer:SteamID64())
    local sNumber = string.sub(sSteamID64, string.len(sSteamID64) - 3)

    if MODULE.API:GetNumber(pPlayer) then
        sNumber = MODULE.API:GetNumber(pPlayer)
    end

    return sNumber
end 

local function getDefaultRank(pPlayer, nOldJob, nNewJob)

    nOldJob = RPExtraTeams[nOldJob]
    nNewJob = RPExtraTeams[nNewJob]

    if nOldJob.category == nNewJob.category then
        return MODULE.API:GetRank(pPlayer)
    end

    local tJob = pPlayer:getJobTable()
    local nFaction = jTbl.fraction or 1

    local sRank = MODULE.Config.Ranks[nFaction].default

    if tJob.ranks && tJob.ranks.default then
        nFaction = tJob.ranks.default
    end

    return sRank
end

local function writePlayerFile(pPlayer, tData)
    local tData = util.TableToJSON(tData, true)
    local path = 'paws/'..MODULE.UID..'/'..sSteamID64..'.txt'

    file.Write(path, tData)
end

/*
    Player update name
    usage: MODULE.Ply:UpdateName(player Player)
*/

function MODULE.Ply:UpdateName(pPlayer)
    local sRank = MODULE.API:GetRank(pPlayer)
    local sName = MODULE.API:GetName(pPlayer)
    local sNumber = MODULE.API:GetNumber(pPlayer)

    local tJob = RPExtraTeams[pPlayer:Team()]

    local tFactionConfig = MODULE.Config.Factions[tJob.faction]

    local tNameToReturn = {}

    if tFactionConfig.Rank.use then
        if tFactionConfig.Rank.Config[sRank] then
            table.insert(tNameToReturn, tFactionConfig.Rank.Config[sRank])
        else
            table.insert(tNameToReturn, string.upper(sRank))
        end
    end

    if tFactionConfig.Number.use and !tJob.forceNumberOff then
        table.insert(tNameToReturn, sNumber)
    end

    table.insert(tNameToReturn, sName)

    ply:setDarkRPVar('rpname', table.concat(tNameToReturn, ' ')) 
end

/*
    Player add job function
    usage: MODULE.Ply:AddJob(player Player, number Old Job, number New Job)
*/

function MODULE.Ply:AddJob(pPlayer, nOldJob, nNewJob)
    
    if !db:Init() then db:Init() end

    local tData = MODULE.Ply:Init(pPlayer)
    local sJob = team.GetName(pPlayer:Team())

    if !nOldJob then
        nOldJob = pPlayer:Team()
    end

    if !nNewJob then
        nNewJob = pPlayer:Team()
    end

    if !tData[sJob] then
        
        tData[sJob] = {
            Name = getDefaultName(pPlayer, nOldJob, nNewJob),
            Number = getDefaultNumber(pPlayer, nOldJob, nNewJob),
            Rank = getDefaultRank(pPlayer, nOldJob, nNewJob)
        }
        
        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Name', getDefaultName(pPlayer, nOldJob, nNewJob))
        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Number', getDefaultNumber(pPlayer, nOldJob, nNewJob))
        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Rank', getDefaultRank(pPlayer, nOldJob, nNewJob))

        writePlayerFile(pPlayer, tData)
    end
    
    return tData[sJob]

end

/*
    Player remove job function
    usage: MODULE.Ply:RemoveJob(player Player, number Job)
*/

function MODULE.Ply:RemoveJob(pPlayer, nJob)

    if !db:Init() then db:Init() end

    if !nJob then nJob = pPlayer:Team() end

    local tData = MODULE.Ply:Init(pPlayer)
    local sJob = team.GetName(nJob)

    if tData[sJob] then
        table.Empty(tData[sJob])
        writePlayerFile(pPlayer, tData)
    end
end

/*
    Player load job function
    usage: MODULE.Ply:LoadJob(player Player, number Old Job, number New Job)
*/

function MODULE.Ply:LoadJob(pPlayer)
    
    if !db:Init() then db:Init() end

    local tData = MODULE.Ply:Init(pPlayer)
    local sJob = team.GetName(pPlayer:Team())

    if !tData[sJob] then
        return MODULE.Ply.AddJob(pPlayer)
    else
        local tDataC = tData[sJob]

        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Name', tDataC.Name)
        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Number', tDataC.Number)
        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Rank', tDataC.Rank)

        MODULE.Ply:UpdateName(pPlayer)
    end
    
    return tData[sJob]

end

/*
    Player init job function
    usage: MODULE.Ply:InitJob(player Player, number Old Job, number New Job)
*/

function MODULE.Ply:LoadJob(pPlayer)
    
    if !db:Init() then db:Init() end

    local tData = MODULE.Ply:Init(pPlayer)
    local sJob = team.GetName(pPlayer:Team())

    local tJob = RPExtraTeams[pPlayer:Team()]
    local tRanks = tJob.ranks
    
    if tRanks[MODULE.API:GetRank(pPlayer)] then

        local tRankInfo = tRanks[MODULE.API:GetRank(pPlayer)]

        pPlayer:SetMaxHealth(tRankInfo.hp)
        pPlayer:SetHealth(tRankInfo.hp)

        pPlayer:SetArmor(tRankInfo.armor)

        if istable(tRankInfo.model) then
            local nModelID = math.random(1, table.Count(tRankInfo.model))
            
            pPlayer:SetModel(tRankInfo.model[nModelID])
        else
            pPlayer:SetModel(tRankInfo.model)
        end

        if tRankInfo.customFunc then
            tRankInfo.customFunc(pPlayer)
        end

    end

    
    return tData[sJob]

end

/*
    Player set name
    usage:  MODULE.Ply:SetName(player Player, string Name, player Actor, number Job = Player:Team() )
*/

function MODULE.Ply:SetName(pPlayer, sName, pActor, nJob)

    if !db:Init() then db:Init() end

    if !nJob then nJob = pPlayer:Team() end

    local tData = MODULE.Ply:Init(pPlayer)
    local sJob = team.GetName(nJob)

    local sOldName = MODULE.API:GetName(pPlayer)

    if tData[sJob] then
        tData[sJob].Name = sName

        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Name', sName)

        MODULE.Ply:UpdateName(pPlayer)
        writePlayerFile(pPlayer, tData)

        hook.Run('Paws.'..MODULE.UID..'.Name.Change', pPlayer, pActor, sName, sOldName, nJob)
    end

end

/*
    Player set number
    usage:  MODULE.Ply:SetNumber(player Player, string Number, number Job = Player:Team(), player Actor)
*/

function MODULE.Ply:SetNumber(pPlayer, sNumber, pActor, nJob)
    if !db:Init() then db:Init() end

    if !nJob then nJob = pPlayer:Team() end

    local tData = MODULE.Ply:Init(pPlayer)
    local sJob = team.GetName(nJob)

    local sOldNumber = MODULE.API:GetNumber(pPlayer)

    if tData[sJob] then
        tData[sJob].Number = sName

        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Number', sNumber)

        MODULE.Ply:UpdateName(pPlayer)
        writePlayerFile(pPlayer, tData)

        hook.Run('Paws.'..MODULE.UID..'.Number.Change', pPlayer, pActor, sNumber, sOldNumber, nJob)
    end
end

/*
    Player set rank
    usage:  MODULE.Ply:SetRank(player Player, string Rank, number Job = Player:Team(), player Actor)
*/

function MODULE.Ply:SetRank(pPlayer, sRank, pActor, nJob)
    if !db:Init() then db:Init() end

    if !nJob then nJob = pPlayer:Team() end

    local tData = MODULE.Ply:Init(pPlayer)
    local sJob = team.GetName(nJob)

    local sOldRank = MODULE.API:GetRank(pPlayer)

    if tData[sJob] then
        tData[sJob].Rank = sName

        pPlayer:SetNWString('Paws.'..MODULE.UID..'.Rank', sRank)

        MODULE.Ply:UpdateName(pPlayer)
        writePlayerFile(pPlayer, tData)

        hook.Run('Paws.'..MODULE.UID..'.Rank.Change', pPlayer, pActor, sRank, sOldRank, nJob)
    end
end