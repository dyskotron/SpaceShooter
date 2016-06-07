package game.model.gameObject.components.weapon
{
    import game.model.gameObject.components.ComponentType;
    import game.model.gameObject.components.weapon.enums.EnemyWeaponID;
    import game.model.gameObject.components.weapon.enums.PlayerWeaponID;
    import game.model.gameObject.components.weapon.enums.WeaponType;
    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.def.IBulletDefs;

    public class WeaponDefs implements IWeaponDefs
    {
        [Inject]
        public var bulletDefs: IBulletDefs;


        private static const ELECTRIC_1_BASE_NUMSHOTS: Number = 3;
        private static const ELECTRIC_2_BASE_NUMSHOTS: Number = 11.4;

        public function WeaponDefs()
        {

        }

        public function getMainWeaponModel(aWeaponID: uint): WeaponModel
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

            var speed: Number = 0;


            var aBulletType: uint = 0;


            switch (aWeaponID)
            {
                //region ========= LASER =========
                case PlayerWeaponID.LASER:

                    //common
                    shootIntervalByPower.push(1000 / 5);
                    aBulletType = BulletID.LASER_1;


                    bulletX1 = 4;
                    bulletX2 = 8;

                    bulletY1 = -30;
                    speed = -0.6;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX2, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX2, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX2, bulletY1, 0.1, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX2, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX2, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX2, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX2, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0.3, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0.4, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, bulletX1, bulletY1, 0.4, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.5, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.5, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.5, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.5, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.PARALEL, shootIntervalByPower, spawnPointsByPower);
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

                    speed = -0.5;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.PARALEL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= ELECTRIC =========
                case PlayerWeaponID.ELECTRIC:
                    //common
                    bulletX1 = 9;
                    speed = -0.7;

                    var numShots: Number;

                    for (var i: int = 0; i < 10; i++)
                    {
                        if (i < 5)
                        {
                            aBulletType = BulletID.ELECTRIC_1;
                            numShots = ELECTRIC_1_BASE_NUMSHOTS * Math.pow(1.5, i);
                        }
                        else
                        {
                            aBulletType = BulletID.ELECTRIC_2;
                            numShots = ELECTRIC_2_BASE_NUMSHOTS * Math.pow(1.5, i - 5);
                        }

                        spawnPoints = new Vector.<BulletSpawnVO>();
                        spawnPoints.push(getSpawnVO(aBulletType, -bulletX1, bulletY1, 0, speed));
                        spawnPoints.push(getSpawnVO(aBulletType, bulletX1, bulletY1, 0, speed));
                        spawnPointsByPower.push(spawnPoints);


                        trace("_MO_", this, "MAIN-GUN:", i, "num shots", numShots);
                        shootIntervalByPower.push(1000 / numShots);
                    }

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.SEQUENTIAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion
                default:
                    throw new Error("No Player Weapon for id " + aWeaponID);

            }

            return weaponVO;
        }

        public function getSeconaryWeaponModel(aWeaponID: uint): WeaponModel
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

            var speed: Number = 0;


            var aBulletType: uint = 0;


            switch (aWeaponID)
            {
                //region ========= LASER =========
                case PlayerWeaponID.LASER:

                    //common
                    shootIntervalByPower.push(1000 / 5);

                    bulletX1 = 4;
                    bulletX2 = 8;

                    bulletY1 = -30;
                    speed = -0.6;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0.1, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.1, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.SECONDARY_GUN, WeaponType.PARALEL, shootIntervalByPower, spawnPointsByPower);
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

                    speed = -0.5;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.SECONDARY_GUN, WeaponType.PARALEL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= ELECTRIC =========
                case PlayerWeaponID.ELECTRIC:
                    //common
                    bulletX1 = 2;
                    speed = -0.7;

                    var numShots: Number;

                    for (var i: int = 0; i < 10; i++)
                    {
                        if (i < 5)
                        {
                            aBulletType = BulletID.ELECTRIC_1;
                            numShots = ELECTRIC_1_BASE_NUMSHOTS / 3 * Math.pow(1.5, i);
                        }
                        else
                        {
                            aBulletType = BulletID.ELECTRIC_2;
                            numShots = ELECTRIC_2_BASE_NUMSHOTS / 3 * Math.pow(1.5, i - 5);
                        }

                        spawnPoints = new Vector.<BulletSpawnVO>();
                        spawnPoints.push(getSpawnVO(aBulletType, -bulletX1, bulletY1, 0, speed));
                        spawnPoints.push(getSpawnVO(aBulletType, bulletX1, bulletY1, 0, speed));
                        spawnPointsByPower.push(spawnPoints);


                        trace("_MO_", this, "MAIN-GUN:", i, "num shots", numShots);
                        shootIntervalByPower.push(1000 / numShots);
                    }

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.SECONDARY_GUN, WeaponType.SEQUENTIAL, shootIntervalByPower, spawnPointsByPower);
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
                    weaponVO = new WeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.PARALEL, aShootInterval, spawnPoints);
                    break;

                default:
                    throw new Error("No  Weapon for id " + aWeaponID);

            }

            return weaponVO;
        }

        /**
         * Creates BulletSpawnVO, takes polar coordinates
         * @param aBulletType
         * @param aX
         * @param aY
         * @param angle
         * @param speed
         * @return
         */
        private function getSpawnVO(aBulletType: uint, aX: Number, aY: Number, angle: Number, speed: Number = 0.6): BulletSpawnVO
        {
            return new BulletSpawnVO(bulletDefs.getBulletVO(aBulletType), aX, aY, -speed * Math.sin(angle), speed * Math.cos(angle));
        }
    }
}
