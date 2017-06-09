gui.EnableScreenClicker( true )

function GM:CalcView( ply, pos, angles )
  local view = {}

  view.origin = Vector(ply:GetPos().x, ply:GetPos().y, ply:GetPos().z + 400)
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


--[[To-do: Make it so that the world goes transparent when a player is under a roof

function GM:Think()
  local tr = util.TraceLine( {
    start = EyePos(),
    endpos = LocalPlayer():EyePos()
  } )

  if tr.HitWorld then

  end
end]]--
