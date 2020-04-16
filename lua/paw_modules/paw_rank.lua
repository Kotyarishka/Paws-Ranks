/*

Module for Paws Module System

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')

MODULE.Title = 'Ranks'
MODULE.Author = 'Kot'
MODULE.Version = '0.0.1'

MODULE.MAIN_ROOT = 'paw_rank'
MODULE.CONFIG = 'config.lua'
MODULE.INIT = 'init.lua'

MODULE.FILESYSTEM = {
    'func',
    'nets',
    'hook',
    'vgui',
}

MODULE.NETS = {
 
}

local function Load()
    AddCSLuaFile(MODULE.MAIN_ROOT..'/'..MODULE.CONFIG)
    include(MODULE.MAIN_ROOT..'/'..MODULE.CONFIG)

    AddCSLuaFile(MODULE.MAIN_ROOT..'/'..MODULE.INIT)
    include(MODULE.MAIN_ROOT..'/'..MODULE.INIT)
end 

return MODULE, Load()