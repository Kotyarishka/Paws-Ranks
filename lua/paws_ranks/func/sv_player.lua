/*

Player functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = PAW_MODULE('ranks')
MODULE.Config = MODULE.Config or {}

local db = MODULE.Database

MODULE.Ply = {}

local function getRank(pPlayer, nOldJob, nNewJob)
    
    local tOldJob = RPExtraTeams[nOldJob]
    local tNewJob = RPExtraTeams[nNewJob]

    print(tOldJob.category)
    print(tNewJob.category) 

    if tOldJob.category == tNewJob.category then
        if MODULE.API:GetRank(pPlayer) == '' then
            return tNewJob.ranks.default
        else
            if tNewJob.ranks[MODULE.API:GetRank(pPlayer)] then
                return MODULE.API:GetRank(pPlayer)
            else
                return tNewJob.ranks.default
            end
        end
    else
        return tNewJob.ranks.default
    end
end

local function getNumber(pPlayer)
    
    if MODULE.API:GetNumber(pPlayer) == '' then
        local sSteamID64 = tostring(pPlayer:SteamID64())
        local sNumber = string.sub(sSteamID64, string.len(sSteamID64)-3)

        return sNumber
    else
        return MODULE.API:GetNumber(pPlayer)
    end

end

local function getName(pPlayer)
    if MODULE.API:GetName(pPlayer) == '' then
        return pPlayer:Nick()
    else
        return MODULE.API:GetName(pPlayer)
    end
end

local function savePlayer(pPlayer, tData)
    local sPath = 'paws/'..MODULE.uID..'/'..pPlayer:SteamID64()..'.txt'

    local sData = util.TableToJSON(tData, true)

    file.Write(sPath, sData)
end

function MODULE.Ply:InitPlayer(pPlayer)
    local sPath = 'paws/'..MODULE.uID..'/'..pPlayer:SteamID64()..'.txt'
    local bPlayerFile = file.Exists(sPath, 'DATA')

    if !bPlayerFile then
        file.Write(sPath, '[]')
    end

    local tData = util.JSONToTable(file.Read(sPath) or '[]')

    return tData
end

function MODULE.Ply:UpdateName(pPlayer)
    local tNameToReturn = {}
    local tJob = RPExtraTeams[pPlayer:Team()]
    local tFactionConfig = MODULE.Config.Factions[tJob.faction]

    if tFactionConfig.Rank.use then
        table.insert(tNameToReturn, MODULE.API:GetRankFormatted(pPlayer))
    end 

    if tFactionConfig.Number.use then
        table.insert(tNameToReturn, MODULE.API:GetNumber(pPlayer))
    end

    if tFactionConfig.Name.use then
        table.insert(tNameToReturn, MODULE.API:GetName(pPlayer))
    end

    pPlayer:setDarkRPVar('rpname', table.concat(tNameToReturn, ' '))
end

function MODULE.Ply:LoadJob(pPlayer)
    local tData = MODULE.Ply:InitPlayer(pPlayer)
    local sJob = team.GetName(pPlayer:Team())

    local tJobData = tData[sJob]

    pPlayer:SetNWString('Paws.'..MODULE.uID..'.Rank', tJobData.Rank)
    pPlayer:SetNWString('Paws.'..MODULE.uID..'.Number', tJobData.Number)
    pPlayer:SetNWString('Paws.'..MODULE.uID..'.Name', tJobData.Name)

    local tJob = RPExtraTeams[pPlayer:Team()].ranks[MODULE.API:GetRank(pPlayer)]

    pPlayer:SetMaxHealth(tJob.hp)
    pPlayer:SetHealth(tJob.hp)

    pPlayer:SetArmor(tJob.armor)

    if istable(tJob.model) then
        local nModel = math.random(1, table.Count(tJob.model))

        pPlayer:SetModel(tJob.model[nModel])
    else
        pPlayer:SetModel(tJob.model)
    end

    if tJob.customFunc then
        tJob.customFunc(pPlayer)
    end

    MODULE.Ply:UpdateName(pPlayer)
end

function MODULE.Ply:CreateJob(pPlayer, nOldJob, nNewJob)
    local tData = MODULE.Ply:InitPlayer(pPlayer)
    local sJob = team.GetName(pPlayer:Team())

    if !tJobData then
        tData[sJob] = {
            Rank = getRank(pPlayer, nOldJob, nNewJob),
            Number = getNumber(pPlayer),
            Name = getName(pPlayer),
            Flags = {}
        }
    end

    savePlayer(pPlayer, tData)

    MODULE.Ply:LoadJob(pPlayer)
end

function MODULE.Ply:InitJob(pPlayer, nOldJob, nNewJob)

    if !nOldJob then nOldJob = pPlayer:Team() end
    if !nNewJob then nNewJob = pPlayer:Team() end

    local tData = MODULE.Ply:InitPlayer(pPlayer)
    local sJob = team.GetName(pPlayer:Team())

    if tData[sJob] then
        MODULE.Ply:LoadJob(pPlayer)
    else
        MODULE.Ply:CreateJob(pPlayer, nOldJob, nNewJob)
    end
end

/*
    Player set name
    usage:  MODULE.Ply:SetName(player Player, string Name, player Actor, number Job = Player:Team() )
*/

