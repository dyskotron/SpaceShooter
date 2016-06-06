package game.model.playerModel
{
    public class PlayerShipBuildVO
    {
        private var _shipTypeID: uint;
        private var _componentSlots: Vector.<BuildComponentSlotVO>;

        public function PlayerShipBuildVO(aShipTypeID: uint, aComponentSlots: Vector.<BuildComponentSlotVO>)
        {
            _shipTypeID = aShipTypeID;
            _componentSlots = aComponentSlots;
        }

        public function get shipTypeID(): uint
        {
            return _shipTypeID;
        }

        public function get componentSlots(): Vector.<BuildComponentSlotVO>
        {
            return _componentSlots;
        }
    }
}
