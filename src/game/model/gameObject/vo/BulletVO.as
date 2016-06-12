package game.model.gameObject.vo
{
    public class BulletVO extends GameObjectVO
    {
        private var _damage: int;
        private var _mode: uint;
        private var _aoeDistance: Number;

        public function BulletVO(aTypeID: uint, aMode: uint, aDamage: int, aWidth: Number, aHeight: Number, aAoeDistance: Number = 0)
        {
            _damage = aDamage;
            _mode = aMode;
            _aoeDistance = aAoeDistance;
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

        public function get aoeDistance(): Number
        {
            return _aoeDistance;
        }
    }
}
