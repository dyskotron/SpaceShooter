package game.model.weapon
{
    import game.model.weapon.enums.WeaponType;

    public class PlayerWeaponModel extends WeaponModel
    {
        private var _spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>>;
        private var _shootIntervalByPower: Vector.<uint>;
        private var _power: uint;
        private var _energyCost: Number;


        public function PlayerWeaponModel(aComponentID: uint, aComponentType: uint,aWeaponType: uint, aShootInterval: Vector.<uint>, aSpawnPoints: Vector.<Vector.<BulletSpawnVO>>)
        {
            _spawnPointsByPower = aSpawnPoints;
            _shootIntervalByPower = aShootInterval;

            super(aComponentID, aComponentType, aWeaponType, aShootInterval[0], aSpawnPoints[0]);
        }

        public function get maxPower(): uint
        {
            return Math.max(_spawnPointsByPower.length - 1, _shootIntervalByPower.length - 1);
        }

        public function get power(): uint
        {
            return _power;
        }

        public function get energyCost(): Number
        {
            return _energyCost;
        }

        public function setPower(aPower: uint): void
        {
            _power = Math.min(aPower, maxPower);
            _spawnPoints = _spawnPointsByPower[Math.min(_power, _spawnPointsByPower.length - 1)];
            _shootInterval = _shootIntervalByPower[Math.min(_power, _shootIntervalByPower.length - 1)];

            //count energy cost
            _energyCost = 0;

            switch (weaponType)
            {
                case WeaponType.PARALEL:
                    for (var i: int = 0; i < spawnPoints.length; i++)
                    {
                        _energyCost += spawnPoints[i].bulletVO.damage;
                    }
                    break;
                case WeaponType.SEQUENTIAL:
                    for (var i: int = 0; i < spawnPoints.length; i++)
                    {
                        _energyCost = Math.max(_energyCost, spawnPoints[i].bulletVO.damage);
                    }
                    break;
            }

        }


    }
}
