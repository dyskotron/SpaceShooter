package game.model.weapon
{
    import game.model.gameObject.vo.BulletVO;

    public class WeaponVO
    {
        /**
         * Spawn points + directions
         * bullet type
         * weapon type - sequence / all at once
         */

        private var _weaponType: uint = 0;
        private var _spawnPoints: Vector.<BulletSpawnVO>;
        private var _shootInterval: int;
        private var _bulletVO: BulletVO;

        public function WeaponVO(aWeaponType: uint, aShootInterval: uint, aSpawnPoints: Vector.<BulletSpawnVO>, aBulletVO: BulletVO)
        {
            _weaponType = aWeaponType;
            _shootInterval = aShootInterval;
            _spawnPoints = aSpawnPoints;
            _bulletVO = aBulletVO;
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

        public function get bulletVO(): BulletVO
        {
            return _bulletVO;
        }
    }
}
