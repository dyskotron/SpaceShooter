package game.model.gameObject.component.weapon
{
    import game.model.gameObject.component.ComponentType;
    import game.model.gameObject.component.weapon.enums.EnemyWeaponID;
    import game.model.gameObject.component.weapon.enums.PlayerWeaponID;
    import game.model.gameObject.component.weapon.enums.WeaponGroup;
    import game.model.gameObject.component.weapon.enums.WeaponType;
    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.def.IBulletDefs;

    public class WeaponDefs implements IWeaponDefs
    {
        public static const LASER_SPEED: Number = 800;
        public static const PLASMA_SPEED: Number = 500;
        public static const ELECTRIC_SPEED: Number = 1000;
        public static const ROCKET_SPEED: Number = 650;

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
            var shootIntervalByPower: Vector.<Number> = new Vector.<Number>();

            var bulletX1: Number = 0;
            var bulletX2: Number = 0;
            var bulletX3: Number = 0;
            var bulletX4: Number = 0;

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
                    shootIntervalByPower.push(1 / 5);
                    aBulletType = BulletID.LASER_1;


                    bulletX1 = 4;
                    bulletX2 = 8;

                    bulletY1 = 30;
                    speed = LASER_SPEED;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX2, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX2, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX2, bulletY1, 0.1, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX2, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX2, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX2, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX2, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX2, bulletY1, 0.2, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.3, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.4, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_2, bulletX1, bulletY1, 0.4, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.5, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, bulletX1, bulletY1, 0.5, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.5, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, -0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.3, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.4, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, bulletX1, bulletY1, 0.5, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.PARALEL, WeaponGroup.NORMAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= PLASMA =========
                case PlayerWeaponID.PLASMA:
                    //common
                    shootIntervalByPower.push(1 / 3);

                    bulletX1 = 5;
                    bulletX2 = 18;
                    bulletX3 = 32;
                    bulletX4 = 45;

                    bulletY1 = 30;
                    bulletY2 = 20;
                    bulletY3 = 10;

                    speed = PLASMA_SPEED;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, 0, bulletY1, 0, speed));
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
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -bulletX4, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX3, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX4, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    var dist: Number = bulletX3 / 6;
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, -dist * 6, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, -dist * 5, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -dist * 4, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -dist * 3, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -dist * 2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, -dist, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, dist, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, dist * 2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, dist * 3, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, dist * 4, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, dist * 5, bulletY3, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, dist * 6, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.PARALEL, WeaponGroup.NORMAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= ELECTRIC =========
                case PlayerWeaponID.ELECTRIC:
                    //common
                    bulletX1 = 9;
                    speed = ELECTRIC_SPEED;

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


                        shootIntervalByPower.push(1 / numShots);
                    }

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.SEQUENTIAL, WeaponGroup.NORMAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion
                default:
                    throw new Error("No Player Weapon for id " + aWeaponID);

            }

            return weaponVO;
        }

        public function getSecondaryWeaponModel(aWeaponID: uint): WeaponModel
        {
            var spawnPoints: Vector.<BulletSpawnVO> = new Vector.<BulletSpawnVO>();
            var weaponVO: WeaponModel;

            var spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>> = new Vector.<Vector.<BulletSpawnVO>>();
            var shootIntervalByPower: Vector.<Number> = new Vector.<Number>();

            var bulletX1: Number = 0;
            var bulletX2: Number = 0;
            var bulletX3: Number = 0;

            var bulletY1: Number = 0;
            var bulletY2: Number = 0;
            var bulletY3: Number = 0;

            var speed: Number = 0;

            var numShots: Number = 0;

            var aBulletType: uint = 0;

            var i: int;


            switch (aWeaponID)
            {
                //region ========= LASER =========
                case PlayerWeaponID.LASER:

                    //common
                    shootIntervalByPower.push(1 / 5);

                    bulletX1 = 4;
                    bulletX2 = 8;

                    bulletY1 = 30;
                    speed = LASER_SPEED;

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
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.3, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_3, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.3, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.1, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.2, speed));
                    spawnPoints.push(getSpawnVO(BulletID.LASER_4, 0, bulletY1, 0.3, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.SECONDARY_GUN, WeaponType.PARALEL, WeaponGroup.NORMAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= PLASMA =========
                case PlayerWeaponID.PLASMA:
                    //common
                    shootIntervalByPower.push(1 / 3);

                    bulletX1 = 10;
                    bulletX2 = 20;
                    bulletX3 = 30;

                    bulletY1 = 30;
                    bulletY2 = 20;
                    bulletY3 = 10;

                    speed = PLASMA_SPEED;

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_1, 0, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, 0, bulletY1, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_1, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY2, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_1, bulletX2, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_1, bulletX1, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_1, bulletX2, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX1, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_2, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_1, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //9
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX3, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);
                    //10
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, 0, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX1, bulletY1, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_4, bulletX2, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_3, bulletX3, bulletY2, 0, speed));
                    spawnPoints.push(getSpawnVO(BulletID.PLASMA_1, bulletX3 + 10, bulletY3, 0, speed));
                    spawnPointsByPower.push(spawnPoints);

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.SECONDARY_GUN, WeaponType.PARALEL, WeaponGroup.NORMAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= ELECTRIC =========
                case PlayerWeaponID.ELECTRIC:
                    //common
                    bulletX1 = 2;
                    speed = ELECTRIC_SPEED;

                    for (i = 0; i < 10; i++)
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


                        shootIntervalByPower.push(1 / numShots);
                    }

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.SECONDARY_GUN, WeaponType.SEQUENTIAL, WeaponGroup.NORMAL, shootIntervalByPower, spawnPointsByPower);
                    break;
                //endregion

                //region ========= ROCKET LAUNCHER =========
                case PlayerWeaponID.ROCKET_LAUNCHER:
                    //common
                    speed = ROCKET_SPEED;

                    numShots = 50;

                    for (i = 0; i < 10; i++)
                    {
                        spawnPoints = new Vector.<BulletSpawnVO>();
                        spawnPoints.push(getSpawnVO(BulletID.ROCKET_1, 0, bulletY1, 0, speed));
                        spawnPointsByPower.push(spawnPoints);


                        shootIntervalByPower.push(1 / numShots);
                    }

                    weaponVO = new PlayerWeaponModel(aWeaponID, ComponentType.SECONDARY_GUN, WeaponType.SINGLE, WeaponGroup.CHARGE, shootIntervalByPower, spawnPointsByPower);
                    break;

                default:
                    throw new Error("No Player Weapon for id " + aWeaponID);

            }

            //endregion

            return weaponVO;
        }

        public function getEnemyWeaponModel(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponModel
        {
            var spawnPoints: Vector.<BulletSpawnVO> = new Vector.<BulletSpawnVO>();
            var weaponVO: WeaponModel;

            switch (aWeaponID)
            {
                case EnemyWeaponID.LASER:
                    spawnPoints.push(new BulletSpawnVO(bulletDefs.getBulletVO(bulletType), 8, 40, 600, 0));
                    spawnPoints.push(new BulletSpawnVO(bulletDefs.getBulletVO(bulletType), -8, 40, 600, 0));
                    weaponVO = new WeaponModel(aWeaponID, ComponentType.MAIN_GUN, WeaponType.PARALEL, WeaponGroup.NORMAL, aShootInterval, spawnPoints);
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
        private function getSpawnVO(aBulletType: uint, aX: Number, aY: Number, angle: Number, speed: Number): BulletSpawnVO
        {
            return new BulletSpawnVO(bulletDefs.getBulletVO(aBulletType), aX, aY, speed, angle);
        }
    }
}
