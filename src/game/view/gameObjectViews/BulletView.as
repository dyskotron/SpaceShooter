package game.view.gameObjectViews
{
    import starling.textures.Texture;

    public class BulletView extends GameObjectView
    {

        public function BulletView(texture: Texture)
        {
            super(texture);

            scale = 0.5;
            pivotY = 0;
        }
    }
}
