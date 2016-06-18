package game.model.gameObject.components.weapon
{
    public class EnemyWeaponComponent extends WeaponComponent
    {
        public function EnemyWeaponComponent(aWeaponVO: WeaponModel, aX: Number = 0, aY: Number = 0)
        {
            super(aWeaponVO, aX, aY);
        }

        override public function startShoot(aNextShotAfter: Number = 0): void
        {
            super.startShoot(weaponModel.shootInterval * 3 * Math.random());
        }
    }
}
