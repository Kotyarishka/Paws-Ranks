local MODULE = PAW_MODULE('ranks')
local cfg = MODULE.Config or {}

/*

*/ 

net.Receive('Paws.'..MODULE.uID..'.Request.Change.Rank', function(_, pSender)
    local pTarget = net.ReadEntity()
    local sRank = net.ReadString()
    local sCurRank = MODULE.API:GetRank(pTarget)

    if !pSender:IsValid() || !pTarget:IsValid() then
        return 
    end

    if MODULE.Perms:HasPermission(pSender, sRank) && MODULE.Perms:HasPermission(pSender, sCurRank) then
        MODULE.Ply:SetRank(pTarget, sRank, pSender)
    end
end)

net.Receive('Paws.'..MODULE.uID..'.Request.Change.Number', function(_, pSender)
    local pTarget = net.ReadEntity()
    local sNumber = net.ReadString()
    local sRank = MODULE.API:GetRank(pTarget)

    if !pSender:IsValid() || !pTarget:IsValid() then
        return 
    end

    if MODULE.Perms:HasPermission(pSender, sRank) then
        MODULE.Ply:SetNumber(pTarget, sNumber, pSender)
    end
end)

net.Receive('Paws.'..MODULE.uID..'.Request.Change.Name', function(_, pSender)
    local pTarget = net.ReadEntity()
    local sName = net.ReadString()
    local sRank = MODULE.API:GetRank(pTarget)

    if !pSender:IsValid() || !pTarget:IsValid() then
        return 
    end

    if MODULE.Perms:HasPermission(pSender, sRank) then
        MODULE.Ply:SetName(pTarget, sName, pSender)
    end
end)
