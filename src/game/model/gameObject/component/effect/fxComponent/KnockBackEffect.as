package game.model.gameObject.component.effect.fxComponent
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.effect.ComponentTypeID;
    import game.model.gameObject.component.effect.EffectTypeID;
    import game.model.gameObject.component.effect.EffectsContainer;
    import game.model.gameObject.component.effect.PropertyEffectVO;
    import game.model.gameObject.component.effect.property.EffectablePropertyID;
    import game.model.gameObject.component.fsm.FSMComponent;
    import game.model.gameObject.component.transform.TransformComponent;

    public class KnockBackEffect extends Component
    {
        private const KNOCK_LENGTH: Number = 0.3;
        private const WAIT_LENGTH: Number = 0;

        private var _transform: TransformComponent;
        private var _speedX: Number;
        private var _speedY: Number;
        private var _fsmComponent: FSMComponent;
        private var _fxContainer: EffectsContainer;
        private var _lastPosX: Number = 0;
        private var _lastPosY: Number = 0;
        private var _propertyEffectID: uint;

        public function KnockBackEffect(aInitSpeedX: Number, aInitSpeedY: Number): void
        {
            _speedX = aInitSpeedX;
            _speedY = aInitSpeedY;

            super(true, KNOCK_LENGTH + WAIT_LENGTH);
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            _transform = aGameObject.transform;
            _fsmComponent = FSMComponent(aGameObject.getComponent(FSMComponent));

            _fxContainer = EffectsContainer(gameObject.getComponent(EffectsContainer));


            //todo: move to defs
            var disableMoveEffect: PropertyEffectVO = new PropertyEffectVO();
            disableMoveEffect.componentID = ComponentTypeID.MOVE;
            disableMoveEffect.propertyID = EffectablePropertyID.ACTIVE;
            disableMoveEffect.type = EffectTypeID.ABSOLUTE;
            disableMoveEffect.value = 0;

            _propertyEffectID = _fxContainer.addPropertyEffect(disableMoveEffect);
        }

        override public function update(aDeltaTime: Number): void
        {
            super.update(aDeltaTime);

            if (lifeTime < KNOCK_LENGTH)
            {
                var ratio: Number = (KNOCK_LENGTH - lifeTime) / KNOCK_LENGTH;

                var newX: Number = _speedX * (1 - (Math.pow(ratio, 4)));
                var newY: Number = _speedY * (1 - (Math.pow(ratio, 4)));

                _transform.x -= newX - _lastPosX;
                _transform.y -= newY - _lastPosY;

                _lastPosX = newX;
                _lastPosY = newY;
            }

        }


        override public function terminate(): void
        {
            _fxContainer.removePropertyEffect(_propertyEffectID);
            _fsmComponent.restart();
        }
    }
}
