local MODULE = PAW_MODULE('ranks')
local cfg = MODULE.Config or {}

MODULE.GUI = {}

local W = ScrW
local H = ScrH

local function DoStringRequest(sTitle, sText, sDefaultText, fEnter, fCancel, sEnterButtonText, sCancelButtonText)

    local Blur = TDLib( 'DPanel' )
        :ClearPaint()
        :Stick(FILL)
        :Blur()
        :FadeIn(2)

    Blur:SetDrawOnTop( true )

    local Window = vgui.Create( 'DFrame' )
	
    Window:TDLib()
        :ClearPaint()
        :Background(Color(40,40,40), 5)
        :FadeIn()
    
    Window:SetTitle( sTitle or 'Ввод данных' )
	Window:SetDraggable( false )
	Window:ShowCloseButton( false )
	Window:SetDrawOnTop( true )
    
	local InnerPanel = vgui.Create( 'DPanel', Window )
	InnerPanel:SetPaintBackground( false )

	local Text = vgui.Create( 'DLabel', InnerPanel )
	Text:SetText( sText or 'Введите данные в поле ниже' )
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )

	local TextEntry = vgui.Create( 'DTextEntry', InnerPanel )
	TextEntry:SetText( sDefaultText or '' )
	TextEntry.OnEnter = function() Window:Close() Blur:Remove() fEnter( TextEntry:GetValue() ) end

	local ButtonPanel = vgui.Create( 'DPanel', Window )
	ButtonPanel:SetTall( 30 )
	ButtonPanel:SetPaintBackground( false )

	local Button = vgui.Create( 'DButton', ButtonPanel )
	Button:SetPos( 5, 5 )
	Button.DoClick = function() Window:Close() Blur:Remove() fEnter( TextEntry:GetValue() ) end

    Button:TDLib()
        :ClearPaint()
        :Background(Color(51,51,51))
        :FadeHover(Color(59, 137, 255))
        :CircleClick()
        :Text(sEnterButtonText or 'OK', 'DermaDefault')

    Button:SizeToContents()
	Button:SetTall( 20 )
	Button:SetWide( Button:GetWide() + 20 )

	local ButtonCancel = vgui.Create( 'DButton', ButtonPanel )
	ButtonCancel:SetPos( 5, 5 )
	ButtonCancel.DoClick = function() Window:Close() Blur:Remove() if ( fCancel ) then fCancel( TextEntry:GetValue() ) end end
	ButtonCancel:MoveRightOf( Button, 5 )

    ButtonCancel:TDLib()
        :ClearPaint()
        :Background(Color(51,51,51))
        :FadeHover(Color(255, 89, 89))
        :CircleClick()
        :Text(sCancelButtonText or 'Отмена', 'DermaDefault')

    ButtonCancel:SizeToContents()
	ButtonCancel:SetTall( 20 )
	ButtonCancel:SetWide( Button:GetWide() )

	ButtonPanel:SetWide( Button:GetWide() + 5 + ButtonCancel:GetWide() + 10 )

	local w, h = Text:GetSize()
	w = math.max( w, 400 )

	Window:SetSize( w + 50, h + 25 + 75 + 10 )
	Window:Center()

	InnerPanel:StretchToParent( 5, 25, 5, 45 )

	Text:StretchToParent( 5, 5, 5, 35 )

	TextEntry:StretchToParent( 5, nil, 5, nil )
	TextEntry:AlignBottom( 5 )

	TextEntry:RequestFocus()
	TextEntry:SelectAllText( true )

	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )

	Window:MakePopup()
	Window:DoModal()

end

function MODULE.GUI:ChangeChar( target )

    local tAllRanks = table.GetKeys(target:getJobTable().ranks or {})

    table.RemoveByValue( tAllRanks, 'default' )

    local Frame = vgui.Create('DFrame')
    Frame:MakePopup()
    Frame:SetSize(300, 140)
    Frame:Center()
    Frame:SetTitle(target:Name())
    Frame:ShowCloseButton(false)
    Frame:TDLib()
        :ClearPaint()
        :Background(Color(40,40,40, 245), 5)
        :FadeIn()


    local RankButton = TDLib('DButton', Frame) 
        :Stick(TOP, 2) 
        :ClearPaint()
        :Text('Изменить звание', 'DermaDefault')
        :Background(Color(51,51,51))
        :FadeHover(Color(59, 137, 255))
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
                    :Background(Color(40,40,40))
                    :FadeHover(Color(59, 137, 255))
                    :Text(MODULE.API:FormatRank(target, v), 'DermaDefault')
            end

            if LocalPlayer():IsSuperAdmin() then
                local OtherOption = Menu:AddOption('', function()
                    DoStringRequest('Изменение звания', 
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
                        :Background(Color(40,40,40))
                        :FadeHover(Color(59, 137, 255))
                        :Text('Другое', 'DermaDefault')
            end

            Menu:Open()
        end)

    local NumberButton = TDLib('DButton', Frame) 
        :Stick(TOP, 2) 
        :ClearPaint()
        :Text('Изменить номер', 'DermaDefault')
        :Background(Color(51,51,51))
        :FadeHover(Color(59, 137, 255))
        :CircleClick()
        :On('DoClick', function()
            DoStringRequest('Изменение номера', 
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
        :Background(Color(51,51,51))
        :FadeHover(Color(59, 137, 255))
        :CircleClick()
        :On('DoClick', function()
            DoStringRequest('Изменение имени/позывного', 
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
        :Background(Color(51,51,51))
        :FadeHover(Color(255, 89, 89))
        :CircleClick()
        :SetRemove(Frame)

end

net.Receive('Paws.'..MODULE.uID..'.Open.Menu', function()
    local pTarget = net.ReadEntity()

    if pTarget:IsValid() then
        MODULE.GUI:ChangeChar( pTarget ) 
    end
end)
