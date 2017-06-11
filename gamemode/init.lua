AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("camera/cl_camera.lua")
AddCSLuaFile("hud/cl_hud.lua")
AddCSLuaFile("waves/cl_waves.lua")
include("camera/sv_camera.lua")
include("waves/sv_waves.lua")

function GM:PlayerSpawn(ply)
  local Weapons = {"weapon_bw_colt1911", "weapon_bw_knife"}
  local Ammo = {"Pistol"}

  ply:SetModel( "models/player/Group03/Male_0" .. math.random(1, 9) .. ".mdl" )

  for k, v in pairs( Weapons ) do
    ply:Give(v)
  end

  for k, v in pairs( Ammo ) do
    ply:GiveAmmo( 49, v )
  end
end

function GM:GetFallDamage( ply, speed )
  return speed / 8
end
