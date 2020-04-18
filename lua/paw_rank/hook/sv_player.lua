/*

Player functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')
MODULE.Config = MODULE.Config or {}

local db = MODULE.Database
local api = MODULE.API
local ply = MODULE.Ply

/*
    Load model/skin/hp/armor on first spawn
*/

hook.Add('PlayerInitialSpawn', 'Paws.'..MODULE.UID..'Load.Player', function(pPlayer)
    timer.Simple(5, function()
        ply:InitJob(pPlayer)
    end)
end)

/*
    Load model/skin/hp/armor on spawn
*/

hook.Add('PlayerSpawn', 'Paws.'..MODULE.UID..'.Load.Sapwn.Player', function(pPlayer)
    timer.Simple(5, function()
        ply:InitJob(pPlayer)
    end)
end)