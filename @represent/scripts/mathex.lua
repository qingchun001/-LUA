-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
function Clamp(r0_1, r1_1, r2_1)
  -- line: [2, 6] id: 1
  if r0_1 < r1_1 then
    r0_1 = r1_1 or r0_1
  end
  if r2_1 < r0_1 then
    r0_1 = r2_1 or r0_1
  end
  return r0_1
end
local r0_0 = {
  ISVECTOR3 = true,
}
r0_0.__index = r0_0
function Vector3(r0_2, r1_2, r2_2)
  -- line: [11, 19] id: 2
  if not r0_2 then
    r0_2 = 0
  end
  if not r1_2 then
    r1_2 = 0
  end
  if not r2_2 then
    r2_2 = 0
  end
  local r3_2 = {
    x = r0_2,
    y = r1_2,
    z = r2_2,
    ToArgs = function(r0_3)
      -- line: [16, 16] id: 3
      return r0_3.x, r0_3.y, r0_3.z
    end,
  }
  setmetatable(r3_2, r0_0)
  return r3_2
end
function Vector3Copy(r0_4)
  -- line: [21, 24] id: 4
  return Vector3(r0_4.x, r0_4.y, r0_4.z)
end
function r0_0.__add(r0_5, r1_5)
  -- line: [26, 28] id: 5
  return Vector3(r0_5.x + r1_5.x, r0_5.y + r1_5.y, r0_5.z + r1_5.z)
end
function r0_0.__sub(r0_6, r1_6)
  -- line: [30, 32] id: 6
  return Vector3(r0_6.x - r1_6.x, r0_6.y - r1_6.y, r0_6.z - r1_6.z)
end
function r0_0.__mul(r0_7, r1_7)
  -- line: [34, 36] id: 7
  return Vector3(r0_7.x * r1_7, r0_7.y * r1_7, r0_7.z * r1_7)
end
function r0_0.offsetAngle(r0_8, r1_8)
  -- line: [39, 51] id: 8
  if r1_8:length() == 0 then
    return 0
  end
  local r2_8 = math.deg(r0_8:angle(r1_8))
  if r0_8:cross(r1_8).y > 0 then
    return r2_8
  else
    return -r2_8
  end
end
function r0_0.cross(r0_9, r1_9)
  -- line: [53, 55] id: 9
  return Vector3(r0_9.y * r1_9.z - r0_9.z * r1_9.y, r0_9.z * r1_9.x - r0_9.x * r1_9.z, r0_9.x * r1_9.y - r0_9.y * r1_9.x)
end
function r0_0.lensqr(r0_10)
  -- line: [57, 59] id: 10
  return r0_10.x * r0_10.x + r0_10.y * r0_10.y + r0_10.z * r0_10.z
end
function r0_0.length(r0_11)
  -- line: [61, 63] id: 11
  return math.sqrt(r0_11.x * r0_11.x + r0_11.y * r0_11.y + r0_11.z * r0_11.z)
end
function r0_0.length_horizon(r0_12)
  -- line: [65, 67] id: 12
  return math.sqrt(r0_12.x * r0_12.x + r0_12.z * r0_12.z)
end
function r0_0.length_vertical(r0_13)
  -- line: [69, 71] id: 13
  return math.abs(r0_13.y)
end
function r0_0.distance(r0_14, r1_14)
  -- line: [73, 75] id: 14
  return math.sqrt((r0_14.x - r1_14.x) ^ 2 + (r0_14.y - r1_14.y) ^ 2 + (r0_14.z - r1_14.z) ^ 2)
end
function r0_0.normalize(r0_15)
  -- line: [77, 91] id: 15
  local r2_15 = r0_15:lensqr()
  if r2_15 < 0.00001 then
    r0_15.x = 0
    r0_15.y = 0
    r0_15.z = 1
  else
    local r3_15 = 1 / math.sqrt(r2_15)
    r0_15.x = r0_15.x * r3_15
    r0_15.y = r0_15.y * r3_15
    r0_15.z = r0_15.z * r3_15
  end
  return r0_15
end
function r0_0.dot(r0_16, r1_16)
  -- line: [93, 95] id: 16
  return r0_16.x * r1_16.x + r0_16.y * r1_16.y + r0_16.z * r1_16.z
