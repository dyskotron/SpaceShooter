package game.model.gameObject.vo
{
    public class BulletVO extends GameObjectVO
    {
        private var _damage: int;
        private var _mode: uint;
        private var _autoAim: AutoAimVO;
        private var _aoeRadius: Number;
        private var _dmgToCost: Number;
        private var _onHitEffects: Vector.<uint>;

        public function BulletVO(aTypeID: uint, aMode: uint, aAutoAim: AutoAimVO, aDamage: int, aWidth: Number, aHeight: Number, aDmgToCost: Number = 1, aAoeRadius: Number = 0, aOnHitAffixes: Vector.<uint> = null)
        {
            _damage = aDamage;
            _autoAim = aAutoAim;
            _mode = aMode;
            _dmgToCost = aDmgToCost;
            _aoeRadius = aAoeRadius;
            _onHitEffects = aOnHitAffixes;
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

        public function get autoAim(): AutoAimVO
        {
            return _autoAim;
        }

        public function get dmgToCost(): Number
        {
            return _dmgToCost;
        }

        public function get aoeRadius(): Number
        {
            return _aoeRadius;
        }

        public function get onHitEffects(): Vector.<uint>
        {
            return _onHitEffects;
        }
    }
}
