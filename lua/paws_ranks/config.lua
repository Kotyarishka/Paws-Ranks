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
        },
        Default = {
            Faction = {
                Name = 'Стандартная',
                Icon = ''
            },
            Rank = {
                use = false, 
                Config = {},
            },
            Number = {
                use = false,
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
            'pvt',
            'pfc',
            'cpl',
            'sgt',
            'shs',
            'sfc',
            'msg',
            'lt',
            'ltc',
            'cpt',
            'maj',
            'lc',
            'col',
            'cc',
            'mcc',
        },
        ['mcc'] = {
            'trp',
            'pvt',
            'pfc',
            'cpl',
            'sgt',
            'shs',
            'sfc',
            'msg',
            'lt',
            'ltc',
            'cpt',
            'maj',
            'lc',
            'col',
            'cc',
        },
        ['cc'] = {
            'trp',
            'pvt',
            'pfc',
            'cpl',
            'sgt',
            'shs',
            'sfc',
            'msg',
            'lt',
            'ltc',
            'cpt',
            'maj',
            'lc',
            'col',
        }
    }
}