end
function r0_0.angle(r0_17, r1_17)
  -- line: [97, 101] id: 17
  return math.acos(Clamp(r0_17:dot(r1_17) / r0_17:length() * r1_17:length(), -1, 1))
end
local r1_0 = {
  ISQUAT = true,
}
r1_0.__index = r1_0
function Quaternion(r0_18, r1_18, r2_18, r3_18)
  -- line: [106, 115] id: 18
  if not r0_18 then
    r0_18 = 0
  end
  if not r1_18 then
    r1_18 = 0
  end
  if not r2_18 then
    r2_18 = 0
  end
  if not r3_18 then
    r3_18 = 1
  end
  local r4_18 = {
    x = r0_18,
    y = r1_18,
    z = r2_18,
    w = r3_18,
    ToArgs = function(r0_19)
      -- line: [112, 112] id: 19
      return r0_19.x, r0_19.y, r0_19.z, r0_19.w
    end,
  }
  setmetatable(r4_18, r1_0)
  return r4_18
end
function QuaternionByDir(r0_20)
  -- line: [117, 143] id: 20
  local r1_20 = Vector3Copy(r0_20)
  r1_20:normalize()
  local r2_20 = r1_20:dot(Vector3(0, 1, 0))
  if math.abs(r2_20 - 1) < 0.01 then
    return Quaternion(0, 0, 0, 1)
  elseif math.abs(r2_20 + 1) < 0.01 then
    return Quaternion(-0.7071, 0, 0, 0.7071)
  else
    local r3_20 = Vector3(r1_20.x, 0, r1_20.z)
    r3_20:normalize()
    local r4_20 = Vector3(0, 0, 1):angle(r3_20)
    local r5_20 = math.sin(r4_20 * 0.5)
    local r6_20 = math.cos(r4_20 * 0.5)
    local r7_20 = Vector3(0, 0, 1):cross(r3_20):normalize() * r5_20
    local r8_20 = Quaternion(r7_20.x, r7_20.y, r7_20.z, r6_20)
    local r9_20 = r3_20:angle(r1_20)
    local r10_20 = math.sin(r9_20 * 0.5)
    local r11_20 = math.cos(r9_20 * 0.5)
    local r12_20 = r3_20:cross(r1_20):normalize() * r10_20
    return Quaternion(r12_20.x, r12_20.y, r12_20.z, r11_20) * r8_20
  end
end
function QuaternionConjugate(r0_21)
  -- line: [145, 147] id: 21
  return Quaternion(-r0_21.x, -r0_21.y, -r0_21.z, r0_21.w)
end
function QuaternionByAngle(r0_22, r1_22)
  -- line: [149, 155] id: 22
  local r2_22 = Vector3(0, 1, 0) * math.sin(r0_22 * 0.5)
  local r3_22 = Quaternion(r2_22.x, r2_22.y, r2_22.z, math.cos(r0_22 * 0.5))
  local r4_22 = r3_22:Rotate(Vector3(1, 0, 0)) * math.sin(r1_22 * 0.5)
  return Quaternion(r4_22.x, r4_22.y, r4_22.z, math.cos(r1_22 * 0.5)) * r3_22
end
function QuaternionByAxisAngle(r0_23, r1_23)
  -- line: [157, 161] id: 23
  local r2_23 = math.sin(r1_23 * 0.5)
  return Quaternion(r2_23 * r0_23.x, r2_23 * r0_23.y, r2_23 * r0_23.z, math.cos(r1_23 * 0.5))
end
function r1_0.__mul(r0_24, r1_24)
  -- line: [163, 169] id: 24
  return Quaternion(r0_24.w * r1_24.x + r0_24.x * r1_24.w + r0_24.y * r1_24.z - r0_24.z * r1_24.y, r0_24.w * r1_24.y + r0_24.y * r1_24.w + r0_24.z * r1_24.x - r0_24.x * r1_24.z, r0_24.w * r1_24.z + r0_24.z * r1_24.w + r0_24.x * r1_24.y - r0_24.y * r1_24.x, r0_24.w * r1_24.w - r0_24.x * r1_24.x - r0_24.y * r1_24.y - r0_24.z * r1_24.z)
