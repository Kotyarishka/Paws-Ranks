/*

Database functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')
MODULE.Config = MODULE.Config or {}

MODULE.Database = {}

/*
    Database init function
*/

function MODULE.Database:Init()
    local path = 'paws/'..MODULE.UID..'/'

    if !file.Exists(path, 'DATA') then
        file.CreateDir(path)
    end

    return true
end