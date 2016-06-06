package game.model.gameObject.components.weapon
{
    public class WeaponModel extends ComponentModel
    {
        /**
         * Spawn points + directions
         * bullet type
         * weapon type - sequence / all at once
         */
        protected var _spawnPoints: Vector.<BulletSpawnVO>;

        private var _weaponType: uint = 0;
        protected var _shootInterval: int;

        public function WeaponModel(aComponentID: uint, aComponentType: uint, aWeaponType: uint, aShootInterval: uint, aSpawnPoints: Vector.<BulletSpawnVO>)
        {
            _weaponType = aWeaponType;
            _shootInterval = aShootInterval;
            _spawnPoints = aSpawnPoints;

            super(aComponentID, aComponentType);
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
