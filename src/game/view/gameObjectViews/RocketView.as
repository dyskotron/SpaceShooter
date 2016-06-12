package game.view.gameObjectViews
{
    import starling.textures.Texture;

    public class RocketView extends GameObjectAnim
    {
        public function RocketView(aTextures: Vector.<Texture>)
        {
            super(aTextures);

            pivotY = 0;
        }
    }
}
