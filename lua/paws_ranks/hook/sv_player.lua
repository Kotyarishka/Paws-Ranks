/*

Player functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = PAW_MODULE('ranks')
MODULE.Config = MODULE.Config or {}

local db = MODULE.Database
local api = MODULE.API
local ply = MODULE.Ply

/*
    Load model/skin/hp/armor on first spawn
*/

hook.Add('PlayerInitialSpawn', 'Paws.'..MODULE.uID..'Load.Player.InitSpawn', function(pPlayer)
    timer.Simple(5, function() MODULE.Ply:InitJob(pPlayer, pPlayer:Team(), pPlayer:Team()) end)
end)

/*
    Load model/skin/hp/armor on spawn
*/

hook.Add('PlayerSpawn', 'Paws.'..MODULE.uID..'.Load.Player.RegularSpawn', function(pPlayer)
    timer.Simple(5, function() MODULE.Ply:InitJob(pPlayer, pPlayer:Team(), pPlayer:Team()) end)
end)

/*
    Load rank after change.
*/

hook.Add('Paws.'..MODULE.uID..'.Rank.Change', 'Paws.'..MODULE.uID..'.Rank.Job', function(pPlayer, pActor, sRank, sOldRank, nJob)
    MODULE.Ply:InitJob(pPlayer, pPlayer:Team(), pPlayer:Team())    
end)

/*
    Load job on change job
*/

hook.Add('OnPlayerChangedTeam', 'Paws.'..MODULE.uID..'.Change.Team', function(pPlayer, nBefore, nAfter)
    timer.Simple(5, function() MODULE.Ply:InitJob(pPlayer, nBefore, nAfter) end)
end)