SWEP.Base   =   "weapon_base"

SWEP.PrintName  = "Colt M1911"
SWEP.Instructions   =   "You spawn with the Colt M1911 as a starter gun to kill zombies."

SWEP.Primary.ClipSize   = 7
SWEP.Primary.DefaultClip    = 49
SWEP.Primary.Automatic  = false
SWEP.Primary.Ammo   = "Pistol"
SWEP.Primary.Recoil =   0
SWEP.Primary.Spread =   0.03
SWEP.Primary.Delay  =   0.1

SWEP.Slot   = 1
SWEP.SlotPos    = 1
SWEP.DrawAmmo   = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"

local ShootingSound = Sound( "Weapon_FiveSeven.Single" )
local ReloadSound = Sound( "Weapon_Pistol.Reload" )

function SWEP:Initialize()
    self:SetWeaponHoldType( "pistol" )
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end

    local ply = self:GetOwner()

    ply:LagCompensation( true )

        local Shot = {}
        Shot.Num = 1
        Shot.Src = ply:GetShootPos()
        Shot.Dir = ply:GetAimVector()
        Shot.Spread = Vector( self.Primary.Spread, self.Primary.Spread, 0 )
        Shot.Tracer = TRACER_LINE_AND_WHIZ
        Shot.Damage = math.random( 10, 20 )
        Shot.AmmoType = self.Primary.Ammo

        self:FireBullets( Shot )
        self.BaseClass.ShootEffects( self )
        self:TakePrimaryAmmo( 1 )
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

        self:EmitSound( ShootingSound )

    ply:LagCompensation( false )
end

function SWEP:CanSecondaryAttack()
    return false
end

function SWEP:Reload()
    if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
    
    if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
        self:DefaultReload( ACT_RELOAD_PISTOL )

        local AnimationTime = self.Owner:GetViewModel():SequenceDuration() + 0.55
        self.ReloadingTime = CurTime() + AnimationTime
        self:SetNextPrimaryFire(CurTime() + AnimationTime)
        self:SetNextSecondaryFire(CurTime() + AnimationTime)

        self:EmitSound( ReloadSound )
    end
end