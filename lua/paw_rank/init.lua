/*

Init for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')
MODULE.Rank = MODULE.Rank or {}
MODULE.Config = MODULE.Config or {}

for k, dir in pairs(MODULE.FILESYSTEM) do

    MsgC(Color(0, 255, 0), '[Aw... Paws!]', '['..MODULE.Title..']', ' Loading dir "'..dir..'"...\n')

    local files = file.Find(MODULE.MAIN_ROOT..'/'..dir..'/*', 'LUA')

    for k, v in pairs(files) do
        if string.StartWith(v, 'sv') then
            if SERVER then
                local load = include(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
                if load then load() end
            end 
        end 

        if string.StartWith(v, 'cl') then
            if CLIENT then
                local load = include(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
                if load then load() end 
            end

            AddCSLuaFile(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
        end

        if string.StartWith(v, 'sh') then
            local load = include(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
            if load then load() end

            AddCSLuaFile(MODULE.MAIN_ROOT..'/'..dir..'/'..v)
        end 

        MsgC(Color(190, 252, 3), '[Aw... Paws!]', '['..MODULE.Title..']', ' Loaded "'..v..'" successfully\n')
    end 

    MsgC(Color(0, 255, 0), '[Aw... Paws!]', '['..MODULE.Title..']', ' Loaded dir "'..dir..'" successfully\n')

end

for k, v in pairs(MODULE.NETS) do
    if SERVER then 
        util.AddNetworkString(v)
        MsgC(Color(0, 255, 0), '[Aw... Paws!]', '['..MODULE.Title..']', ' Registered Network string "'..v..'" successfully\n' )
    end
end
