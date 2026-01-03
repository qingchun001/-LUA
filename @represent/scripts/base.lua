-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = string.rep
local r1_0 = table.concat
local r2_0 = table.insert
local r3_0 = table.remove
local r4_0 = string.byte
function LogAny(r0_1)
  -- line: [8, 51] id: 1
  local r4_1 = nil	-- notice: implicit variable refs by block#[0]
  local r1_1 = {}
  local r2_1 = {}
  local r3_1 = 1
  function r4_1(r0_2, r1_2)
    -- line: [12, 39] id: 2
    if r1_1[tostring(r0_2)] then
      r2_1[r3_1] = r1_2 .. "*" .. tostring(r0_2)
      r3_1 = r3_1 + 1
    else
      r1_1[tostring(r0_2)] = true
      if type(r0_2) == "table" then
        for r5_2, r6_2 in pairs(r0_2) do
          if type(r6_2) == "table" then
            r2_1[r3_1] = r1_2 .. "[" .. r5_2 .. "] => " .. tostring(r0_2) .. " {"
            r3_1 = r3_1 + 1
            r4_1(r6_2, r1_2 .. string.rep(" ", string.len(r5_2) + 8))
            r2_1[r3_1] = r1_2 .. string.rep(" ", string.len(r5_2) + 6) .. "}"
            r3_1 = r3_1 + 1
          elseif type(r6_2) == "string" then
            r2_1[r3_1] = r1_2 .. "[" .. r5_2 .. "] => \"" .. r6_2 .. "\""
            r3_1 = r3_1 + 1
          else
            r2_1[r3_1] = r1_2 .. "[" .. r5_2 .. "] => " .. tostring(r6_2)
            r3_1 = r3_1 + 1
          end
        end
      else
        r2_1[r3_1] = r1_2 .. tostring(r0_2)
        r3_1 = r3_1 + 1
      end
    end
  end
  if type(r0_1) == "table" then
    r2_1[r3_1] = "\n" .. tostring(r0_1) .. " {"
    r3_1 = r3_1 + 1
    r4_1(r0_1, "  ")
    r2_1[r3_1] = "}"
    r3_1 = r3_1 + 1
  else
    r4_1(r0_1, "  ")
  end
  Log(table.concat(r2_1, "\n"))
end
function Output(...)
  -- line: [54, 57] id: 3
  LogAny({
    ...
  })
end
function CreateObject(r0_4)
  -- line: [59, 64] id: 4
  local r1_4 = {}
  setmetatable(r1_4, r0_4)
  r0_4.__index = r0_4
  return r1_4
end
function CopyObject(r0_5)
  -- line: [66, 79] id: 5
  local r1_5 = {}
  for r5_5, r6_5 in pairs(r0_5) do
    if type(r6_5) == "table" then
      r1_5[r5_5] = CopyObject(r6_5)
    else
      r1_5[r5_5] = r6_5
    end
  end
  setmetatable(r1_5, getmetatable(r0_5))
  return r1_5
end
LoadScript("represent/scripts/mathex.lua")
