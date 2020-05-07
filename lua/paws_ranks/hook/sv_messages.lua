/*

Player functions for Paws Module 'Rank'

Made by Kot from "🐾 Aw... Paws!"

*/

local MODULE = PAW_MODULE('ranks')
MODULE.Config = MODULE.Config or {}

local lib = PAW_MODULE('lib')

local api = MODULE.API
local cfg = MODULE.Config
local messages = lib.Config.Chat

hook.Add('Paws.'..MODULE.uID..'.Name.Change', 'Paws.'..MODULE.uID..'.Name.Change', function(pPlayer, pActor, sName, sOldName, nJob)
    
    lib:SendMessage(pActor, messages.MESSAGES_TYPE.SUCCESS, 'Вы установили новое имя/новый позывной для ', messages.SUCCESS_COLOR, sOldName, messages.NONE_COLOR, '. Его новый позывной: ', messages.SUCCESS_COLOR, '"', sName, '"', messages.NONE_COLOR, '.')
    lib:SendMessage(pPlayer, messages.MESSAGES_TYPE.SUCCESS, 'Вам установлен позывной/имя ', messages.SUCCESS_COLOR, '"', sName, '"', messages.NONE_COLOR, '. Установил ', pActor:Name(), '.')

end)

hook.Add('Paws.'..MODULE.uID..'.Number.Change', 'Paws.'..MODULE.uID..'.Number.Change', function(pPlayer, pActor, sNumber, sOldNumber, nJob)
    
    lib:SendMessage(pActor, messages.MESSAGES_TYPE.SUCCESS, 'Вы установили новый номер для ', messages.SUCCESS_COLOR, api:GetName(pPlayer), messages.NONE_COLOR, '. Его новый номер: ', messages.SUCCESS_COLOR, '"', sNumber, '"', messages.NONE_COLOR, '.')
    lib:SendMessage(pPlayer, messages.MESSAGES_TYPE.SUCCESS, 'Вам установлен номер ', messages.SUCCESS_COLOR, '"', sNumber, '"', messages.NONE_COLOR, '. Установил ', pActor:Name(), '.')

end)

hook.Add('Paws.'..MODULE.uID..'.Rank.Change', 'Paws.'..MODULE.uID..'.Rank.Change', function(pPlayer, pActor, sRank, sOldRank, nJob)
    
    lib:SendMessage(pActor, messages.MESSAGES_TYPE.SUCCESS, 'Вы установили новое звание для ', messages.SUCCESS_COLOR, api:GetName(pPlayer), messages.NONE_COLOR, '. Его новое звание: ', messages.SUCCESS_COLOR, '"', api:FormatRank(pPlayer, sRank), '"', messages.NONE_COLOR, '.')
    lib:SendMessage(pPlayer, messages.MESSAGES_TYPE.SUCCESS, 'Вам установлено звание ', messages.SUCCESS_COLOR, '"', api:FormatRank(pPlayer, sRank), '"', messages.NONE_COLOR, '. Установил ', pActor:Name(), '.')
    
end)