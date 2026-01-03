
local MovieActionGroup = {
	-- 群组排列方式
    Type1Dir = { -- 横线
	{x = -1,z = 0},
	{x = 1 , z = 0}},
    Type2Dir = {-- 竖线 只站一边
	{z = 1 , x = 0}},	
}

--
local ParamTable = {} 
ParamTable["GroupType"] = 2
ParamTable["GroupNum"] = 5
ParamTable["GroupSpace"] = 300

function GetParamTable()
    return ParamTable
end
--
function MovieActionGroup:new (o)
	o = o or {}	-- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end


function MovieActionGroup:PreRunAction(RunTime)

    local Action = RunTime:GetRunAction()
    local ActionScript = tolua.cast(Action,"KMovieActionScript")
    local Type = ActionScript:GetFloatParam("GroupType")
    local Num = ActionScript:GetFloatParam("GroupNum")
    local Space = ActionScript:GetFloatParam("GroupSpace")

    self:CreateGroup(RunTime,Type,Num,Space)
end
function MovieActionGroup:CreateGroup(RunTime,Type,Num,Space)
   
    local Action = RunTime:GetRunAction()

    local Object = RunTime:GetRunObject()
	
    local ObjectName = Object:GetName()

    local MovieSceneID = RunTime:GetMovieSceneID()
    local MovieScene = GetMovieScene(MovieSceneID)
	
    self.Obj = {}
    self.ObjectNum = Num
    self.ObjectSpace = Space
    
    local ObjTrans = KTrans()
    Object:GetTrans(ObjTrans)
	for i = 1 , Num  do
		self.Obj[i] = {}
        local Trans = KTrans()
		if(Type == 1) then -- 第一种类型 横线型
			Trans.vTrans = D3DXVECTOR3(Space,0,0)
            Trans.vScaling = D3DXVECTOR3(1,1,1)
            Trans.vRotation = D3DXQUATERNION(0,0,0,1)
			
			Trans.vTrans.x = ( Trans.vTrans.x * math.ceil(i / 2)) * self.Type1Dir[i % 2 + 1].x 
            Trans.vTrans.z = ( Trans.vTrans.z * math.ceil(i / 2)) * self.Type1Dir[i % 2 + 1].z
		elseif (Type == 2) then -- 竖线 只站一边
			Trans.vTrans = D3DXVECTOR3(0,0,Space)
            Trans.vScaling = D3DXVECTOR3(1,1,1)
            Trans.vRotation = D3DXQUATERNION(0,0,0,1)
           
            Trans.vTrans.z = ( Trans.vTrans.z * i) * self.Type2Dir[1].z 
            Trans.vTrans.x = ( Trans.vTrans.x * i) * self.Type2Dir[1].x
		end
		self.Obj[i].Trans = Trans;
		local NewObj = MovieScene:NewMovieObj(MOT_ACTOR)
		
		local NewTrans = KTrans()
		TransMulTrans(self.Obj[i].Trans,ObjTrans,NewTrans)
		
		--NewObj:LoadFromFile(ObjectName)
		NewObj:CloneObject(Object)
		
		NewObj:SetTranslation(NewTrans.vTrans)
		NewObj:SetRotation(NewTrans.vRotation)
		NewObj:SetScaling(NewTrans.vScaling)
		
		KMovieScene:AddModelTo3DScene(NewObj,0)
		
		self.Obj[i].Obj = NewObj
	end
end
function MovieActionGroup:PostRunAction(RunTime)
	local MovieSceneID = RunTime:GetMovieSceneID()
	local MovieScene = GetMovieScene(MovieSceneID)
	local ObjectNum = self.ObjectNum
	for i = 1,ObjectNum do
		MovieScene:RemoveObj(self.Obj[i].Obj,1)
	end
end

function MovieActionGroup:UpdateAction(RunTime,fRatio)
	local Object = RunTime:GetRunObject()
	
	local Trans = KTrans()
	Object:GetTrans(Trans)
    
	local ObjectNum = self.ObjectNum
	
    local AniName = Object:GetAniName()
    local fAniPos = Object:GetCurAniPos()
	
	if(AniName == nil)then  return end
	for i = 1, ObjectNum do
		local SubObject = self.Obj[i].Obj
		local NewTrans = KTrans()
		TransMulTrans(self.Obj[i].Trans,Trans,NewTrans)
		SubObject:SetTrans(NewTrans)

		if (self.Obj[i].Ani == nil or self.Obj[i].Ani ~= AniName )  then

			local PlayAniParam = Object:GetAniParam()
			PlayAniParam.nOffsetTime = fAniPos
			PlayAniParam.nAnimationControllerPriority = 0
			SubObject:PlayAnimation(AniName,PlayAniParam)
			
			self.Obj[i].Ani = AniName

		end
	end
	
end

function CreateMovieActionGroup()
    return MovieActionGroup:new()
end