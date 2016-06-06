package game.model.gameObject.def
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.generator.BatteryModel;
    import game.model.gameObject.components.generator.GeneratorModel;
    import game.model.gameObject.components.weapon.ComponentModel;
    import game.model.gameObject.components.weapon.ComponentSlot;
    import game.model.gameObject.components.weapon.IWeaponDefs;
    import game.model.gameObject.constants.PlayerShipType;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.playerModel.BuildComponentSlotVO;
    import game.model.playerModel.PlayerShipBuildVO;

    public class PlayerShipDefs implements IPlayerShipDefs
    {
        [Inject]
        public var weaponDef: IWeaponDefs;

        public function PlayerShipDefs()
        {

        }

        //todo get players ship data
        public function getPlayerShip(aShipBuild: PlayerShipBuildVO): PlayerShipVO
        {
            var shipVO: PlayerShipVO = getBaseShip(aShipBuild.shipTypeID);

            for (var i: int = 0; i < aShipBuild.componentSlots.length; i++)
            {
                shipVO.addComponent(i, getComponentModel(aShipBuild.componentSlots[i]));
            }

            return shipVO;
        }

        private function getBaseShip(aShipTypeID: uint): PlayerShipVO
        {
            var componentSlots: Vector.<ComponentSlot>;
            componentSlots = new Vector.<ComponentSlot>();
            componentSlots.push(new ComponentSlot(ComponentType.MAIN_SLOT, 0, 0));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -45, 0));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 45, 0));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -30, 0));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 30, 0));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -15, 0));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 15, 0));
            componentSlots.push(new ComponentSlot(ComponentType.ROCKET, 0, 60));

            return new PlayerShipVO(PlayerShipType.BASIC_SHOOTER, componentSlots, 150, 99, 75);
        }

        //TODO: move this to component defs
        private function getComponentModel(aBuildComponentSlotVO: BuildComponentSlotVO): ComponentModel
        {
            var componentModel: ComponentModel;

            switch (aBuildComponentSlotVO.componentType)
            {
                case ComponentType.MAIN_GUN:
                    componentModel = weaponDef.getMainWeaponModel(aBuildComponentSlotVO.componentID);
                    break;
                case ComponentType.SECONDARY_GUN:
                    componentModel = weaponDef.getSeconaryWeaponModel(aBuildComponentSlotVO.componentID);
                    break;
                case ComponentType.GENERATOR:
                    componentModel = new GeneratorModel(0, 300);
                    break;
                case ComponentType.BATTERY:
                    componentModel = new BatteryModel(0, 600);
                    break;
                default:
                    throw new Error("No component for component type ID: " + aBuildComponentSlotVO.componentType);

            }

            return componentModel;
        }
    }
}
