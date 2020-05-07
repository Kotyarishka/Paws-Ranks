local MODULE = PAW_MODULE('ranks')
MODULE.Config = MODULE.Config or {}

local lib = PAW_MODULE('lib')

lib:Command('ranks')
    :SetTitle('Ranks System Access')
    :SetDescription('Ranks System Panel Call')
    :SetOnRunFunction(function(pPlayer, sText)
        net.Start('Paws.'..MODULE.uID..'.Open.Menu')
            net.WriteEntity(pPlayer)
        net.Send(pPlayer)
    end)