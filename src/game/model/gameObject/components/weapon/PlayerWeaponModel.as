package game.model.gameObject.components.weapon
{
    import game.model.gameObject.components.weapon.enums.WeaponType;

    import starling.utils.MathUtil;

    public class PlayerWeaponModel extends WeaponModel
    {
        private var _spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>>;
        private var _shootIntervalByPower: Vector.<uint>;
        private var _power: uint;
        private var _energyCost: Number;


        public function PlayerWeaponModel(aComponentID: uint, aComponentType: uint, aWeaponType: uint, aWeaponGroup: uint, aShootInterval: Vector.<uint>, aSpawnPoints: Vector.<Vector.<BulletSpawnVO>>)
        {
            _spawnPointsByPower = aSpawnPoints;
            _shootIntervalByPower = aShootInterval;

            super(aComponentID, aComponentType, aWeaponType, aWeaponGroup, aShootInterval[0], aSpawnPoints[0]);
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
            _power = MathUtil.clamp(aPower, 0, maxPower);
            _spawnPoints = _spawnPointsByPower[Math.min(_power, _spawnPointsByPower.length - 1)];
            _shootInterval = _shootIntervalByPower[Math.min(_power, _shootIntervalByPower.length - 1)];

            //count energy cost
            _energyCost = 0;
            var i: int;
            switch (weaponType)
            {

                case WeaponType.SINGLE:
                    _energyCost += spawnPoints[0].bulletVO.damage * spawnPoints[0].bulletVO.dmgToCost;
                    break;
                case WeaponType.PARALEL:
                    //total cost
                    for (i = 0; i < spawnPoints.length; i++)
                    {
                        _energyCost += spawnPoints[i].bulletVO.damage * spawnPoints[i].bulletVO.dmgToCost;
                    }
                    break;
                case WeaponType.RANDOM:
                case WeaponType.SEQUENTIAL:
                    //find bullet with biggest cost
                    for (i = 0; i < spawnPoints.length; i++)
                    {
                        _energyCost = Math.max(_energyCost, spawnPoints[i].bulletVO.damage * spawnPoints[i].bulletVO.dmgToCost);
                    }
                    break;
            }
        }

        override public function rotate(aRotation: Number, aOrientation: int)
        {
            //recalculate all VOs:
            var spawnPoints: Vector.<BulletSpawnVO>;
            for (var iP: int = 0; iP < _spawnPointsByPower.length; iP++)
            {
                spawnPoints = _spawnPointsByPower[iP];
                for (var iS: int = 0; iS < spawnPoints.length; iS++)
                {
                    spawnPoints[iS].setRotation(aRotation, aOrientation);
                }
            }
        }
    }
}
