package game.model.gameObject.components.weapon
{
    import game.model.gameObject.components.generator.IGeneratorComponent;
    import game.model.gameObject.components.generator.IGeneratorGO;

    import org.osflash.signals.Signal;

    public class PlayerWeaponComponent extends WeaponComponent
    {
        public static const MIN_POWER: uint = 0;

        private var playerWeaponModel: PlayerWeaponModel;
        private var _generator: IGeneratorComponent;

        public function PlayerWeaponComponent(aGeneratorGO: IGeneratorGO, aShootSignal: Signal, aWeaponModel: WeaponModel, aOwnerID: uint, aX: Number = 0, aY: Number = 0, _aPower: uint = MIN_POWER)
        {
            super(aShootSignal, aWeaponModel, aOwnerID, aX, aY);

            playerWeaponModel = PlayerWeaponModel(_weaponModel);
            playerWeaponModel.setPower(_aPower);
            _generator = aGeneratorGO.generatorComponent;
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
            stopShoot();
        }

        override protected function shoot(aX: Number, aY: Number): void
        {
            if (_generator.deplete(playerWeaponModel.energyCost))
            {
                super.shoot(aX, aY);
            }
        }
    }
}