/*

Config for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = PAW_MODULE('ranks')

MODULE.Config = {
    Factions = {
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
    }, 

    Permissions = {
        ['superadmin'] = {
            '*'
        },
        ['mc'] = {
            'trp',
            'pvt'
        }
    }
}