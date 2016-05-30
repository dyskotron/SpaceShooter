package game.model.weapon
{
    import flash.utils.getTimer;

    import org.osflash.signals.Signal;

    public class EnemyWeapon extends Weapon
    {
        public function EnemyWeapon(aShootSignal: Signal, aWeaponVO: WeaponModel, aX: Number = 0, aY: Number = 0)
        {
            super(aShootSignal, aWeaponVO, aX, aY);
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotTime = getTimer() + _weaponModel.shootInterval * 3 * Math.random();
        }

        /*
         override protected function shoot(aX: Number, aY: Number): void
         {
         var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();
         var bulletVO: BulletVO = new BulletVO(BulletType.LASER, 15, 4, 10);

         bullets.push(new BulletGO(-1, bulletVO, aX + 8, aY, 0, 0.6));
         bullets.push(new BulletGO(-1, bulletVO, aX - 8, aY, 0, 0.6));

         _shootSignal.dispatch(bullets);

         super.shoot(aX, aY);
         }   */
    }
}
