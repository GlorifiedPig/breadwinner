AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("client/cl_camera.lua")
AddCSLuaFile("client/cl_hud.lua")

function GM:PlayerSpawn(ply)
  local Weapons = {"weapon_pistol", "weapon_crowbar"}
  local Ammo = {"Pistol"}

  ply:SetModel( "models/player/Group03/Male_0" .. math.random(1, 9) .. ".mdl" )

  for k, v in pairs( Weapons ) do
    ply:Give(v)
  end

  for k, v in pairs( Ammo ) do
    ply:GiveAmmo( 64, v )
  end
end

function GM:GetFallDamage( ply, speed )
  return speed / 8
end
