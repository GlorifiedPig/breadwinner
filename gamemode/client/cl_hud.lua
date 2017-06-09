local ShouldNotDraw = {
  CHudHealth = true,
  CHudBattery = true,
  CHudAmmo = true,
  CHudSecondaryAmmo = true,
  CHudCrosshair = true,
  CHudDamageIndicator = true,
  CHudDeathNotice = true
}

surface.CreateFont("DeathFont", {
  font = "a dripping marker",
  size = 108,
  weight = 100,
  antialias = false,
  outline = true
})

surface.CreateFont("HUDText", {
  font = "Futura (Light)",
  size = 40,
  weight = 500,
  antialias = true
})

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end

local smoothHealth = 0
local smoothDeath = 0
local smoothDeathText = 0
function GM:HUDPaint()
  local ply = LocalPlayer()

  if !ply:Alive() then
    surface.SetFont("DeathFont")
    local textW, textH = surface.GetTextSize( "You are Dead" )

    smoothDeath = Lerp( FrameTime(), smoothDeath, 75 )
    smoothDeathText = Lerp( FrameTime() * 3, smoothDeathText, 255 )

    surface.SetDrawColor( 205, 0, 0, smoothDeath )
    surface.DrawRect( 0, 0, ScrW(), ScrH() )

    surface.SetTextColor( 205, 0, 0, smoothDeathText )
    surface.SetTextPos( ScrW() / 2 - textW / 2, ScrH() / 2 - textH / 2 )
    surface.DrawText( "You are Dead" )
    return
  end

  local health = ply:Health()
  smoothHealth = Lerp( FrameTime() * 3, smoothHealth, health )

  draw.RoundedBox( 0, 15, ScrH() - 65, smoothHealth * 2.5, 50, Color( 205, 0, 0, 255 ) )
  draw.OutlinedBox( 15, ScrH() - 65, 250, 50, 3, Color( 0, 0, 0, 255 ) )

  draw.RoundedBox( 0, 40, ScrH() - 57, 8, 33, Color( 255, 255, 255, 255 ) )
  draw.RoundedBox( 0, 28, ScrH() - 44, 33, 8, Color( 255, 255, 255, 255 ) )

  draw.SimpleText( math.Round( smoothHealth, 0 ), "HUDText", 69, ScrH() - 60, Color( 255, 255, 255, 255 ) )
end

function ShouldHUDDraw( name )
  if ShouldNotDraw[ name ] then return false end
end
hook.Add("HUDShouldDraw", "ShouldHUDDraw", ShouldHUDDraw)
