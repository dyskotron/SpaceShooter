package game.model.gameObject.vo
{
    public class HittableVO extends GameObjectVO
    {
        private var _initialHP: int;

        public function HittableVO(aTypeID: uint, aInitialHP: int, aWidth: Number, aHeight: Number)
        {
            _initialHP = aInitialHP;
            super(aTypeID, aWidth, aHeight);
        }

        public function get initialHP(): int
        {
            return _initialHP;
        }
    }
}
