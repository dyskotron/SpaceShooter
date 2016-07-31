package game.model.playerModel
{
    import game.model.gameObject.component.ComponentType;
    import game.model.gameObject.component.generator.BatteryID;
    import game.model.gameObject.component.generator.GeneratorID;
    import game.model.gameObject.component.weapon.enums.PlayerWeaponID;
    import game.model.gameObject.constants.PlayerShipType;

    import org.robotlegs.mvcs.Actor;

    public class PlayerModel extends Actor implements IPlayerModel
    {
        private var _shipBuild: PlayerShipBuildVO;
        private var _score: uint;

        public function PlayerModel()
        {
            var componentSlots: Vector.<BuildComponentSlotVO> = new Vector.<BuildComponentSlotVO>;
            componentSlots.push(new BuildComponentSlotVO(PlayerWeaponID.ELECTRIC, ComponentType.MAIN_GUN));
            //componentSlots.push(new BuildComponentSlotVO(PlayerWeaponID.ROCKET_LAUNCHER, ComponentType.SECONDARY_GUN));
            //componentSlots.push(new BuildComponentSlotVO(PlayerWeaponID.PLASMA, ComponentType.SECONDARY_GUN));
            //componentSlots.push(new BuildComponentSlotVO(PlayerWeaponID.PLASMA, ComponentType.SECONDARY_GUN));
            componentSlots.push(new BuildComponentSlotVO(GeneratorID.BASIC, ComponentType.GENERATOR));
            componentSlots.push(new BuildComponentSlotVO(GeneratorID.BASIC, ComponentType.GENERATOR));
            componentSlots.push(new BuildComponentSlotVO(BatteryID.BASIC, ComponentType.BATTERY));
            componentSlots.push(new BuildComponentSlotVO(BatteryID.BASIC, ComponentType.BATTERY));

            _shipBuild = new PlayerShipBuildVO(PlayerShipType.BASIC_SHOOTER, componentSlots);

            _score = 0;
        }

        public function get shipBuild(): PlayerShipBuildVO
        {
            return _shipBuild;
        }

        public function get score(): uint
        {
            return _score;
        }

        public function addScore(aScore: uint): void
        {
            _score += aScore;
        }
    }
}
