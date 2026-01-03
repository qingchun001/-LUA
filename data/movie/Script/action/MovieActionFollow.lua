-- 跟随实现
-- "nFollowObj" 跟随对象
-- "nKeepDis"   保持距离

local followObjGroup = {}
local ParamTable = {} --{"nFollowObj","nKeepDis"}
ParamTable["nFollowObj"] = 0
ParamTable["nKeepDis"] = 100

MovieActionFollow = {nKeepDis =100}


function GetParamTable()
	return ParamTable
end

function MovieActionFollow:new (o)
	o = o or {}	-- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function MovieActionFollow:PreRunAction(RunTime,fRatio) -- 开始 action

    local Action = RunTime:GetRunAction()
    local ActionScript = tolua.cast(Action,"KMovieActionScript")
    local elementId = ActionScript:GetFloatParam("nFollowObj")
    self.nKeepDis = ActionScript:GetFloatParam("nKeepDis")

	local SceneID = RunTime:GetMovieSceneID()
    local MovieScene = GetMovieScene(SceneID)
	self.FollowObj = MovieScene:GetMovieObjectByElementID(elementId)
end

function MovieActionFollow:PostRunAction(RunTime) -- 结束action
	--print("MovieActionFollow:PostRunAction")
end

function MovieActionFollow:UpdateAction(RunTime,fRatio)-- 更新 action

	--print("MovieActionFollow:UpdateAction")
	local Object = RunTime:GetRunObject()
	--print(Object)
	Object:FollowSb(self.FollowObj,self.nKeepDis)
end

function CreateMovieActionFollow()
    return MovieActionFollow:new()
end

