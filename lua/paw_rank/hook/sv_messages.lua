/*

Player functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = Paws.Lib.Module('rank')
MODULE.Config = MODULE.Config or {}

local api = MODULE.API
local cfg = MODULE.Config
local messages = Paws.Lib.Chat

hook.Add('Paws.'..MODULE.UID..'.Name.Change', 'Paws.'..MODULE.UID..'.Name.Change', function(pPlayer, pActor, sName, sOldName, nJob)
    
    Paws.Lib:SendMessage(pActor, messages.SUCCESS, 'Вы установили новое имя/новый позывной для ', messages.SUCCESS_COLOR, sOldName, messages.NONE_COLOR, '. Его новый позывной: ', messages.SUCCESS_COLOR, '"', sName, '"', messages.NONE_COLOR, '.')
    Paws.Lib:SendMessage(pPlayer, messages.SUCCESS, 'Вам установлен позывной/имя ', messages.SUCCESS_COLOR, '"', sName, '"', messages.NONE_COLOR, '. Установил ', pActor:Name(), '.')

end)

hook.Add('Paws.'..MODULE.UID..'.Number.Change', 'Paws.'..MODULE.UID..'.Number.Change', function(pPlayer, pActor, sNumber, sOldNumber, nJob)
    
    Paws.Lib:SendMessage(pActor, messages.SUCCESS, 'Вы установили новый номер для ', messages.SUCCESS_COLOR, api:GetName(pPlayer), messages.NONE_COLOR, '. Его новый номер: ', messages.SUCCESS_COLOR, '"', sNumber, '"', messages.NONE_COLOR, '.')
    Paws.Lib:SendMessage(pPlayer, messages.SUCCESS, 'Вам установлен номер ', messages.SUCCESS_COLOR, '"', sNumber, '"', messages.NONE_COLOR, '. Установил ', pActor:Name(), '.')

end)

hook.Add('Paws.'..MODULE.UID..'.Rank.Change', 'Paws.'..MODULE.UID..'.Rank.Change', function(pPlayer, pActor, sRank, sOldRank, nJob)
    
    Paws.Lib:SendMessage(pActor, messages.SUCCESS, 'Вы установили новое звание для ', messages.SUCCESS_COLOR, api:GetName(pPlayer), messages.NONE_COLOR, '. Его новое звание: ', messages.SUCCESS_COLOR, '"', api:RankFormat(pPlayer, sRank), '"', messages.NONE_COLOR, '.')
    Paws.Lib:SendMessage(pPlayer, messages.SUCCESS, 'Вам установлено звание ', messages.SUCCESS_COLOR, '"', api:RankFormat(pPlayer, sRank), '"', messages.NONE_COLOR, '. Установил ', pActor:Name(), '.')
    
end)