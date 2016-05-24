package game.model.gameObject.def
{
    import common.model.TextureProvider;

    import game.model.gameObject.constants.BulletType;
    import game.model.gameObject.constants.EnemyType;
    import game.model.gameObject.vo.EnemyVO;

    import org.robotlegs.mvcs.Actor;

    import starling.textures.Texture;

    public class EnemyDefs extends Actor implements IEnemyDefs
    {
        private var _enemyDefByID: Vector.<EnemyVO>;

        public function EnemyDefs(aTextureProvider: TextureProvider, aBehaviourDefs: IBehaviorFactory)
        {
            _enemyDefByID = new Vector.<EnemyVO>;

            var enemyType: uint;
            var texture: Texture;
            var bulletType: uint;
            var shootInterval: int;
            var hp: int;
            var width: Number;
            var height: Number;

            //FIGHTERS
            texture = aTextureProvider.getEnemyTexture(EnemyType.FIGHTER_1);

            enemyType = EnemyType.FIGHTER_1;
            bulletType = BulletType.LASER;
            shootInterval = 4000;
            width = texture.width * 0.6;
            height = texture.height * 0.6;
            hp = 30;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);

            enemyType = EnemyType.FIGHTER_2;
            bulletType = BulletType.LASER;
            shootInterval = 3000;
            width = texture.width * 0.65;
            height = texture.height * 0.65;
            hp = 50;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);

            enemyType = EnemyType.FIGHTER_3;
            bulletType = BulletType.LASER;
            shootInterval = 1500;
            width = texture.width * 0.7;
            height = texture.height * 0.7;
            hp = 80;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);

            enemyType = EnemyType.FIGHTER_4;
            bulletType = BulletType.LASER;
            shootInterval = 1000;
            width = texture.width * 0.75;
            height = texture.height * 0.75;
            hp = 100;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);


            //KAMIKAZE
            aTextureProvider.getEnemyTexture(EnemyType.KAMIKAZE_1);

            enemyType = EnemyType.KAMIKAZE_1;
            bulletType = BulletType.NONE;
            shootInterval = 0;
            width = texture.width * 0.4;
            height = texture.height * 0.4;
            hp = 40;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);

            enemyType = EnemyType.KAMIKAZE_2;
            bulletType = BulletType.NONE;
            shootInterval = 0;
            width = texture.width * 0.5;
            height = texture.height * 0.5;
            hp = 60;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);

            //WOBBLY
            aTextureProvider.getEnemyTexture(EnemyType.WOBBLY_1);

            enemyType = EnemyType.WOBBLY_1;
            bulletType = BulletType.NONE;
            shootInterval = 0;
            width = texture.width * 0.6;
            height = texture.height * 0.6;
            hp = 40;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);

            enemyType = EnemyType.WOBBLY_2;
            bulletType = BulletType.NONE;
            shootInterval = 0;
            width = texture.width * 0.7;
            height = texture.height * 0.7;
            hp = 60;
            _enemyDefByID[enemyType] = new EnemyVO(enemyType, bulletType, shootInterval, hp, width, height);

        }

        public function getEnemyVO(aEnemyType: uint): EnemyVO
        {
            return _enemyDefByID[aEnemyType];
        }
    }
}
