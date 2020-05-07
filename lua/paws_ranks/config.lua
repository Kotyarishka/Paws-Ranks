/*

Config for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = PAW_MODULE('rank')
MODULE.Config = MODULE.Config or {}

MODULE.Config.Factions = {
    [1] = {
        Faction = {
            Name = 'ВАР',
            Icon = ''
        },
        Rank = {
            use = true, 
            Config = {
                ['msg'] = 'MSG'
            },
        },
        Number = {
            use = true,
        },
        Name = {
            use = true,
        }
    }
}

MODULE.Config.Permissions = {
    ['superadmin'] = {
        '*'
    },
    ['mc'] = {
        'trp',
        'pvt'
    }
}