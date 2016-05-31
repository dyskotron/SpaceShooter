package game.model.weapon
{
    import org.osflash.signals.Signal;

    public class EnemyWeapon extends WeaponComponent
    {
        public function EnemyWeapon(aShootSignal: Signal, aWeaponVO: WeaponModel, aX: Number = 0, aY: Number = 0)
        {
            super(aShootSignal, aWeaponVO, aX, aY);
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotAfter = _weaponModel.shootInterval * 3 * Math.random();
        }
    }
}
