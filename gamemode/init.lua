AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/cl_camera.lua")

function GM:PlayerSpawn(ply)
  ply:SetModel( "models/player/Group03/Male_0" .. math.random(1, 9) .. ".mdl" )
end

function GM:GetFallDamage( ply, speed )
  return speed / 8
end
