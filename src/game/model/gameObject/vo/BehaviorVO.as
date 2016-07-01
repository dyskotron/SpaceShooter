package game.model.gameObject.vo
{
    import game.model.gameObject.component.fsm.IEnemyState;

    public class BehaviorVO
    {
        private var _states: Vector.<IEnemyState>;

        public function BehaviorVO()
        {
            _states = new Vector.<IEnemyState>;
        }

        public function addState(aState: IEnemyState): void
        {
            _states.push(aState);
        }

        public function get states(): Vector.<IEnemyState>
        {
            return _states;
        }
    }
}
