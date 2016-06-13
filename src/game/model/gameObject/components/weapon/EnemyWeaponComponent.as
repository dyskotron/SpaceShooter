package game.model.gameObject.components.weapon
{
    import org.osflash.signals.Signal;

    public class EnemyWeaponComponent extends WeaponComponent
    {
        public function EnemyWeaponComponent(aShootSignal: Signal, aWeaponVO: WeaponModel, aOwnerID: uint, aX: Number = 0, aY: Number = 0)
        {
            super(aShootSignal, aWeaponVO, aOwnerID, aX, aY);
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotAfter = weaponModel.shootInterval * 3 * Math.random();
        }
    }
}