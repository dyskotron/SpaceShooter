package game.model.gameObject.vo
{
    import game.model.gameObject.component.weapon.ComponentModel;
    import game.model.gameObject.component.weapon.ComponentSlot;

    public class ShootingVO extends HittableVO
    {
        private var _componentSlots: Vector.<ComponentSlot>;

        public function ShootingVO(aTypeID: uint, aComponents: Vector.<ComponentSlot>, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            _componentSlots = aComponents;
            super(aTypeID, aInitialHP, aWidth, aHeight);
        }

        public function get componentSlots(): Vector.<ComponentSlot>
        {
            return _componentSlots;
        }

        public function addComponent(aSlotIndex: uint, aComponentModel: ComponentModel): void
        {
            if (aSlotIndex > _componentSlots.length - 1)
                return;

            _componentSlots[aSlotIndex].setComponent(aComponentModel);
        }
    }
}
