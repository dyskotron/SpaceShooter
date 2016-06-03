package game.model.gameObject.vo
{
    import game.model.weapon.ComponentSlot;

    public class ShootingVO extends HittableVO
    {
        private var _componentSlots: Vector.<ComponentSlot>;

        public function ShootingVO(aTypeID: uint, aWeapons: Vector.<ComponentSlot>, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            _componentSlots = aWeapons;
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }

        public function get componentSlots(): Vector.<ComponentSlot>
        {
            return _componentSlots;
        }
    }
}
