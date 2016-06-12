package game.view.gameObjectViews
{
    import starling.events.Event;
    import starling.textures.Texture;

    public class ExplosionAnim extends GameObjectAnim
    {
        public function ExplosionAnim(aTextures: Vector.<Texture>, aSize: Number)
        {
            super(aTextures, 25);
            width = height = aSize;
            loop = false;
            addEventListener(Event.COMPLETE, movieCompletedHandler);
        }

        private function movieCompletedHandler(event: Event): void
        {
            remove();
        }
    }
}
