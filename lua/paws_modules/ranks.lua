local MODULE = PAW_MODULE('ranks')
    :SetTitle('Ranks System')
    :SetAuthor('Kot')
    :SetVersion('0.0.1 Dev')
    :SetRoot('paws_ranks')
    :SetConfig('config.lua')
    :SetFileSystem({
        'func',
        'nets',
        'hook', 
        'vgui',
    })
    :SetNets({
        'Paws.ranks.Request.Change.Rank',
        'Paws.ranks.Request.Change.Number',
        'Paws.ranks.Request.Change.Name',
        'Paws.ranks.Open.Menu',
    })

return MODULE