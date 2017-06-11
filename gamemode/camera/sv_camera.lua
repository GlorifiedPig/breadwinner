function GM:Move( ply, mv )
  local velocity = mv:GetVelocity()
	local x = 0
	local y = 0
	local z = mv:GetVelocity().z

	if mv:KeyDown( IN_JUMP ) then
		mv:SetButtons( bit.band(mv:GetButtons(), bit.bnot( IN_JUMP ) ) )
	end

	if mv:KeyDown( IN_FORWARD ) then
		x = 200
	elseif mv:KeyDown( IN_BACK ) then
		x = -200
	end

	if mv:KeyDown( IN_MOVELEFT ) then
		y = 200
	elseif mv:KeyDown( IN_MOVERIGHT ) then
		y = -200
	end

	velocity = Vector( x, y, z )
	mv:SetVelocity( velocity )
end