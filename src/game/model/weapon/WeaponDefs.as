package game.model.weapon
{
    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.def.IBulletDefs;
    import game.model.weapon.enums.EnemyWeaponID;
    import game.model.weapon.enums.PlayerWeaponID;
    import game.model.weapon.enums.WeaponType;

    public class WeaponDefs implements IWeaponDefs
    {
        [Inject]
        public var bulletDefs: IBulletDefs;

        public function WeaponDefs()
        {

        }

        public function getPlayerWeaponModel(aWeaponID: uint): WeaponModel
        {
            var spawnPoints: Vector.<BulletSpawnVO> = new Vector.<BulletSpawnVO>();
            var weaponVO: WeaponModel;

            var spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>> = new Vector.<Vector.<BulletSpawnVO>>();
            var shootIntervalByPower: Vector.<uint> = new Vector.<uint>();

            var bulletX1: Number = 0;
            var bulletX2: Number = 0;
            var bulletX3: Number = 0;

            var bulletY1: Number = 0;
            var bulletY2: Number = 0;
            var bulletY3: Number = 0;


            var aBulletType: uint = 0;


            switch (aWeaponID)
            {
                //region ========= LASER =========
                case PlayerWeaponID.LASER:

                    //common
                    shootIntervalByPower.push(1000 / 5);
                    aBulletType = BulletID.LASER;

                    bulletX1 = 4;
                    bulletX2 = 8;

                    bulletY1 = -30;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, 0, bulletY1, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX2, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, 0, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX2, bulletY1, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, 0, bulletY1, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, 0, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, 0, bulletY1, 0.1, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.1, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.2, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.3, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.3, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.5, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.5, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.7, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.5, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.5, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0.7, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(WeaponType.PARALEL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= PLASMA =========
                case PlayerWeaponID.PLASMA:
                    //common
                    shootIntervalByPower.push(1000 / 3);

                    bulletX1 = 5;
                    bulletX2 = 25;
                    bulletX3 = 45;

                    bulletY1 = -30;
                    bulletY2 = -20;
                    bulletY3 = -10;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX1, bulletY1, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX2, bulletY2, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX2, bulletY2, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX2, bulletY2, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX3, bulletY3, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX2, bulletY2, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX3, bulletY3, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX3, bulletY3, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX2, bulletY2, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX3, bulletY3, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, -bulletX3, bulletY3, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX2, bulletY2, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_1, bulletX3, bulletY3, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX3, bulletY3, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX2, bulletY2, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX3, bulletY3, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, -bulletX3, bulletY3, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, bulletX2, bulletY2, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_2, bulletX3, bulletY3, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, -bulletX3, bulletY3, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, -bulletX2, bulletY2, -0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, bulletX1, bulletY1, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, bulletX2, bulletY2, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(BulletID.PLASMA_3, bulletX3, bulletY3, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(WeaponType.PARALEL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= ELECTRIC =========
                case PlayerWeaponID.ELECTRIC:
                    //common
                    bulletX1 = 3;
                    bulletX2 = 9;

                    bulletY1 = -30;

                    var numShots: Number

                    for (var i: int = 0; i < 10; i++)
                    {
                        spawnPoints = new Vector.<BulletSpawnVO>();
                        aBulletType = i < 5 ? BulletID.ELECTRIC_1 : BulletID.ELECTRIC_2;
                        spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX2, bulletY1, 0, -0.6));
                        //spawnPoints.push(getSpawnVOByPolar(aBulletType, -bulletX1, bulletY1, 0, -0.6));
                        //spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX1, bulletY1, 0, -0.6));
                        spawnPoints.push(getSpawnVOByPolar(aBulletType, bulletX2, bulletY1, 0, -0.6));

                        spawnPointsByPower.push(spawnPoints);
                        numShots = i < 5 ? 7 + (i / 4) * 30 : 20 + ((i - 5) / 4) * 17;

                        trace("_MO_", this, "i", i, "num shots", numShots);
                        shootIntervalByPower.push(1000 / numShots);
                    }

                    for each (var i1: uint in shootIntervalByPower)
                    {
                        trace("_MO_", this, "SHOOT INTERVAL", i1);
                    }

                    weaponVO = new PlayerWeaponModel(WeaponType.SEQUENTIAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion
                default:
                    throw new Error("No Player Weapon for id " + aWeaponID);

            }

            return weaponVO;
        }

        public function getEnemyWeaponModel(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponModel
        {
            var spawnPoints: Vector.<BulletSpawnVO> = new Vector.<BulletSpawnVO>();
            var weaponVO: WeaponModel;


            switch (aWeaponID)
            {
                case EnemyWeaponID.LASER:
                    spawnPoints.push(new BulletSpawnVO(bulletDefs.getBulletVO(bulletType), 8, 40, 0, 0.6));
                    spawnPoints.push(new BulletSpawnVO(bulletDefs.getBulletVO(bulletType), -8, 40, 0, 0.6));
                    weaponVO = new WeaponModel(WeaponType.PARALEL, aShootInterval, spawnPoints);
                    break;

                default:
                    throw new Error("No  Weapon for id " + aWeaponID);

            }

            return weaponVO;
        }

        private function getSpawnVOByPolar(aBulletType: uint, aX: Number, aY: Number, angle: Number, speed: Number = 0.6): BulletSpawnVO
        {
            return new BulletSpawnVO(bulletDefs.getBulletVO(aBulletType), aX, aY, -speed * Math.sin(angle), speed * Math.cos(angle));
        }
    }
}
