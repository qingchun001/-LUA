MovieActionAutoRotate = 
{
    nAxis = 1,   --x轴为0, y轴为1, z轴为2
    fSpeed = 5,  --角速度，正值为顺时针旋转，负值为逆时针旋转
    bLocalAxis = 1,    --是否本地坐标系下移动，0为世界坐标系
}

local ParamTable = {} 
ParamTable["nAxis"] = 1
ParamTable["fSpeed"] = 5
ParamTable["bLocalAxis"] = 1

local PI = 3.141592654

function GetParamTable()
    return ParamTable
end

function MovieActionAutoRotate:new (o)
	o = o or {}	-- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

function MovieActionAutoRotate:PreRunAction(RunTime,fRatio)  -- 开始 action
    local Object = RunTime:GetRunObject()
    local Action = RunTime:GetRunAction()
    local ActionScript = tolua.cast(Action,"KMovieActionScript")
    self.nAxis = ActionScript:GetFloatParam("nAxis")
    self.fSpeed = ActionScript:GetFloatParam("fSpeed")
    self.bLocalAxis = ActionScript:GetFloatParam("bLocalAxis")    
end

function MovieActionAutoRotate:UpdateAction(RunTime,fRatio)-- 更新 action
    local Object = RunTime:GetRunObject()
    local Action = RunTime:GetRunAction()
    local fActionLen = Action:GetActionLength()

    local fRotateAngle = fActionLen * self.fSpeed * fRatio
    local InitTrans = Object:GetInitTrans()

    
    local Angle = D3DXVECTOR3(0,0,0)
    if self.nAxis == 0 then --x
        Angle.x = fRotateAngle
    elseif self.nAxis == 1 then --y
        Angle.y = fRotateAngle
    else    --z
        Angle.z = fRotateAngle
    end
    
    Angle.x = Angle.x / 180 * PI
    Angle.y = Angle.y / 180 * PI
    Angle.z = Angle.z / 180 * PI

    local quat = D3DXQUATERNION(0, 0, 0, 0)
    EulerToQuaternion(quat, Angle.y, Angle.x, Angle.z)

    if self.bLocalAxis == 1 then            
        Object:SetRotationInLocalSpaceByInitTrans(quat)
    else
        Object:SetRotationInWorldSpaceByInitTrans(quat)
    end

end

function MovieActionAutoRotate:PostRunAction(RunTime) -- 结束action
    local Object = RunTime:GetRunObject()    
end

function CreateMovieActionAutoRotate()
    return MovieActionAutoRotate:new()
end