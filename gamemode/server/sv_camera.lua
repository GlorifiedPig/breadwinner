function GM:Move( ply, mv )
  local velocity = mv:GetVelocity()
  local p = 0
  local y = 0

	if( mv:KeyDown( IN_FORWARD ) ) then
		p = 200
	end

  if( mv:KeyDown( IN_BACK ) ) then
		p = -200
	end

  if( mv:KeyDown( IN_MOVELEFT ) ) then
		y = 200
	end

	if( mv:KeyDown( IN_MOVERIGHT ) ) then
		y = -200
	end

  if( mv:KeyDown( IN_SPEED ) ) then
    ply:SprintEnable()
  else
    ply:SprintDisable()
  end

  velocity = Vector( p, y, 0 )
  mv:SetVelocity( velocity )
end
