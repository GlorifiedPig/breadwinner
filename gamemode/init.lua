AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function GM:PlayerSpawn(ply)
  print(ply .. " has spawned.")
end
