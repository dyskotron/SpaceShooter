package game.model.gameObject.component.weapon
{
    import game.model.gameObject.IGameObjectFactory;

    public class EnemyWeaponComponent extends WeaponComponent
    {
        public function EnemyWeaponComponent(aWeaponVO: WeaponModel, aGameObjectFactory: IGameObjectFactory, aX: Number = 0, aY: Number = 0)
        {
            super(aWeaponVO, aGameObjectFactory, aX, aY);
        }

        override public function startShoot(aNextShotAfter: Number = 0): void
        {
            super.startShoot(weaponModel.shootInterval * 3 * Math.random());
        }
    }
}
