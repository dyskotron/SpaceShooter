package game.model.gameObject.vo
{
    public class BulletVO extends GameObjectVO
    {
        private var _damage: int;
        private var _mode: uint;

        public function BulletVO(aTypeID: uint, aMode: uint, aDamage: int, aWidth: Number, aHeight: Number)
        {
            _damage = aDamage;
            _mode = aMode;
            super(aTypeID, aWidth, aHeight);
        }

        public function get damage(): int
        {
            return _damage;
        }

        public function get mode(): uint
        {
            return _mode;
        }
    }
}
