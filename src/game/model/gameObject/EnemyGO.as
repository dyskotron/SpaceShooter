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
    import game.model.gameObject.enemy.EnemyFSMx;
    import game.model.gameObject.enemy.IEnemyState;
    import game.model.gameObject.enemy.ITarget;
    import game.model.gameObject.enemy.state.GetToPosState;
    import game.model.gameObject.enemy.state.GetToYposState;
    import game.model.gameObject.vo.BulletVO;
    import game.model.gameObject.vo.EnemyVO;

    public class EnemyGO extends ShootingGO
    {
        //px / s
        public static const MAX_SPEED: Number = 200;
        public static const MIN_SPEED: Number = 100;

        private var _enemyVO: EnemyVO;


        private var _fsm: EnemyFSMx;

        public function EnemyGO(aEnemyVO: EnemyVO, aStates: Vector.<IEnemyState>, aX: Number, aY: Number, aTarget: ITarget): void
        {
            super(aEnemyVO, aX, aY, 0, 0);

            _enemyVO = aEnemyVO;

            aStates = new Vector.<IEnemyState>();
            aStates.push(new GetToYposState());
            aStates.push(new GetToPosState());

            _fsm = new EnemyFSMx(aStates, this, aTarget);

            startShoot();
        }

        public function get enemyVO(): EnemyVO
        {
            return _enemyVO;
        }

        public function get maxSpeed(): Number
        {
            return MAX_SPEED;
        }

        public function get minSpeed(): Number
        {
            return MIN_SPEED;
        }

        override public function update(aDeltaTime: int): void
        {
            _fsm.update(this, aDeltaTime);
            _fsm.curentState.update(this, aDeltaTime);

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
            var bulletVO: BulletVO = new BulletVO(BulletType.LASER, 15, 4, 10);

            bullets.push(new BulletGO(-1, bulletVO, x + 8, y, 0, 0.6));
            bullets.push(new BulletGO(-1, bulletVO, x - 8, y, 0, 0.6));

            shootSignal.dispatch(bullets);
            super.shoot();
        }

    }
}
