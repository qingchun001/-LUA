-- 标记短时间长距离位移，关闭柔体的物理位移

MovieActionMarkTeleport = {}


local ParamTable = {}


function GetParamTable()
	return ParamTable
end

function MovieActionMarkTeleport:new (o)
	o = o or {}	-- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function MovieActionMarkTeleport:PreRunAction(RunTime, fRadio)
    local Object = RunTime:GetRunObject()
    Object:SetIsTeleport(1)
end

function MovieActionMarkTeleport:PostRunAction(RunTime)
    local Object = RunTime:GetRunObject()
    Object:SetIsTeleport(0)
end

function MovieActionMarkTeleport:UpdateAction(RunTime, fRadio)
end

function CreateMovieActionMarkTeleport()
    return MovieActionMarkTeleport:new()
end