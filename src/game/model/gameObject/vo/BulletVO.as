package game.model.gameObject.vo
{
    public class BulletVO extends GameObjectVO
    {
        private var _damage: int;
        private var _mode: uint;
        private var _aim: uint;
        private var _aoeDistance: Number;
        private var _dmgToCost: Number;

        public function BulletVO(aTypeID: uint, aMode: uint, aAim: uint, aDamage: int, aWidth: Number, aHeight: Number, aDmgToCost: Number = 1, aAoeDistance: Number = 0)
        {
            _damage = aDamage;
            _aim = aAim;
            _mode = aMode;
            _dmgToCost = aDmgToCost;
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

        public function get aim(): uint
        {
            return _aim;
        }

        public function get dmgToCost(): Number
        {
            return _dmgToCost;
        }

        public function get aoeDistance(): Number
        {
            return _aoeDistance;
        }

    }
}
