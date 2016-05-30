package game.model.weapon
{
    import game.model.gameObject.vo.BulletVO;

    public class PlayerWeaponModel extends WeaponModel
    {
        private var _spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>>;
        private var _shootIntervalByPower: Vector.<uint>;
        private var _bulletVOByPower: Vector.<BulletVO>;

        public function PlayerWeaponModel(aWeaponType: uint, aShootInterval: Vector.<uint>, aSpawnPoints: Vector.<Vector.<BulletSpawnVO>>, aBulletVO: Vector.<BulletVO>)
        {
            _spawnPointsByPower = aSpawnPoints;
            _shootIntervalByPower = aShootInterval;
            _bulletVOByPower = aBulletVO;

            super(aWeaponType, aShootInterval[0], aSpawnPoints[0], aBulletVO[0]);
        }

        public function updatePower(aPower: uint): void
        {
            _spawnPoints = _spawnPointsByPower[Math.min(aPower, _spawnPointsByPower.length - 1)];
            _shootInterval = _shootIntervalByPower[Math.min(aPower, _shootIntervalByPower.length - 1)];
            _bulletVO = _bulletVOByPower[Math.min(aPower, _bulletVOByPower.length - 1)];
        }
    }
}
