package game.view.gameObjectViews
{
    import com.greensock.TweenLite;

    import starling.display.Image;
    import starling.textures.Texture;

    public class GameObjectView extends Image
    {
        private var _redTint: Number;

        public function GameObjectView(aTexture: Texture)
        {
            super(aTexture);
            pivotX = width / 2;
            pivotY = height / 2;
        }

        public function hitAnim(): void
        {
            redTint = 1;
            TweenLite.to(this, 0.5, {redTint: 0});
        }

        public function set redTint(aValue: Number): void
        {
            _redTint = aValue;

            if (aValue == 0 && color == 0xFFFFFF)
                return;

            aValue = 1 - aValue * 0.6;
            color = 0xFF << 16 | 0xFF * aValue << 8 | 0xFF * aValue;
        }

        public function get redTint(): Number
        {
            return _redTint;
        }
    }
}
