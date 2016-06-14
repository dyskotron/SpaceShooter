package game.view.gameObjectViews
{
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.textures.Texture;

    public class GameObjectAnim extends MovieClip implements IGameObjectView
    {
        private var _hitAnimImpl: HitAnimImpl;


        public function GameObjectAnim(aTextures: Vector.<Texture>, aFps:uint = 12)
        {
            super(aTextures, aFps);
            pivotX = width / 2;
            pivotY = height / 2;
            _hitAnimImpl = new HitAnimImpl(this);
            loop = true;
            play();
            Starling.juggler.add(this);
        }

        public function hitAnim(): void
        {
            _hitAnimImpl.hitAnim();
        }

        public function remove(): void
        {
            if (parent != null)
                parent.removeChild(this);
        }
    }
}
