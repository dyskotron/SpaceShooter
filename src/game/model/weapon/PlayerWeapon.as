package game.model.weapon
{
    import org.osflash.signals.Signal;

    public class PlayerWeapon extends Weapon
    {
        public static const MIN_POWER: uint = 0;

        private var playerWeaponModel: PlayerWeaponModel;

        public function PlayerWeapon(aShootSignal: Signal, aWeaponModel: WeaponModel, aX: Number = 0, aY: Number = 0, _aPower: uint = MIN_POWER)
        {
            super(aShootSignal, aWeaponModel, aX, aY);

            playerWeaponModel = PlayerWeaponModel(_weaponModel);
            playerWeaponModel.setPower(_aPower);
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
    }
}