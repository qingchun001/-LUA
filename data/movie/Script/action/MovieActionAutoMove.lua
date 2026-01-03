MovieActionAutoMove = 
{
    nAxis = 2,   --x轴为0, y轴为1, z轴为2
    fSpeed = -5,  --负速度为反向运动
    bAutoDropGround = 1,    --是否自动贴地
    bLocalAxis = 1,    --是否本地坐标系下移动，0为世界坐标系
}

local ParamTable = {} 
ParamTable["nAxis"] = 2
ParamTable["fSpeed"] = -5
ParamTable["bAutoDropGround"] = 1
ParamTable["bLocalAxis"] = 1

function GetParamTable()
    return ParamTable
end

function MovieActionAutoMove:new (o)
	o = o or {}	-- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function MovieActionAutoMove:PreRunAction(RunTime,fRatio)  -- 开始 action
    local Object = RunTime:GetRunObject()
    local Action = RunTime:GetRunAction()
    local ActionScript = tolua.cast(Action,"KMovieActionScript")
    self.nAxis = ActionScript:GetFloatParam("nAxis")
    self.fSpeed = ActionScript:GetFloatParam("fSpeed")
    self.bAutoDropGround = ActionScript:GetFloatParam("bAutoDropGround")
    self.bLocalAxis = ActionScript:GetFloatParam("bLocalAxis")
    local Object = RunTime:GetRunObject()
end

function MovieActionAutoMove:UpdateAction(RunTime,fRatio)-- 更新 action
    local Object = RunTime:GetRunObject()
    local Action = RunTime:GetRunAction()
    local fActionLen = Action:GetActionLength()
    local fMoveDis = fActionLen * self.fSpeed * fRatio
    local InitTrans = Object:GetInitTrans()
    if self.bLocalAxis == 1 then
        local trans = D3DXVECTOR3(0,0,0)
        if self.nAxis == 0 then --x
            trans.x = fMoveDis
        elseif self.nAxis == 1 then --y
            trans.y = fMoveDis
        else    --z
            trans.z = fMoveDis
        end
        Object:SetTranslationInLocalSpaceByInitTrans(trans)
        
    else
        local curTrans = KTrans()
        Object:GetTrans(curTrans)   
        if self.nAxis == 0 then --x
            curTrans.vTrans.x = InitTrans.vTrans.x + fMoveDis
        elseif self.nAxis == 1 then --y
            curTrans.vTrans.y = InitTrans.vTrans.y + fMoveDis
        else    --z
            curTrans.vTrans.z = InitTrans.vTrans.z + fMoveDis
        end
        Object:SetTranslation(curTrans.vTrans)
    end    
    if self.bAutoDropGround ~= 0 then
        Object:SetAutoDropGroundThisFrame(1);
    else
        Object:SetAutoDropGroundThisFrame(0);
    end
end

function MovieActionAutoMove:PostRunAction(RunTime) -- 结束action
end

function CreateMovieActionAutoMove()
    return MovieActionAutoMove:new()
end