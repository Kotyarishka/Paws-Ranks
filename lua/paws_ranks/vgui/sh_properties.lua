local MODULE = PAW_MODULE('ranks')
local cfg = MODULE.Config or {}

properties.Add( "openrank", {
	MenuLabel = "Управление персонажем", -- Name to display on the context menu
	Order = 1, -- The order to display this property relative to other properties
	MenuIcon = "icon16/group_edit.png", -- The icon to display next to the property

	Filter = function( self, ent ) -- A function that determines whether an entity is valid for this property
		if ( !ent:IsPlayer() ) then return false end
		
        local tPermissions = cfg.Permissions[LocalPlayer():GetUserGroup()] or cfg.Permissions[MODULE.API:GetRank(LocalPlayer())] or {}

        if table.HasValue(tPermissions, MODULE.API:GetRank(ent)) or table.HasValue(tPermissions, '*') then
            return true
        end

		return false 
	end,
	Action = function( self, ent ) -- The action to perform upon using the property ( Clientside )
		MODULE.GUI:ChangeChar( ent )
	end,
	Receive = function( self, length, player ) -- The action to perform upon using the property ( Serverside )

	end
} )