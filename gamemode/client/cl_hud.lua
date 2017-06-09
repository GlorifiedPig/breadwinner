local ShouldNotDraw = {
  CHudHealth = true,
  CHudBattery = true,
  CHudAmmo = true,
  CHudSecondaryAmmo = true,
  CHudCrosshair = true,
  CHudDamageIndicator = true,
  CHudDeathNotice = true
}

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end

local smoothHealth = 0
function GM:HUDPaint()
  local ply = LocalPlayer()

  local health = ply:Health()
  smoothHealth = Lerp( FrameTime() * 3, smoothHealth, health )

  draw.RoundedBox( 0, 15, ScrH() - 65, smoothHealth * 2.5, 50, Color( 255, 0, 0, 255 ) )
  draw.OutlinedBox( 15, ScrH() - 65, 250, 50, 3, Color( 0, 0, 0, 255 ) )

  draw.RoundedBox( 0, 40, ScrH() - 58, 10, 35, Color( 255, 255, 255, 255 ) )
  draw.RoundedBox( 0, 28, ScrH() - 45, 35, 10, Color( 255, 255, 255, 255 ) )

  draw.SimpleText( math.Round( smoothHealth, 0 ), "Trebuchet24", 73, ScrH() - 61, Color( 255, 255, 255, 255 ) )
end

function ShouldHUDDraw( name )
  if ShouldNotDraw[ name ] then return false end
end
hook.Add("HUDShouldDraw", "ShouldHUDDraw", ShouldHUDDraw)