function MODULE.Ply:SetName(pPlayer, sName, pActor, nJob)

    if !db:Init() then db:Init() end

    if !nJob then nJob = pPlayer:Team() end

    local tData = MODULE.Ply:InitPlayer(pPlayer)
    local sJob = team.GetName(nJob)

    local sOldName = MODULE.API:GetName(pPlayer)

    if tData[sJob] then
        tData[sJob].Name = sName

        pPlayer:SetNWString('Paws.'..MODULE.uID..'.Name', sName)

        MODULE.Ply:UpdateName(pPlayer)
        savePlayer(pPlayer, tData)

        hook.Run('Paws.'..MODULE.uID..'.Name.Change', pPlayer, pActor, sName, sOldName, nJob)
    end

end

/*
    Player set number
    usage:  MODULE.Ply:SetNumber(player Player, string Number, number Job = Player:Team(), player Actor)
*/

function MODULE.Ply:SetNumber(pPlayer, sNumber, pActor, nJob)
    if !db:Init() then db:Init() end

    if !nJob then nJob = pPlayer:Team() end

    local tData = MODULE.Ply:InitPlayer(pPlayer)
    local sJob = team.GetName(nJob)

    local sOldNumber = MODULE.API:GetNumber(pPlayer)

    if tData[sJob] then
        tData[sJob].Number = sNumber

        pPlayer:SetNWString('Paws.'..MODULE.uID..'.Number', sNumber)

        MODULE.Ply:UpdateName(pPlayer)
        savePlayer(pPlayer, tData)

        hook.Run('Paws.'..MODULE.uID..'.Number.Change', pPlayer, pActor, sNumber, sOldNumber, nJob)
    end
end

/*
    Player set rank
    usage:  MODULE.Ply:SetRank(player Player, string Rank, number Job = Player:Team(), player Actor)
*/

function MODULE.Ply:SetRank(pPlayer, sRank, pActor, nJob)
    if !db:Init() then db:Init() end

    if !nJob then nJob = pPlayer:Team() end

    local tData = MODULE.Ply:InitPlayer(pPlayer)
    local sJob = team.GetName(nJob)

    local sOldRank = MODULE.API:GetRank(pPlayer)

    if tData[sJob] then
        tData[sJob].Rank = sRank

        pPlayer:SetNWString('Paws.'..MODULE.uID..'.Rank', sRank)

        MODULE.Ply:UpdateName(pPlayer)
        savePlayer(pPlayer, tData)

        hook.Run('Paws.'..MODULE.uID..'.Rank.Change', pPlayer, pActor, sRank, sOldRank, nJob)
    end
end