/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 02/06/16
 * Time: 20:51
 * To change this template use File | Settings | File Templates.
 */
package game.model.gameObject.components.weapon
{
    public class ComponentSlot
    {
        private var _validTypes: uint;
        private var _x: Number;
        private var _y: Number;
        private var _rotation: Number;
        private var _direction: Number;
        private var _componentModel: ComponentModel;

        /**
         * Class representing ship's slot for components like weapons, generators, etc
         * @param aValidTypes - @see game.model.gameObject.components.ComponentType
         * @param aX - x position of component relative to ship
         * @param aY - y position of component relative to ship
         * @param aRotation - rotation of component
         * @param aDirection - orientation, used for left/right component mirroring @see enums.SlotDirection
         * @param aComponentModel @see ComponentModel
         */
        public function ComponentSlot(aValidTypes: uint, aX: Number, aY: Number, aRotation: Number = Math.PI, aDirection: int = 1, aComponentModel: ComponentModel = null)
        {
            _validTypes = aValidTypes;
            _x = aX;
            _y = aY;

            _rotation = aRotation;
            _direction = aDirection;

            if (aComponentModel)
                setComponent(aComponentModel);
        }

        public function get componentModel(): ComponentModel
        {
            return _componentModel;
        }

        /**
         * Returns bit mask with allowed component types
         */
        public function get validTypes(): uint
        {
            return _validTypes;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function hasComponent(): Boolean
        {
            return _componentModel != null;
        }

        public function setComponent(aComponentModel: ComponentModel): void
        {
            if (isTypeValid(aComponentModel.componentType))
            {
                _componentModel = aComponentModel;
                _componentModel.rotate(_rotation, _direction);
            }
            else
            {
                throw new Error("Component(" + aComponentModel.componentType + ") not valid in slot. types:" + _validTypes);
            }
        }

        /**
         * Checks if component in slot is one of given types
         * @param aTypeIDs - single component ID, or multiple IDs in one bit mask to be tested
         * @return
         */
        public function isComponentType(aTypeIDs: uint): Boolean
        {
            if (!hasComponent())
                return false;

            return aTypeIDs & _componentModel.componentType;
        }

        public function isTypeValid(aTypeID: uint): Boolean
        {
            return _validTypes & aTypeID;
        }
    }
}