end
function r1_0.Rotate(r0_25, r1_25)
  -- line: [171, 178] id: 25
  local r2_25 = Vector3(r0_25.x, r0_25.y, r0_25.z)
  local r3_25 = r2_25:cross(r1_25)
  return r1_25 + r3_25 * 2 * r0_25.w + r2_25:cross(r3_25) * 2
end
local r2_0 = false
function Random(r0_26, r1_26)
  -- line: [181, 189] id: 26
  if not r2_0 then
    math.randomseed(os.time())
    r2_0 = true
  end
  local r3_26 = (math.random(1, 10000) - 1) / 10000
  return r0_26 * (1 - r3_26) + r3_26 * r1_26
end
function GetRotateVectorAroundAxisWithOffset(r0_27, r1_27, r2_27, r3_27)
  -- line: [191, 205] id: 27
  local r5_27, r6_27, r7_27 = GetRotateVectorAroundAxis({
    x = r1_27.x - r0_27.x,
    y = r1_27.y - r0_27.y,
    z = r1_27.z - r0_27.z,
  }, r2_27, r3_27)
  local r8_27 = {
    x = r5_27 + r0_27.x,
    y = r6_27 + r0_27.y,
    z = r7_27 + r0_27.z,
  }
  return r8_27.x, r8_27.y, r8_27.z
end
function GetLineByTwoPoints(r0_28, r1_28, r2_28, r3_28)
  -- line: [207, 212] id: 28
  return r3_28 - r1_28, r0_28 - r2_28, r2_28 * r1_28 - r0_28 * r3_28
end
function GetPoint2LineDistance(r0_29, r1_29, r2_29, r3_29, r4_29)
  -- line: [214, 216] id: 29
  return math.abs((r2_29 * r0_29 + r3_29 * r1_29 + r4_29)) / math.sqrt((r2_29 ^ 2 + r3_29 ^ 2))
end
function Change(r0_30, r1_30)
  -- line: [218, 220] id: 30
  return r1_30, r0_30
end
function CheckPointBetweenTwoPoints(r0_31, r1_31, r2_31, r3_31, r4_31, r5_31, r6_31)
  -- line: [222, 247] id: 31
  if not r6_31 then
    r6_31 = 0
  end
  if r4_31 <= r2_31 then
    r2_31, r4_31 = Change(r2_31, r4_31)
  end
  if r4_31 - r2_31 < r6_31 then
    r4_31 = r4_31 + r6_31 / 2
    r2_31 = r2_31 - r6_31 / 2
  end
  if r5_31 <= r3_31 then
    r3_31, r5_31 = Change(r3_31, r5_31)
  end
  if r5_31 - r3_31 < r6_31 then
    r5_31 = r5_31 + r6_31 / 2
    r3_31 = r3_31 - r6_31 / 2
  end
  if r2_31 <= r0_31 and r0_31 <= r4_31 and r3_31 <= r1_31 then
    local r7_31 = r1_31 <= r5_31
  else
    goto label_44	-- block#15 is visited secondly
  end
end
function EasyEncrypt(r0_32)
  -- line: [249, 259] id: 32
  local r1_32 = 0
  for r5_32 = 1, #r0_32, 1 do
    if type(r0_32[r5_32]) == "number" or type(r0_32[r5_32]) == "string" then
      r1_32 = r1_32 + tonumber(string.byte(r0_32[r5_32]))
    end
  end
  return math.floor(math.sqrt(math.abs(r1_32 - 2006))) + 516
end
function QuaternionToEuler(r0_33)
  -- line: [260, 266] id: 33
  return math.asin(2 * (r0_33.w * r0_33.x - r0_33.z * r0_33.y)), math.atan(2 * (r0_33.w * r0_33.y + r0_33.x * r0_33.z), 1 - 2 * (r0_33.y * r0_33.y + r0_33.x * r0_33.x)), math.atan(2 * (r0_33.w * r0_33.z + r0_33.x * r0_33.y), 1 - 2 * (r0_33.x * r0_33.x + r0_33.z * r0_33.z))
end
