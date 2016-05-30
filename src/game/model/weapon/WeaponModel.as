package game.model.weapon
{
    public class WeaponModel
    {
        /**
         * Spawn points + directions
         * bullet type
         * weapon type - sequence / all at once
         */
        protected var _spawnPoints: Vector.<BulletSpawnVO>;

        private var _weaponType: uint = 0;
        protected var _shootInterval: int;

        public function WeaponModel(aWeaponType: uint, aShootInterval: uint, aSpawnPoints: Vector.<BulletSpawnVO>)
        {
            _weaponType = aWeaponType;
            _shootInterval = aShootInterval;
            _spawnPoints = aSpawnPoints;
        }

        public function get weaponType(): uint
        {
            return _weaponType;
        }

        public function get shootInterval(): int
        {
            return _shootInterval;
        }

        public function get spawnPoints(): Vector.<BulletSpawnVO>
        {
            return _spawnPoints;
        }
    }
}
