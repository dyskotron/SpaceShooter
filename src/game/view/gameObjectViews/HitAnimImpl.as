package game.view.gameObjectViews
{
    import com.greensock.TweenLite;

    public class HitAnimImpl
    {
        private var _goView: IGameObjectView;
        private var _redTint: Number;

        public function HitAnimImpl(aGoView: IGameObjectView)
        {
            _goView = aGoView;
        }

        public function hitAnim(): void
        {
            _redTint = 1;
            TweenLite.to(this, 0.5, {redTint: 0});
        }

        public function set redTint(aValue: Number): void
        {
            _redTint = aValue;

            if (aValue == 0 && _goView.color == 0xFFFFFF)
                return;

            aValue = 1 - aValue * 0.6;
            _goView.color = 0xFF << 16 | 0xFF * aValue << 8 | 0xFF * aValue;
        }

        public function get redTint(): Number
        {
            return _redTint;
        }
    }
}
