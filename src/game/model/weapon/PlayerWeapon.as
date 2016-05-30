package game.model.weapon
{
    import org.osflash.signals.Signal;

    public class PlayerWeapon extends Weapon
    {
        public static const MIN_POWER: uint = 0;

        private var _power: uint = MIN_POWER;

        public function PlayerWeapon(aShootSignal: Signal, aWeaponModel: WeaponModel, aX: Number = 0, aY: Number = 0, _aPower: uint = MIN_POWER)
        {
            super(aShootSignal, aWeaponModel, aX, aY);

            _power = _aPower;
            PlayerWeaponModel(_weaponModel).updatePower(_power);
        }

        public function get displayedPower(): uint
        {
            return _power + 1;
        }

        public function get power(): uint
        {
            return _power;
        }

        override public function startShoot(): void
        {
            super.startShoot();
            _nextShotAfter = 0;
        }

        public function addPower(): void
        {
            _power = Math.min(++_power, PlayerWeaponModel(_weaponModel).maxPower);
            PlayerWeaponModel(_weaponModel).updatePower(_power);
        }

        public function onDeath(): void
        {
            _power = Math.max(Math.floor(_power / 2), MIN_POWER);
            PlayerWeaponModel(_weaponModel).updatePower(_power);
            stopShoot();
        }
    }
}