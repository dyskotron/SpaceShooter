package game.model.gameObject.component.weapon
{
    public class ComponentModel
    {
        private var _componentID: uint;
        private var _componentType: uint;

        public function ComponentModel(aComponentID: uint, aComponentType: uint)
        {
            _componentID = aComponentID;
            _componentType = aComponentType;
        }

        public function get componentID(): uint
        {
            return _componentID;
        }

        public function get componentType(): uint
        {
            return _componentType;
        }

        public function rotate(aRotation: Number, aOrientation: int): void
        {

        }
    }
}
