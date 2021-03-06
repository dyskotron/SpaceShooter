package common.model
{
    import game.model.gameObject.constants.BonusTypeID;
    import game.model.gameObject.constants.BulletID;
    import game.model.gameObject.constants.EnemyType;
    import game.model.gameObject.constants.ObstacleType;

    import org.robotlegs.mvcs.Actor;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class TextureProvider extends Actor
    {
        public static const PLAYER_SHIP_BASE: String = "playerShip1_";
        public static const PLAYER_LIFE_BASE: String = "playerLife1_";

        [Embed(source='/../assets/background.jpg')]
        private static var bgImage: Class;
        [Embed(source='/../assets/SpaceShooter.png')]
        private static var assetsImage: Class;
        [Embed(source='/../assets/SpaceShooter.xml', mimeType='application/octet-stream')]
        private static var asssetData: Class;

        private var _imageCache: TextureAtlas;
        private var _playerTextureSuffix: Vector.<String>;
        private var _enemyTexture: Vector.<String>;
        private var _bonusTexture: Vector.<String>;
        private var _obstacleTexture: Vector.<String>;

        /**
         * Class keeping track of all textures, providing textures for game objects based on IDs etc
         */
        public function TextureProvider()
        {
            _imageCache = new TextureAtlas(Texture.fromBitmap(new assetsImage()), new XML(new asssetData()));

            _playerTextureSuffix = new Vector.<String>();
            _playerTextureSuffix.push("green");
            _playerTextureSuffix.push("orange");
            _playerTextureSuffix.push("blue");
            _playerTextureSuffix.push("red");

            _enemyTexture = new Vector.<String>(4);
            _enemyTexture[EnemyType.FIGHTER_1] = "enemyBlack1";
            _enemyTexture[EnemyType.FIGHTER_2] = "enemyBlue1";
            _enemyTexture[EnemyType.FIGHTER_3] = "enemyGreen1";
            _enemyTexture[EnemyType.FIGHTER_4] = "enemyRed1";

            _enemyTexture[EnemyType.KAMIKAZE_1] = "enemyBlue5";
            _enemyTexture[EnemyType.KAMIKAZE_2] = "enemyRed5";

            _enemyTexture[EnemyType.WOBBLY_1] = "enemyGreen4";
            _enemyTexture[EnemyType.WOBBLY_2] = "enemyRed4";

            _bonusTexture = new Vector.<String>(3);
            _bonusTexture[BonusTypeID.BONUS_HEALTH] = "pill_red";
            _bonusTexture[BonusTypeID.BONUS_LIFE] = "powerupRed_shield";
            _bonusTexture[BonusTypeID.BONUS_WEAPON] = "powerupRed_bolt";

            _obstacleTexture = new Vector.<String>(3);
            _obstacleTexture[ObstacleType.TINY_1] = "tiny1";
            _obstacleTexture[ObstacleType.TINY_2] = "tiny2";
            _obstacleTexture[ObstacleType.SMALL_1] = "small1";
            _obstacleTexture[ObstacleType.SMALL_2] = "small2";
            _obstacleTexture[ObstacleType.MEDIUM_1] = "med1";
            _obstacleTexture[ObstacleType.MEDIUM_2] = "med3";
            _obstacleTexture[ObstacleType.BIG_1] = "big1";
            _obstacleTexture[ObstacleType.BIG_2] = "big2";
            _obstacleTexture[ObstacleType.BIG_3] = "big3";
            _obstacleTexture[ObstacleType.BIG_4] = "big4";

        }

        public function getPlayerShipTexture(aPlayerID: int): Texture
        {
            return getTexture(PLAYER_SHIP_BASE + _playerTextureSuffix[aPlayerID]);
        }

        public function getPlayerLifeIconTexture(aPlayerID: int): Texture
        {
            return getTexture(PLAYER_LIFE_BASE + _playerTextureSuffix[aPlayerID]);
        }

        public function getWeaponPowerIconTexture(): Texture
        {
            return getTexture("bolt_bronze");
        }

        private function getTexture(aTextureID: String): Texture
        {
            return _imageCache.getTexture(aTextureID/* + ".png"*/);
        }

        private function getTextures(aTexturePrefix: String): Vector.<Texture>
        {
            return _imageCache.getTextures(aTexturePrefix);
        }

        public function getBulletTextures(aBulletID: uint): Vector.<Texture>
        {
            var textures: Vector.<Texture>;
            var texture: Texture;

            //todo graphic for each bullet
            switch (aBulletID)
            {
                case BulletID.LASER_1:
                    texture = getTexture("laserRed03");
                    break;
                case BulletID.LASER_2:
                    texture = getTexture("laserRed02");
                    break;
                case BulletID.LASER_3:
                    texture = getTexture("laserRed06");
                    break;
                case BulletID.LASER_4:
                    texture = getTexture("laserRed04");
                    break;

                case BulletID.PLASMA_1:
                    texture = getTexture("laserGreen05");
                    break;
                case BulletID.PLASMA_2:
                    texture = getTexture("laserGreen04");
                    break;
                case BulletID.PLASMA_3:
                    texture = getTexture("laserGreen12");
                    break;
                case BulletID.PLASMA_4:
                    texture = getTexture("laserGreen08");
                    break;

                case BulletID.ELECTRIC_1:
                    texture = getTexture("laserBlue03");
                    break;
                case BulletID.ELECTRIC_2:
                    texture = getTexture("laserBlue04");
                    break;

                case BulletID.ROCKET_1:
                    textures = getTextures("rocket");
                    break;

                default:
                    throw new Error("No Tetxture for bulletID: " + aBulletID);

            }

            if (textures == null)
            {
                textures = new Vector.<Texture>();
                textures.push(texture);
            }

            return textures;
        }

        public function getExplosionTextures(aExplosionID: uint): Vector.<Texture>
        {
            return getTextures("explosion");
        }

        public function getEnemyTexture(aEnemyID: uint): Texture
        {
            return getTexture(_enemyTexture[aEnemyID]);
        }

        public function getBackroundTexture(): Texture
        {
            return Texture.fromBitmap(new bgImage(), true, false, 1, "bgra", true);
        }

        public function getObstacleTexture(aObstacleID: uint): Texture
        {
            return getTexture("meteorBrown_" + _obstacleTexture[aObstacleID]);
        }

        public function getBonusTexture(aBonusID: uint): Texture
        {
            return getTexture(_bonusTexture[aBonusID]);
        }
    }
}
