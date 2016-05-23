package game.model.gameObject.fsm.state
{
    import game.model.gameObject.EnemyGO;
    import game.model.gameObject.fsm.*;

    public class KamikazeStraightState implements IEnemyState
    {
        private var _speed: Number;

        public function KamikazeStraightState()
        {
        }

        public function start(aEnemyGO: EnemyGO, aTarget: ITarget): void
        {
            _speed = aEnemyGO.maxSpeed * 1.5;
        }

        public function update(aEnemyGO: EnemyGO, aDeltaTime: int): uint
        {
            _speed += aEnemyGO.maxSpeed * 0.1;
            aEnemyGO.y += _speed * aDeltaTime / 1000;

            return GameObjectFSM.ACTION_NONE;
        }
    }
}
