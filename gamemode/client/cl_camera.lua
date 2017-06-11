local inWorld = false
local worldHitPos = Vector()

gui.EnableScreenClicker( true )

function GM:CalcView( ply, pos, angles, fov, znear, zfar )
  local view = {}

  if ply:Alive() then
    if inWorld then
      view.origin = Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z + 400)
    else
      view.origin = Vector(ply:GetPos().x, ply:GetPos().y, worldHitPos.z - 38 )
      view.fov = 100
    end
  else
    if ply:GetRagdollEntity() != nil and !ply:Alive() then
      if inWorld then
        view.origin = Vector(ply:GetRagdollEntity():GetPos().x, ply:GetRagdollEntity():GetPos().y, ply:GetRagdollEntity():GetPos().z + 400)
      else
        view.origin = Vector(ply:GetRagdollEntity():GetPos().x, ply:GetRagdollEntity():GetPos().y, worldHitPos.z - 38 )
        view.fov = 100
      end
    end
  end
	view.angles = Angle(90, 0, 0)
	view.drawviewer = true

	return view
end

function GM:CreateMove( command )
  local mouseX, mouseY = gui.MousePos()
  local scrW, scrH = ScrW() / 2, ScrH() / 2
  local pos = LocalPlayer():GetShootPos():ToScreen()
  local ang = command:GetViewAngles()

  ang.y = math.deg( math.atan2( scrW - mouseX, scrH - mouseY ) )
  command:SetViewAngles(ang)
end

function GM:GUIMousePressed( MouseCode )
  if MouseCode == MOUSE_LEFT then
    RunConsoleCommand( "+attack" )
  end
end

function GM:GUIMouseReleased( MouseCode )
  if MouseCode == MOUSE_LEFT then
    RunConsoleCommand( "-attack" )
  end
end

function GM:Think()
  local tr = util.TraceLine( {
    start = EyePos() + Vector( 0, 0, 100 ),
    endpos = LocalPlayer():EyePos() + Vector( 0, 0, 100 )
  } )

  if tr.HitWorld then
    inWorld = false
    worldHitPos = tr.HitPos
  else
    inWorld = true
  end
end

function GM:Move( ply, mv )
  local velocity = mv:GetVelocity()
  local x = 0
  local y = 0
	local z = mv:GetVelocity().z

	if mv:KeyDown( IN_JUMP ) then
		mv:SetButtons( bit.band(mv:GetButtons(), bit.bnot( IN_JUMP ) ) )
	end

	if mv:KeyDown( IN_FORWARD ) then
		x = 255
	end

  if mv:KeyDown( IN_BACK ) then
		x = -255
	end

  if mv:KeyDown( IN_MOVELEFT ) then
		y = 255
	end

	if mv:KeyDown( IN_MOVERIGHT ) then
		y = -255
	end

  velocity = Vector( x, y, z )
  mv:SetVelocity( velocity )
end
