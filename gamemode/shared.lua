AddCSLuaFile("cl_init.lua")
AddCSLuaFile("camera/cl_camera.lua")
AddCSLuaFile("hud/cl_hud.lua")
AddCSLuaFile("waves/cl_waves.lua")

GM.Name = "Breadwinner"
GM.Author = "GlorifiedPig"
GM.Website  = "eaglegaming.xyz"

DeriveGamemode( "base" )

wave = 1

function GM:Initialize()
  self.BaseClass.Initialize( self )
end