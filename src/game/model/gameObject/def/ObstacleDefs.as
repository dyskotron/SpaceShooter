package game.model.gameObject.def
{
    import common.model.TextureProvider;

    import game.model.gameObject.constants.ObstacleType;
    import game.model.gameObject.vo.ObstacleVO;

    import org.robotlegs.mvcs.Actor;

    import starling.textures.Texture;

    public class ObstacleDefs extends Actor implements IObstacleDefs
    {
        private var _obstacleDefByID: Vector.<ObstacleVO>;

        public function ObstacleDefs(aTextureProvider: TextureProvider)
        {
            _obstacleDefByID = new Vector.<ObstacleVO>;

            var obstacleType: uint;
            var texture: Texture;
            var hp: int;
            var width: Number;
            var height: Number;

            obstacleType = ObstacleType.TINY_1;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 30;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.TINY_2;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 30;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.SMALL_1;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 80;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.SMALL_2;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 80;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.MEDIUM_1;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 120;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.MEDIUM_2;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 120;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.BIG_1;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 250;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.BIG_2;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 250;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.BIG_3;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 250;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

            obstacleType = ObstacleType.BIG_4;
            texture = aTextureProvider.getObstacleTexture(obstacleType);
            width = texture.width;
            height = texture.height;
            hp = 250;
            _obstacleDefByID[obstacleType] = new ObstacleVO(obstacleType, hp, width, height);

        }

        public function getObstacleVO(aObstacleType: uint): ObstacleVO
        {
            return _obstacleDefByID[aObstacleType];
        }
    }
}
