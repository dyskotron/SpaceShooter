package game.model.gameObject.vo
{
    public class BulletVO extends GameObjectVO
    {
        private var _damage: int;

        public function BulletVO(aTypeID: uint, aDamage: int, aWidth: Number, aHeight: Number)
        {
            _damage = aDamage;
            super(aTypeID, aWidth, aHeight);
        }

        public function get damage(): int
        {
            return _damage;
        }
    }
}
