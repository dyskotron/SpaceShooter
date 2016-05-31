package game.model.weapon
{
    public class PlayerWeaponModel extends WeaponModel
    {
        private var _spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>>;
        private var _shootIntervalByPower: Vector.<uint>;
        private var _power: uint;

        public function PlayerWeaponModel(aWeaponType: uint, aShootInterval: Vector.<uint>, aSpawnPoints: Vector.<Vector.<BulletSpawnVO>>)
        {
            _spawnPointsByPower = aSpawnPoints;
            _shootIntervalByPower = aShootInterval;

            super(aWeaponType, aShootInterval[0], aSpawnPoints[0]);
        }

        public function get maxPower(): uint
        {
            return Math.max(_spawnPointsByPower.length - 1, _shootIntervalByPower.length - 1);
        }

        public function get power(): uint
        {
            return _power;
        }

        public function setPower(aPower: uint): void
        {
            _power = Math.min(aPower, maxPower);
            _spawnPoints = _spawnPointsByPower[Math.min(_power, _spawnPointsByPower.length - 1)];
            _shootInterval = _shootIntervalByPower[Math.min(_power, _shootIntervalByPower.length - 1)];
        }
    }
}
