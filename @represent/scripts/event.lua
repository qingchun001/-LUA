-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = string.rep
local r1_0 = table.concat
local r2_0 = table.insert
local r3_0 = table.remove
local r4_0 = string.byte
local r5_0 = {}
local r6_0 = 0
local function r7_0()
  -- line: [10, 13] id: 1
  r6_0 = r6_0 + 1
  return r6_0
end
function DelayCall(r0_2, r1_2, r2_2)
  -- line: [15, 22] id: 2
  if type(r0_2) == "number" then
    r2_2 = r1_2
    r1_2 = r0_2
    r0_2 = string.format("Delay_%d", r7_0())
  end
  RegisterDelayEvent(r0_2, r1_2, r2_2)
  return r0_2
end
