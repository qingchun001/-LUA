-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
PB = {
  pb = nil,
  handlers = {},
}
SendType = {
  BroadCast = 1,
  BroadCastNotSelf = 2,
  UI2RL = 3,
  RL2UI = 4,
  ToServer = 5,
}
function PB.init()
  -- line: [16, 24] id: 1
  Log("PB init")
  PB.pb = OpenPB()
  if PB.pb ~= nil then
    local r0_1 = {}
    PB.pb.loadfile("scripts/Chat/custom.pb", r0_1)
    LogAny(r0_1)
  end
end
function PB.Register(r0_2, r1_2, r2_2)
  -- line: [26, 36] id: 2
  local r4_2 = getfenv(r1_2).ScriptID or 0
  if r4_2 ~= 0 then
    PB.handlers[r0_2] = {
      handler = r1_2,
      script = r4_2,
      args = r2_2,
    }
  else
    Log("PB.Register Error! proto: " .. tostring(r0_2))
  end
end
function PB.Unregister(r0_3, r1_3)
  -- line: [38, 43] id: 3
  local r2_3 = PB.handlers[r0_3]
  if r2_3 ~= nil and r2_3.handler == r1_3 then
    PB.handlers[r0_3] = nil
  end
end
function PB.Recv(r0_4, r1_4, r2_4, r3_4)
  -- line: [44, 62] id: 4
  if PB.pb == nil then
    return 
  end
  local r4_4 = PB.pb.decode(r2_4, r3_4)
  if r4_4 ~= nil then
    local r5_4 = PB.handlers[r2_4]
    if r5_4 ~= nil then
      local r6_4 = MakeEnv(r5_4.script)
      r5_4.handler(r5_4.args, r0_4, r1_4, r2_4, r4_4)
      MakeEnv(r6_4)
    end
  end
end
function PB.Send(r0_5, r1_5, r2_5, r3_5)
  -- line: [64, 71] id: 5
  if PB.pb ~= nil then
    local r4_5 = PB.pb.encode(r0_5, r1_5)
    if r4_5 ~= nil then
      PB.pb.send(r0_5, r4_5, r2_5, r3_5)
    end
  end
end
function PB.Decode(r0_6, r1_6)
  -- line: [73, 80] id: 6
  if PB.pb == nil then
    return 
  end
  return PB.pb.decode(r0_6, r1_6)
end
PB.init()
