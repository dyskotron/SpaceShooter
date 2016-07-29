package game.model.gameObject.component.effect
{
    import flash.utils.Dictionary;

    import game.model.GameObject;
    import game.model.gameObject.component.Container;
    import game.model.gameObject.component.IComponent;
    import game.model.gameObject.component.control.WeaponControlComponent;
    import game.model.gameObject.component.effect.property.EffectableProperty;
    import game.model.gameObject.component.fsm.FSMComponent;
    import game.model.gameObject.component.generator.IGeneratorComponent;
    import game.model.gameObject.component.health.HealthComponent;
    import game.model.gameObject.component.movement.IMoveComponent;
    import game.model.gameObject.component.movement.MoveParamsComponent;

    public class EffectsContainer extends Container
    {
        private var _effects: Vector.<PropertyEffectVO>;

        //[propertyID] = IEffectComponent
        private var _components: Vector.<IComponent>;

        private var _lastEffectID: uint = 0;

        private var _: int = 0;

        /**
         * Keeps track of all effects applied to game object
         */
        public function EffectsContainer(): void
        {

        }

        //region LIFECYCLE =============================================================================================

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);

            _components = new Vector.<IComponent>();
            _effects = new Vector.<PropertyEffectVO>;

            _components[ComponentTypeID.MOVE] = aGameObject.getComponent(IMoveComponent);
            _components[ComponentTypeID.MOVE_PARAMS] = aGameObject.getComponent(MoveParamsComponent);
            _components[ComponentTypeID.HEALTH] = aGameObject.getComponent(HealthComponent);
            _components[ComponentTypeID.WEAPON_CONTROL] = aGameObject.getComponent(WeaponControlComponent);
            _components[ComponentTypeID.FSM] = aGameObject.getComponent(FSMComponent);
            _components[ComponentTypeID.GENERATOR] = aGameObject.getComponent(IGeneratorComponent);
        }

        //endregion


        //region PROPERTY EFFECT =======================================================================================

        /**
         * Adds property effect and apply changes to given component
         *
         * @param aComponentID
         * @param aPropertyID
         * @param aPropertyEffectVO
         */
        public function addPropertyEffect(aPropertyEffectVO: PropertyEffectVO): uint
        {
            if (_components[aPropertyEffectVO.componentID] == null)
                return 0;

            trace("_MO_", this, "addPropertyEffect", _lastEffectID);

            aPropertyEffectVO.id = ++_lastEffectID;
            _effects.push(aPropertyEffectVO);
            calculateProperty(aPropertyEffectVO.componentID, aPropertyEffectVO.propertyID);

            return _lastEffectID;
        }

        /**
         * Removes property effect and apply changes to given component
         *
         * @param aComponentID
         * @param aPropertyID
         * @param aEffectID
         */
        public function removePropertyEffect(aEffectID: uint): void
        {
            trace("_MO_", this, "removePropertyEffect", aEffectID);
            for (var i: int = 0; i < _effects.length; i++)
            {
                if (_effects[i].id == aEffectID)
                {
                    var effect: PropertyEffectVO = _effects[i];
                    _effects.splice(i, 1);
                    calculateProperty(effect.componentID, effect.propertyID);
                    return;
                }
            }
        }

        /**
         * Recalculates property and set it to given component
         *
         * @param aComponentID
         * @param aPropertyID
         */
        private function calculateProperty(aComponentID: uint, aPropertyID: uint): void
        {
            var replace: Boolean = false;
            var absolute: Number = 0;
            var additive: Number = 0;
            var multiTotal: Number = 1;
            var multi: Dictionary = new Dictionary();

            var effect: PropertyEffectVO;

            for (var i: int = 0; i < _effects.length; i++)
            {
                effect = _effects[i];
                if (effect.componentID == aComponentID && effect.propertyID == aPropertyID)
                {
                    switch (effect.type)
                    {
                        case EffectTypeID.ABSOLUTE:
                            absolute += effect.value;
                            break;
                        case EffectTypeID.ADDITIVE:
                            additive += effect.value;
                            break;
                        case EffectTypeID.MULTIPLICATIVE:
                            multi[effect.multiGroup] ||= 0;
                            multi[effect.multiGroup] += effect.value;
                            break;
                    }
                }
            }

            for each (var value: Number in multi)
            {
                multiTotal *= Math.max(1 + value, 0);
            }

            var property: EffectableProperty = _components[aComponentID].getProperty(aPropertyID);

            //todo: set abs/add/multi min & max for given properties

            property.replaceOrig = replace;
            property.absolute = absolute;
            property.additive = additive;
            property.multiplicative = multiTotal;
            property.calculate();
        }

        //endregion
    }
}
