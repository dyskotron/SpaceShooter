package game.model.gameObject.component.weapon
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
        private var _weaponGroup: uint;

        public function WeaponModel(aComponentID: uint, aComponentType: uint, aWeaponType: uint, aWeaponGroup: uint, aShootInterval: uint, aSpawnPoints: Vector.<BulletSpawnVO>)
        {
            _weaponType = aWeaponType;
            _shootInterval = aShootInterval;
            _spawnPoints = aSpawnPoints;
            _weaponGroup = aWeaponGroup;

            super(aComponentID, aComponentType);
        }

        public function get weaponType(): uint
        {
            return _weaponType;
        }

        public function get weaponGroup(): uint
        {
            return _weaponGroup;
        }

        public function get shootInterval(): int
        {
            return _shootInterval;
        }

        public function get spawnPoints(): Vector.<BulletSpawnVO>
        {
            return _spawnPoints;
        }

        override public function rotate(aRotation: Number, aOrientation: int):void
        {
            //recalculate all VOs:

            for (var iS: int = 0; iS < _spawnPoints.length; iS++)
            {
                _spawnPoints[iS].setRotation(aRotation, aOrientation);
            }
        }
    }
}
