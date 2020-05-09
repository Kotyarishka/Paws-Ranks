local MODULE = PAW_MODULE('ranks')
local LIB = PAW_MODULE('lib')
local Colors = LIB.Config.Colors
local cfg = MODULE.Config or {}

MODULE.GUI = {}

local W = ScrW
local H = ScrH

function MODULE.GUI:ChangeChar( target )

    local tAllRanks = table.GetKeys(target:getJobTable().ranks or {})

    table.RemoveByValue( tAllRanks, 'default' )

    local Frame = vgui.Create('DFrame')
    Frame:MakePopup()
    Frame:SetSize(300, 140)
    Frame:Center()
    Frame:SetTitle(target:Name())
    Frame:SetDraggable(false)
    Frame:ShowCloseButton(false)
    Frame:TDLib()
        :ClearPaint()
        :Background(Colors.Base, 5)
        :FadeIn()


    local RankButton = TDLib('DButton', Frame) 
        :Stick(TOP, 2) 
        :ClearPaint()
        :Text('Изменить звание', 'DermaDefault')
        :Background(Colors.Button)
        :FadeHover(Colors.ButtonHover)
        :CircleClick()
        :On('DoClick', function()
            local Menu = DermaMenu()
            Menu:TDLib()
                :ClearPaint()
                :Background(Color(40,40,40), 5)
                :FadeIn()
                :HideVBar()

            for k, v in ipairs(tAllRanks) do

                local Option = Menu:AddOption('', function()
                    net.Start('Paws.'..MODULE.uID..'.Request.Change.Rank')
                        net.WriteEntity(target)
                        net.WriteString(v)
                    net.SendToServer()

                    Frame:SetTitle(target:Name())
                end)
                Option:TDLib()
                    :ClearPaint()
                    :Background(Colors.BaseDarker)
                    :FadeHover(Colors.ButtonHover)
                    :Text(MODULE.API:FormatRank(target, v), 'DermaDefault')
            end

            if LocalPlayer():IsSuperAdmin() then
                local OtherOption = Menu:AddOption('', function()
                    LIB:DoStringRequest('Изменение звания', 
                        'Установить кастомное звание (Не из доступных на профессии).', 
                        MODULE.API:GetRank(target), 
                        function(sText)
                            net.Start('Paws.'..MODULE.uID..'.Request.Change.Rank')
                                net.WriteEntity(target)
                                net.WriteString(sText)
                            net.SendToServer()
                        end, 
                        nil,
                        'Изменить')
                end)
                    OtherOption:TDLib()
                        :ClearPaint()
                        :Background(Colors.BaseDarker)
                        :FadeHover(Colors.ButtonHover)
                        :Text('Другое', 'DermaDefault')
            end

            Menu:Open()
        end)

    local NumberButton = TDLib('DButton', Frame) 
        :Stick(TOP, 2) 
        :ClearPaint()
        :Text('Изменить номер', 'DermaDefault')
        :Background(Colors.Button)
        :FadeHover(Colors.ButtonHover)
        :CircleClick()
        :On('DoClick', function()
            LIB:DoStringRequest('Изменение номера', 
            'Введите номер', 
            MODULE.API:GetNumber(target), 
            function(sText)
                net.Start('Paws.'..MODULE.uID..'.Request.Change.Number')
                    net.WriteEntity(target)
                    net.WriteString(sText)
                net.SendToServer()
            end, 
            nil,
            'Изменить')
        end)

    local NameButton = TDLib('DButton', Frame) 
        :Stick(TOP, 2) 
        :ClearPaint()
        :Text('Изменить имя/позывной', 'DermaDefault')
        :Background(Colors.BaseDarker)
        :FadeHover(Colors.ButtonHover)
        :CircleClick()
        :On('DoClick', function()
            LIB:DoStringRequest('Изменение имени/позывного', 
            'Введите имя/позывной', 
            MODULE.API:GetName(target), 
            function(sText)
                net.Start('Paws.'..MODULE.uID..'.Request.Change.Name')
                    net.WriteEntity(target)
                    net.WriteString(sText)
                net.SendToServer()
            end, 
            nil,
            'Изменить')
        end)

    local CloseButton = TDLib('DButton', Frame) 
        :Stick(TOP, 2) 
        :ClearPaint()
        :Text('Закрыть', 'DermaDefault')
        :Background(Colors.BaseDarker)
        :FadeHover(Colors.CloseHover)
        :CircleClick()
        :SetRemove(Frame)

end

net.Receive('Paws.'..MODULE.uID..'.Open.Menu', function()
    local pTarget = net.ReadEntity()

    if pTarget:IsValid() then
        MODULE.GUI:ChangeChar( pTarget ) 
    end
end)
