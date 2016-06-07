package game.model.playerModel
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.generator.BatteryID;
    import game.model.gameObject.components.generator.GeneratorID;
    import game.model.gameObject.components.weapon.enums.PlayerWeaponID;
    import game.model.gameObject.constants.PlayerShipType;

    import org.robotlegs.mvcs.Actor;

    public class PlayerModel extends Actor implements IPlayerModel
    {
        private var _shipBuild: PlayerShipBuildVO;

        public function PlayerModel()
        {
            var componentSlots: Vector.<BuildComponentSlotVO> = new Vector.<BuildComponentSlotVO>;
            componentSlots.push(new BuildComponentSlotVO(PlayerWeaponID.PLASMA, ComponentType.MAIN_GUN));
            componentSlots.push(new BuildComponentSlotVO(PlayerWeaponID.LASER, ComponentType.SECONDARY_GUN));
            componentSlots.push(new BuildComponentSlotVO(PlayerWeaponID.LASER, ComponentType.SECONDARY_GUN));
            componentSlots.push(new BuildComponentSlotVO(GeneratorID.BASIC, ComponentType.GENERATOR));
            componentSlots.push(new BuildComponentSlotVO(GeneratorID.BASIC, ComponentType.GENERATOR));
            componentSlots.push(new BuildComponentSlotVO(BatteryID.BASIC, ComponentType.BATTERY));
            componentSlots.push(new BuildComponentSlotVO(BatteryID.BASIC, ComponentType.BATTERY));

            _shipBuild = new PlayerShipBuildVO(PlayerShipType.BASIC_SHOOTER, componentSlots);
        }

        public function get shipBuild(): PlayerShipBuildVO
        {
            return _shipBuild;
        }
    }
}
