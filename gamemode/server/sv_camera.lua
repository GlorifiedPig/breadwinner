function GM:SetupMove( ply, mv, cmd )
  local velocity = mv:GetVelocity()
  local p = 0
  local y = 0

	if mv:KeyDown( IN_JUMP ) then
		mv:SetButtons( bit.band(mv:GetButtons(), bit.bnot( IN_JUMP ) ) )
	end

	if mv:KeyDown( IN_FORWARD ) then
		p = 255
	end

  if mv:KeyDown( IN_BACK ) then
		p = -255
	end

  if mv:KeyDown( IN_MOVELEFT ) then
		y = 255
	end

	if mv:KeyDown( IN_MOVERIGHT ) then
		y = -255
	end

  velocity = Vector( p, y, 0 )
  mv:SetVelocity( velocity )
end