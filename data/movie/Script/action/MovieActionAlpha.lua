-- 角色半透明

local ParamTable = {}
ParamTable["fAlpha"] = 1
ParamTable["fAlphaEnd"] = 0
--ParamTable["nAlphaType"] = 1 -- 0：fAlpha固定不变， 1：fAlpha -> fAlphaEnd，2：从fAplha -> fAlphaEnd

MovieActionAlpha = {fAlpha =1,fAlphaEnd =0}

function GetParamTable()
	return ParamTable
end

function MovieActionAlpha:new (o)
	o = o or {}	-- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function MovieActionAlpha:PreRunAction(RunTime,fRatio) -- 开始 action

    local Action = RunTime:GetRunAction()
    local ActionScript = tolua.cast(Action,"KMovieActionScript")
    self.fAlpha = ActionScript:GetFloatParam("fAlpha")
    self.fAlphaEnd = ActionScript:GetFloatParam("fAlphaEnd")
    self.nAlphaType = ActionScript:GetFloatParam("nAlphaType")
    local Object = RunTime:GetRunObject()
	  Object:SetModelAlpha(self.fAlpha)
end

function MovieActionAlpha:PostRunAction(RunTime) -- 结束action
	--print("MovieActionFollow:PostRunAction")
	--if self.nAlphaType > 0 then
	--	local Object = RunTime:GetRunObject()
	--  Object:SetModelAlpha(1)
	--end
end

function MovieActionAlpha:UpdateAction(RunTime,fRatio)-- 更新 action

	--print("MovieActionFollow:UpdateAction")
	local Object = RunTime:GetRunObject()
	--print(Object)12:17 2014/7/4
	--if self.fAlphaEnd ~= self.fAlpha then
		 local curAlpha = self.fAlpha + (self.fAlphaEnd - self.fAlpha)* fRatio
		 Object:SetModelAlpha(curAlpha)
	--elseif self.nAlphaType == 2 then
	--	 local curAlpha =	self.fAlpha * (1 - fRatio) 
	--	 Object:SetModelAlpha(curAlpha)
	--end
	
end

function CreateMovieActionAlpha()
    return MovieActionAlpha:new()
end

