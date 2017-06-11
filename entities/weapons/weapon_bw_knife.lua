SWEP.Base   =   "weapon_base"

SWEP.PrintName  = "Knife"
SWEP.Instructions   =   "You spawn with the Knife to kill zombies if you run out of ammo."

SWEP.Primary.ClipSize   = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic  = false
SWEP.Primary.Ammo   = "none"

SWEP.Slot   = 0
SWEP.SlotPos    = 1
SWEP.DrawAmmo   = true
SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

local Swoosh = Sound( "Weapon_Crowbar.Single" )
local HitSound = Sound( "Weapon_Crowbar.Melee_Hit" )

function SWEP:Initialize()
    self:SetWeaponHoldType( "melee" )
end

function SWEP:PrimaryAttack()
    if CLIENT then return end

    local ply = self:GetOwner()

    ply:LagCompensation( true )

        local ShootPos = ply:GetShootPos()
        local EndShootPos = ShootPos + ply:GetAimVector() * 70
        local tMin = Vector( 1, 1, 1 ) * -10
        local tMax = Vector( 1, 1, 1 ) * 10

        local tr = util.TraceHull( {
            start = ShootPos,
            endpos = EndShootPos,
            filter = ply,
            mask = MASK_SHOT_HULL,
            mins = tMin,
            maxs = tMax
        } )

        if not IsValid( tr.Entity ) then
            tr = util.TraceLine( {
                start = ShootPos,
                endpos = EndShootPos,
                filter = ply,
                mask = MASK_SHOT_HULL
            } )
        end

        local ent = tr.Entity

        if ent:IsValid() && ent:IsPlayer() or ent:IsNPC() then

            self:SendWeaponAnim( ACT_VM_HITCENTER )
            ply:DoAttackEvent()

            ply:EmitSound( HitSound )
            ent:SetHealth( ent:Health() - math.random( 10, 20 ) )

            if ent:Health() <= 0 then
                ent:Kill()
            end

        elseif !ent:IsValid() then
            self:SendWeaponAnim( ACT_VM_MISSCENTER )
            ply:DoAttackEvent()

            ply:EmitSound( Swoosh )
        end

        self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() - 1 )

    ply:LagCompensation( false )
end

function SWEP:CanSecondaryAttack()
    return false
end