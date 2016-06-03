package game.model.gameObject.def
{
    import game.model.gameObject.constants.PlayerShipType;
    import game.model.gameObject.vo.PlayerShipVO;
    import game.model.generator.BatteryModel;
    import game.model.generator.GeneratorModel;
    import game.model.weapon.ComponentSlot;
    import game.model.weapon.IWeaponDefs;
    import game.model.weapon.enums.ComponentType;
    import game.model.weapon.enums.PlayerWeaponID;

    public class PlayerShipDefs implements IPlayerShipDefs
    {
        [Inject]
        public var weaponDef: IWeaponDefs;

        public function PlayerShipDefs()
        {

        }

        //todo get players ship data
        public function getPlayerShip(aShipType: uint)
        {
            //fake player ship data
            //vector of  type + id pairs, indexes in vector are same with slots on ship


            //ship itself definition  todo: replace just with shipDefs.getBaseShip(aShipType) or so, got ship with empty slots
            var componentSlots: Vector.<ComponentSlot>;
            componentSlots = new Vector.<ComponentSlot>();
            componentSlots.push(new ComponentSlot(ComponentType.MAIN_SLOT, 0, 0, weaponDef.getPlayerWeaponModel(PlayerWeaponID.PLASMA)));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, -30, 60, weaponDef.getPlayerWeaponModel(PlayerWeaponID.ELECTRIC)));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 30, 60, weaponDef.getPlayerWeaponModel(PlayerWeaponID.ELECTRIC)));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 0, 60, new BatteryModel(0, 600)));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 0, 60, new BatteryModel(0, 600)));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 0, 60, new GeneratorModel(0, 300)));
            componentSlots.push(new ComponentSlot(ComponentType.SECONDARY_SLOT, 0, 60, new GeneratorModel(0, 300)));
            componentSlots.push(new ComponentSlot(ComponentType.ROCKET, 0, 60));


            //todo: here go through player ship data and add models to slots

            return new PlayerShipVO(PlayerShipType.BASIC_SHOOTER, componentSlots, 150, 99, 75);
        }
    }
}
