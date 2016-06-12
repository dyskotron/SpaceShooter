package game.model.gameObject.components.weapon
{
    import game.model.gameObject.PlayerShipGO;
    import game.model.gameObject.components.generator.IGeneratorComponent;

    import org.osflash.signals.Signal;

    public class PlayerWeaponComponent extends WeaponComponent
    {
        public static const MIN_POWER: uint = 0;

        private var playerWeaponModel: PlayerWeaponModel;
        private var _generator: IGeneratorComponent;
        private var _playerShipGO: PlayerShipGO;

        public function PlayerWeaponComponent(aPlayerShipGO: PlayerShipGO, aShootSignal: Signal, aWeaponModel: WeaponModel, aOwnerID: uint, aX: Number = 0, aY: Number = 0, _aPower: uint = MIN_POWER)
        {
            super(aShootSignal, aWeaponModel, aOwnerID, aX, aY);

            playerWeaponModel = PlayerWeaponModel(aWeaponModel);
            playerWeaponModel.setPower(_aPower);
            _generator = aPlayerShipGO.generatorComponent;
            _playerShipGO = aPlayerShipGO;
        }

        public function get displayedPower(): uint
        {
            return playerWeaponModel.power + 1;
        }

        public function get power(): uint
        {
            return playerWeaponModel.power;
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotAfter = 0;
        }

        public function addPower(): void
        {
            playerWeaponModel.setPower(playerWeaponModel.power + 1);
        }

        public function onDeath(): void
        {
            playerWeaponModel.setPower(Math.max(Math.floor(playerWeaponModel.power / 2), MIN_POWER));
            endShoot();
        }

        override protected function shoot(aX: Number, aY: Number): void
        {
            if (_generator.deplete(playerWeaponModel.energyCost))
            {
                super.shoot(aX, aY);
            }
            else
            {
                _playerShipGO.endShoot();
            }
        }
    }
}