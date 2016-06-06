package game.model.playerModel
{
    public class BuildComponentSlotVO
    {
        private var _componentID: uint;
        private var _componentType: uint;

        public function BuildComponentSlotVO(aComponentID: uint, aComponentType: uint)
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
    }
}
