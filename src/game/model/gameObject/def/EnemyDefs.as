package game.model.gameObject.def
{
    import common.model.TextureProvider;

    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.constants.EnemyType;
    import game.model.gameObject.vo.EnemyVO;
    import game.model.weapon.IWeaponDefs;
    import game.model.weapon.WeaponModel;
    import game.model.weapon.enums.EnemyWeaponID;

    import org.robotlegs.mvcs.Actor;

    import starling.textures.Texture;

    public class EnemyDefs extends Actor implements IEnemyDefs
    {
        private var _enemyDefByID: Vector.<EnemyVO>;

        public function EnemyDefs(aTextureProvider: TextureProvider, aWeaponDefs: IWeaponDefs)
        {
            _enemyDefByID = new Vector.<EnemyVO>;

            var enemyType: uint;
            var texture: Texture;
            var speed: uint;
            var weaponVO: WeaponModel;
            var hp: int;
            var width: Number;
            var height: Number;

            //FIGHTERS
            texture = aTextureProvider.getEnemyTexture(EnemyType.FIGHTER_1);

            enemyType = EnemyType.FIGHTER_1;
            speed = 200;
            weaponVO = aWeaponDefs.getEnemyWeaponVO(EnemyWeaponID.LASER, 4000, BulletID.LASER);
            width = texture.width * 0.6;
            height = texture.height * 0.6;
            hp = 30;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);

            enemyType = EnemyType.FIGHTER_2;
            weaponVO = aWeaponDefs.getEnemyWeaponVO(EnemyWeaponID.LASER, 3000, BulletID.LASER);
            width = texture.width * 0.65;
            height = texture.height * 0.65;
            hp = 50;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);

            enemyType = EnemyType.FIGHTER_3;
            weaponVO = aWeaponDefs.getEnemyWeaponVO(EnemyWeaponID.LASER, 2000, BulletID.LASER);
            width = texture.width * 0.7;
            height = texture.height * 0.7;
            hp = 80;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);

            enemyType = EnemyType.FIGHTER_4;
            weaponVO = aWeaponDefs.getEnemyWeaponVO(EnemyWeaponID.LASER, 1200, BulletID.LASER);
            width = texture.width * 0.75;
            height = texture.height * 0.75;
            hp = 100;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);


            //KAMIKAZE
            aTextureProvider.getEnemyTexture(EnemyType.KAMIKAZE_1);

            enemyType = EnemyType.KAMIKAZE_1;
            speed = 200;
            weaponVO = null;
            width = texture.width * 0.4;
            height = texture.height * 0.4;
            hp = 40;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);

            enemyType = EnemyType.KAMIKAZE_2;
            weaponVO = null;
            width = texture.width * 0.5;
            height = texture.height * 0.5;
            hp = 60;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);

            //WOBBLY
            aTextureProvider.getEnemyTexture(EnemyType.WOBBLY_1);

            enemyType = EnemyType.WOBBLY_1;
            speed = 250;
            weaponVO = null;
            width = texture.width * 0.6;
            height = texture.height * 0.6;
            hp = 40;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);

            enemyType = EnemyType.WOBBLY_2;
            weaponVO = null;
            width = texture.width * 0.7;
            height = texture.height * 0.7;
            hp = 60;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, speed, weaponVO, hp, width, height);

        }

        public function getEnemyVO(aEnemyType: uint): EnemyVO
        {
            return _enemyDefByID[aEnemyType];
        }
    }
}
