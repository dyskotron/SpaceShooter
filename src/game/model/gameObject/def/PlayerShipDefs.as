package game.model.gameObject.def
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.enums.SlotDirection;
    import game.model.gameObject.constants.PlayerShipType;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public class PlayerShipDefs implements IPlayerShipDefs
    {
        [Inject]
        public var componentDefs: IComponentDefs;

        public function PlayerShipDefs()
        {

        }

        //todo get players ship data
        public function getPlayerShip(aShipBuild: PlayerShipBuildVO): PlayerShipVO
        {
            var shipVO: PlayerShipVO = getBaseShip(aShipBuild.shipTypeID);

            for (var i: int = 0; i < aShipBuild.componentSlots.length; i++)
            {
                shipVO.addComponent(i, componentDefs.getComponentModel(aShipBuild.componentSlots[i]));
            }

            return shipVO;
        }

        private function getBaseShip(aShipTypeID: uint): PlayerShipVO
        {
            var componentSlots: Vector.<ComponentSlot>;
            componentSlots = new Vector.<ComponentSlot>();
            componentSlots.push(new ComponentSlot(ComponentType.MAIN_SLOT, 0, 0, Math.PI, SlotDirection.CENTER));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 0, 0, Math.PI, SlotDirection.CENTER));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -45, 0, Math.PI, SlotDirection.LEFT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 45, 0, Math.PI, SlotDirection.RIGHT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -30, 0, Math.PI, SlotDirection.LEFT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 30, 0, Math.PI, SlotDirection.RIGHT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -15, 0, 0, SlotDirection.RIGHT));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 15, 0, 0, SlotDirection.LEFT));
            componentSlots.push(new ComponentSlot(ComponentType.CHARGE_GUN, 0, 60));

            return new PlayerShipVO(PlayerShipType.BASIC_SHOOTER, componentSlots, 150, 99, 75);
        }
    }
}
