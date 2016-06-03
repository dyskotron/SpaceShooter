/**
 * Created with IntelliJ IDEA.
 * User: dysko
 * Date: 02/06/16
 * Time: 20:51
 * To change this template use File | Settings | File Templates.
 */
package game.model.weapon
{
    public class ComponentSlot
    {
        private var _types: uint;
        private var _x: Number;
        private var _y: Number;
        private var _componentModel: ComponentModel;

        /**
         * Class representing ship's slot for components like weapons, generators, etc
         * @param aType - @see game.model.weapon.enums.ComponentType
         * @param aX - x position of component relative to ship
         * @param aY - y position of component relative to ship
         * @param aComponentModel @see ComponentModel
         */
        public function ComponentSlot(aType: uint, aX: Number, aY: Number, aComponentModel: ComponentModel = null)
        {
            _types = aType;
            _x = aX;
            _y = aY;
            _componentModel = aComponentModel;
        }

        public function get componentModel(): ComponentModel
        {
            return _componentModel;
        }

        /**
         * Returns bit mask with allowed component types
         */
        public function get types(): uint
        {
            return _types;
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

        /**
         * Checks if component in slot is one of given types
         * @param aTypeIDs - single component ID, or multiple IDs in one bit mask to be tested
         * @return
         */
        public function isType(aTypeIDs: uint): Boolean
        {
            if (!hasComponent())
                return false;

            return aTypeIDs & _componentModel.componentType;
        }
    }
}
