package game.model.gameObject.components.weapon
{
    import game.model.gameObject.fsm.ITargetProvider;

    public class EnemyWeaponComponent extends WeaponComponent
    {
        public function EnemyWeaponComponent(aWeaponVO: WeaponModel, aOwnerID: uint, aTargetProvider: ITargetProvider, aX: Number = 0, aY: Number = 0)
        {
            super(aWeaponVO, aOwnerID, aTargetProvider, aX, aY);
        }

        override public function startShoot(aNextShotAfter: Number = 0): void
        {
            super.startShoot(weaponModel.shootInterval * 3 * Math.random());
        }
    }
}
