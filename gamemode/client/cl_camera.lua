local drawHalos = false

gui.EnableScreenClicker( true )

function GM:CalcView( ply, pos, angles )
  local view = {}

  if ply:Alive() then
    view.origin = Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z + 400)
  else
    if ply:GetRagdollEntity() != nil and !ply:Alive() then
      view.origin = Vector(ply:GetRagdollEntity():GetPos().x, ply:GetRagdollEntity():GetPos().y, ply:GetRagdollEntity():GetPos().z + 400)
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
    start = EyePos(),
    endpos = LocalPlayer():EyePos()
  } )

  if tr.HitWorld then
    drawHalos = true
  else
    drawHalos = false
  end
end

function GM:PreDrawHalos()
  if drawHalos == true then
	  halo.Add( ents.FindByClass( "npc_*" ), Color( 225, 0, 0 ), 5, 5, 2, true, true )
    halo.Add( player.GetAll(), Color( 0, 225, 0 ), 5, 5, 2, true, true )
  end
end
