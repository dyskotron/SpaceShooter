package game.model.gameObject.component.fsm
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.movement.IMoveComponent;

    public class FSMComponent extends Component implements IMoveComponent
    {
        public static const ACTION_NONE: uint = 0;
        public static const ACTION_PREV: uint = 1;
        public static const ACTION_NEXT: uint = 2;
        public static const ACTION_FIRST: uint = 3;
        public static const ACTION_LAST: uint = 4;


        private var _curentState: IEnemyState;
        private var _target: ITarget;

        private var _states: Vector.<IEnemyState>;
        private var _stateIndex: int;

        public function FSMComponent(aStates: Vector.<IEnemyState>, aTarget: ITarget)
        {
            _states = aStates;
            _target = aTarget;
            _stateIndex = 0;
        }

        public function get curentState(): IEnemyState
        {
            return _curentState;
        }

        public function restart(): void
        {
            if (_states.length == 1)
                return;

            _stateIndex = 0;
            startState();
        }

        private function startState(): void
        {
            _curentState = _states[_stateIndex];
            _curentState.start(gameObject, _target);
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject)

            startState();
        }

        override public function update(aDeltaTime: Number): void
        {
            var result: uint = curentState.update(aDeltaTime);

            if (result != ACTION_NONE)
                processResult(result);
        }

        private function processResult(aResult: uint): void
        {
            if (aResult == ACTION_NONE)
                return;

            switch (aResult)
            {
                case ACTION_PREV:
                    _stateIndex = (_stateIndex + _states.length - 1) % _states.length;
                    break;

                case ACTION_NEXT:
                    _stateIndex = (_stateIndex + 1) % _states.length
                    break;

                case ACTION_FIRST:
                    _stateIndex = 0;
                    break;

                case ACTION_LAST:
                    _stateIndex = _states.length - 1;
                    break;
            }

            startState();
        }

        public function applyEffectProperty(aEffectPropertyID: uint, aValue: Number): void
        {
        }
    }
}