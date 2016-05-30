package game.model.weapon
{
    import game.model.gameObject.def.IBulletDefs;
    import game.model.gameObject.vo.BulletVO;

    public class WeaponDefs implements IWeaponDefs
    {
        [Inject]
        public var bulletDefs: IBulletDefs;

        public function WeaponDefs()
        {

        }

        public function getWeaponVO(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponModel
        {
            var spawnPoints: Vector.<BulletSpawnVO> = new Vector.<BulletSpawnVO>();
            var weaponVO: WeaponModel;


            switch (aWeaponID)
            {
                case WeaponID.PLAYER_WEAPON:
                    var spawnPointsByPower: Vector.<Vector.<BulletSpawnVO>> = new Vector.<Vector.<BulletSpawnVO>>();
                    var shootIntervalByPower: Vector.<uint> = new Vector.<uint>();
                    var bulletVOByPower: Vector.<BulletVO> = new Vector.<BulletVO>();

                    //0
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(0, -40, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //1
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //2
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(-8, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(0, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(8, -40, 0, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //3
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(0, -40, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(0, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(0, -40, 0.1, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //4
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.1, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //5
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.2, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //6
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.3, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //7
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.3, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    //8
                    spawnPoints = new Vector.<BulletSpawnVO>();
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.5, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, -0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(-4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.1, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.2, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.3, -0.6));
                    spawnPoints.push(getSpawnVOByPolar(4, -40, 0.5, -0.6));
                    spawnPointsByPower.push(spawnPoints);

                    shootIntervalByPower.push(aShootInterval);

                    bulletVOByPower.push(bulletDefs.getBulletVO(bulletType));

                    weaponVO = new PlayerWeaponModel(aWeaponID, shootIntervalByPower, spawnPointsByPower, bulletVOByPower);
                    break;
                case WeaponID.ENEMY_WEAPON:
                    spawnPoints.push(new BulletSpawnVO(8, 40, 0, 0.6));
                    spawnPoints.push(new BulletSpawnVO(-8, 40, 0, 0.6));
                    weaponVO = new WeaponModel(aWeaponID, aShootInterval, spawnPoints, bulletDefs.getBulletVO(bulletType));
                    break;

                default:
                    throw new Error("No  Weapon for id " + aWeaponID);

            }

            return weaponVO;
        }

        private function getSpawnVOByPolar(aX: Number, aY: Number, angle: Number, speed: Number = 0.6): BulletSpawnVO
        {
            return new BulletSpawnVO(aX, aY, -speed * Math.sin(angle), speed * Math.cos(angle));
        }
    }
}
