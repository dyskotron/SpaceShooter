/**
 * Created with IntelliJ IDEA.
 * User: DYSKO
 * Date: 5/18/13
 * Time: 9:11 PM
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject
{
    import flash.utils.getTimer;

    import game.model.gameObject.constants.BulletType;
    import game.model.gameObject.vo.BulletVO;
    import game.model.gameObject.vo.EnemyVO;

    public class EnemyGO extends ShootingGO
    {
        //px / s
        public static const MAX_SPEED: Number = 200;
        public static const MIN_SPEED: Number = 100;

        /**
         * Coordinates where player ship is heading to.
         * it stores mouse position for mouse controller
         * or emulates "keyboard position" translated from keys pressed for keyboard controller
         */
        public var controlX: Number = 0;
        public var controlY: Number = 0;
        private var _enemyVO: EnemyVO;

        public function EnemyGO(aEnemyVO: EnemyVO, aX: Number, aY: Number, aPlayerGO: PlayerShipGO): void
        {
            super(aEnemyVO, aX, aY, 0, 0);

            _enemyVO = aEnemyVO;
            controlX = aPlayerGO.x;
            controlY = aPlayerGO.y;

            startShoot();
        }

        public function get enemyVO(): EnemyVO
        {
            return _enemyVO;
        }

        override public function update(aDeltaTime: int): void
        {
            //_x += Math.min((controlX - _x), MAX_SPEED * aDeltaTime / 1000);
            //_y += MathUtil.clamp((controlY - _y), MIN_SPEED * aDeltaTime / 1000, MAX_SPEED * aDeltaTime / 1000);

            _y += MAX_SPEED * aDeltaTime / 1000;

            super.update(aDeltaTime);
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotTime = getTimer() + shootInterval * 3 * Math.random();
        }

        override public function destroy(): void
        {

        }


        override protected function shoot(): void
        {
            var bullets: Vector.<BulletGO> = new Vector.<BulletGO>();
            var bulletVO: BulletVO = new BulletVO(BulletType.LASER, 10, 4, 10);

            bullets.push(new BulletGO(-1, bulletVO, x + 8, y, 0, 0.6));
            bullets.push(new BulletGO(-1, bulletVO, x - 8, y, 0, 0.6));

            shootSignal.dispatch(bullets);
            super.shoot();
        }

    }
}
