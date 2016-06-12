package game.view.gameObjectViews
{
    import starling.display.Image;
    import starling.textures.Texture;

    public class GameObjectView extends Image implements IGameObjectView
    {
        private var _hitanimImpl: HitAnimImpl;


        public function GameObjectView(aTexture: Texture)
        {
            super(aTexture);
            pivotX = width / 2;
            pivotY = height / 2;
            _hitanimImpl = new HitAnimImpl(this);
        }

        public function hitAnim(): void
        {
            _hitanimImpl.hitAnim();
        }

        public function remove(): void
        {
            if (parent != null)
                parent.removeChild(this);
        }
    }
}
