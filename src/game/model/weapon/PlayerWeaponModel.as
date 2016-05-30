package game.model.weapon
{
    public class PlayerWeaponModel extends WeaponModel
    {
        private var _spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>>;
        private var _shootIntervalByPower: Vector.<uint>;

        public function PlayerWeaponModel(aWeaponType: uint, aShootInterval: Vector.<uint>, aSpawnPoints: Vector.<Vector.<BulletSpawnVO>>)
        {
            _spawnPointsByPower = aSpawnPoints;
            _shootIntervalByPower = aShootInterval;

            super(aWeaponType, aShootInterval[0], aSpawnPoints[0]);
        }

        public function updatePower(aPower: uint): void
        {
            _spawnPoints = _spawnPointsByPower[Math.min(aPower, _spawnPointsByPower.length - 1)];
            _shootInterval = _shootIntervalByPower[Math.min(aPower, _shootIntervalByPower.length - 1)];
        }

        public function get maxPower(): uint
        {
            return _spawnPointsByPower.length - 1;
        }
    }
}
