package game.model.gameObject.component.effect.fxComponent
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.effect.ComponentTypeID;
    import game.model.gameObject.component.effect.EffectTypeID;
    import game.model.gameObject.component.effect.EffectsContainer;
    import game.model.gameObject.component.effect.PropertyEffectVO;
    import game.model.gameObject.component.effect.property.EffectablePropertyID;

    public class StunEffect extends Component
    {
        private var _fxContainer: EffectsContainer;
        private var _moveEffectID: uint;
        private var _weaponsEffectID: uint;

        public function StunEffect(aLength: Number = 2): void
        {
            super(true, aLength);
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);

            _fxContainer = EffectsContainer(gameObject.getComponent(EffectsContainer));

            //todo: move to defs
            var disableMoveEffect: PropertyEffectVO = new PropertyEffectVO();
            disableMoveEffect.componentID = ComponentTypeID.MOVE;
            disableMoveEffect.propertyID = EffectablePropertyID.ACTIVE;
            disableMoveEffect.type = EffectTypeID.ABSOLUTE;
            disableMoveEffect.value = 0;

            var disableWeaponsEffect: PropertyEffectVO = new PropertyEffectVO();
            disableWeaponsEffect.componentID = ComponentTypeID.WEAPON_CONTROL;
            disableWeaponsEffect.propertyID = EffectablePropertyID.ACTIVE;
            disableWeaponsEffect.type = EffectTypeID.ABSOLUTE;
            disableWeaponsEffect.value = 0;

            _moveEffectID = _fxContainer.addPropertyEffect(disableMoveEffect);
            _weaponsEffectID = _fxContainer.addPropertyEffect(disableWeaponsEffect);
        }

        override public function terminate(): void
        {
            _fxContainer.removePropertyEffect(_moveEffectID);
            _fxContainer.removePropertyEffect(_weaponsEffectID);
        }
    }
}
