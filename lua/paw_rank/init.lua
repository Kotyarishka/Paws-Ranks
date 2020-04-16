/*

Init for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')
MODULE.Rank = MODULE.Rank or {}
MODULE.Config = MODULE.Config or {}

for k, dir in pairs(MODULE.FILESYSTEM) do
    local files = file.Find(MODULE.MAIN_ROOT..'/'..dir..'/*', 'LUA')

    for k, v in pairs(files) do
        if string.StartWith(v, 'sv') then
            if SERVER then
                local load = include(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
                if load then load() end

                MsgC(Color(0, 255, 0), '[Aw... Paws!]', '['..MODULE.Title..']', ' Loaded "'..v..'" from "'..dir..'" successfully\n')
            end 
        end 

        if string.StartWith(v, 'cl') then
            if CLIENT then
                local load = include(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
                if load then load() end 
            end

            AddCSLuaFile(MODULE.MAIN_ROOT..'/'..dir..'/'..v)

            MsgC(Color(0, 255, 0), '[Aw... Paws!]', '['..MODULE.Title..']', ' Loaded "'..v..'" from "'..dir..'" successfully\n')
        end

        if string.StartWith(v, 'sh') then
            local load = include(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
            if load then load() end

            AddCSLuaFile(MODULE.MAIN_ROOT..'/'..dir..'/'..v)

            MsgC(Color(0, 255, 0), '[Aw... Paws!]', '['..MODULE.Title..']', ' Loaded "'..v..'" from "'..dir..'" successfully\n')
        end 
    end 
end

for k, v in pairs(MODULE.NETS) do
    if SERVER then 
        util.AddNetworkString(v)
        MsgC(Color(0, 255, 0), '[Aw... Paws!]', '['..MODULE.Title..']', ' Registered Network string "'..v..'" successfully\n' )
    end
end
