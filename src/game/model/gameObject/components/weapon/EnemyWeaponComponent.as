package game.model.gameObject.components.weapon
{
    import game.model.gameObject.fsm.ITargetProvider;

    import org.osflash.signals.Signal;

    public class EnemyWeaponComponent extends WeaponComponent
    {
        public function EnemyWeaponComponent(aShootSignal: Signal, aWeaponVO: WeaponModel, aOwnerID: uint, aTargetProvider: ITargetProvider, aX: Number = 0, aY: Number = 0)
        {
            super(aShootSignal, aWeaponVO, aOwnerID, aTargetProvider, aX, aY);
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotAfter = weaponModel.shootInterval * 3 * Math.random();
        }
    }
}
