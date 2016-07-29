package game.model.gameObject.component.effect.fxComponent
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.effect.EffectsContainer;
    import game.model.gameObject.component.fsm.FSMComponent;
    import game.model.gameObject.component.transform.TransformComponent;

    public class KnockBackEffect extends Component
    {
        private const KNOCK_LENGTH: Number = 0.8;

        private var _transform: TransformComponent;
        private var _speedX: Number;
        private var _speedY: Number;
        private var _fsmComponent: FSMComponent;
        private var _fxContainer: EffectsContainer;
        private var _lastPosX: Number = 0;
        private var _lastPosY: Number = 0;

        public function KnockBackEffect(aInitSpeedX: Number, aInitSpeedY: Number): void
        {
            _speedX = aInitSpeedX / 4;
            _speedY = aInitSpeedY / 4;

            super(true, KNOCK_LENGTH);
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _transform = aGameObject.transform;
            _fsmComponent = FSMComponent(aGameObject.getComponent(FSMComponent));

            _fxContainer = EffectsContainer(gameObject.getComponent(EffectsContainer));
        }

        override public function update(aDeltaTime: Number): void
        {
            super.update(aDeltaTime);

            if (lifeTime <= KNOCK_LENGTH)
            {
                var ratio: Number = (KNOCK_LENGTH - lifeTime) / KNOCK_LENGTH;

                var newX: Number = _speedX * ((Math.pow(ratio, 2)));
                var newY: Number = _speedY * ((Math.pow(ratio, 2)));

                _transform.x -= newX - _lastPosX;
                _transform.y -= newY - _lastPosX;

                _lastPosX = newX;
                _lastPosY = newY;
            }

        }

        override public function terminate(): void
        {
            _fsmComponent.restart();
        }
    }
}
