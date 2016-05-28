package game.model.weapon
{
    import game.model.gameObject.def.IBulletDefs;

    public class WeaponDefs implements IWeaponDefs
    {
        [Inject]
        public var bulletDefs: IBulletDefs;

        public function WeaponDefs()
        {

        }

        public function getWeaponVO(aWeaponID: uint, aShootInterval: uint, bulletType: uint): WeaponVO
        {
            var spawnPoints: Vector.<BulletSpawnVO> = new Vector.<BulletSpawnVO>();
            var weaponVO: WeaponVO;


            switch (aWeaponID)
            {
                case WeaponID.PLAYER_WEAPON:
                    spawnPoints.push(new BulletSpawnVO(0, -40, 0, -0.6));
                    weaponVO = new WeaponVO(aWeaponID, aShootInterval, spawnPoints, bulletDefs.getBulletVO(bulletType));
                    break;
                case WeaponID.ENEMY_WEAPON:
                    spawnPoints.push(new BulletSpawnVO(0, 40, 0, 0.6));
                    weaponVO = new WeaponVO(aWeaponID, aShootInterval, spawnPoints, bulletDefs.getBulletVO(bulletType));
                    break;

                default:
                    throw new Error("No  Weapon for id " + aWeaponID);

            }

            return weaponVO;
        }
    }
}
