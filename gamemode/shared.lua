AddCSLuaFile("cl_init.lua")
AddCSLuaFile("client/cl_camera.lua")
AddCSLuaFile("client/cl_hud.lua")

GM.Name = "Breadwinner"
GM.Author = "GlorifiedPig"
GM.Website  = "eaglegaming.xyz"

DeriveGamemode( "base" )

function GM:Initialize()
  self.BaseClass.Initialize( self )
end