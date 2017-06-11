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

surface.CreateFont("HUDTextName", {
  font = "Futura (Light)",
  size = 22,
  weight = 500,
  antialias = true,
  outline = true
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
local smoothAmmo = 0
local ammoCount
local ammoCountTotal
local ammoPercentage
function GM:HUDPaint()
  local ply = LocalPlayer()

  for k, v in pairs( player.GetAll() ) do
    if v == ply then continue end

    local pHP = v:Health()
    local pNick = v:Nick()
    local pPos
    local pScreenpos

    if v:Alive() then
      pPos = v:GetPos() + Vector(0, 0, 64)
      pScreenpos = pPos:ToScreen()
      draw.RoundedBox( 0, pScreenpos.x, pScreenpos.y - 5, pHP, 25, Color( 205, 0, 0, 200 ) )
      draw.OutlinedBox( pScreenpos.x, pScreenpos.y - 5, 100, 25, 3, Color( 0, 0, 0, 255 ) )

      surface.SetTextColor( 255, 255, 255, 255 )
      surface.SetFont( "HUDTextName" )
      surface.SetTextPos( pScreenpos.x + 5, pScreenpos.y - 3)
      surface.DrawText( pHP )
    else
      if v:GetRagdollEntity() != nil then
        pPos = v:GetRagdollEntity():GetPos() + Vector(0, 0, 64)
        pScreenpos = pPos:ToScreen()
      else
        pPos = v:GetPos() + Vector(0, 0, 64)
        pScreenpos = pPos:ToScreen()
      end
      surface.SetTextColor( 255, 0, 0, 255 )
      surface.SetFont( "HUDTextName" )
      surface.SetTextPos( pScreenpos.x, pScreenpos.y - 5)
      surface.DrawText( "DEAD" )
    end

    surface.SetTextColor( 255, 255, 255, 255 )
    surface.SetFont( "HUDTextName" )
    surface.SetTextPos( pScreenpos.x, pScreenpos.y - 27 )
    surface.DrawText( pNick )
  end

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

  smoothDeath = 0
  smoothDeathText = 0

  local health = ply:Health()

  if smoothHealth <= 100 then
    smoothHealth = Lerp( FrameTime() * 3, smoothHealth, health )
  else
    smoothHealth = 100
  end

  draw.RoundedBox( 0, 15, ScrH() - 65, smoothHealth * 2.5, 50, Color( 205, 0, 0, 255 ) )
  draw.OutlinedBox( 15, ScrH() - 65, 250, 50, 3, Color( 0, 0, 0, 255 ) )

  draw.RoundedBox( 0, 40, ScrH() - 57, 8, 33, Color( 255, 255, 255, 255 ) )
  draw.RoundedBox( 0, 28, ScrH() - 44, 33, 8, Color( 255, 255, 255, 255 ) )

  draw.SimpleText( math.Round( smoothHealth, 0 ), "HUDText", 69, ScrH() - 60, Color( 255, 255, 255, 255 ) )

  if ply:GetActiveWeapon():IsValid() then
    ammoCount = ply:GetActiveWeapon():Clip1()
    ammoCountTotal = ply:GetAmmoCount( ply:GetActiveWeapon():GetPrimaryAmmoType() )
    ammoPercentage = ( ammoCount / ply:GetActiveWeapon():GetMaxClip1() ) * 100
  end

  smoothAmmo = Lerp( FrameTime() * 3, smoothAmmo, ammoPercentage )

  if ammoCount != -1 then
    draw.RoundedBox( 0, 270, ScrH() - 65, smoothAmmo * 2.5, 50, Color( 245, 155, 0, 255 ) )
    draw.OutlinedBox( 270, ScrH() - 65, 250, 50, 3, Color( 0, 0, 0, 255 ) )

    draw.RoundedBox( 0, 288, ScrH() - 35, 7, 6, Color( 255, 255, 255, 255 ) )
    draw.RoundedBoxEx( 5, 288, ScrH() - 52, 7, 15, Color( 255, 255, 255, 255 ), true, true, false, false )

    draw.RoundedBox( 0, 298, ScrH() - 35, 7, 6, Color( 255, 255, 255, 255 ) )
    draw.RoundedBoxEx( 5, 298, ScrH() - 52, 7, 15, Color( 255, 255, 255, 255 ), true, true, false, false )

    draw.RoundedBox( 0, 308, ScrH() - 35, 7, 6, Color( 255, 255, 255, 255 ) )
    draw.RoundedBoxEx( 5, 308, ScrH() - 52, 7, 15, Color( 255, 255, 255, 255 ), true, true, false, false )

    draw.SimpleText( ammoCount .. " / " .. ammoCountTotal, "HUDText", 322, ScrH() - 60, Color( 255, 255, 255, 255 ) )
  end
end

function ShouldHUDDraw( name )
  if ShouldNotDraw[ name ] then return false end
end
hook.Add("HUDShouldDraw", "ShouldHUDDraw", ShouldHUDDraw)
