package game.model.gameObject.vo
{
    import game.model.weapon.WeaponSlot;

    public class EnemyVO extends ShootingVO
    {
        private var _speed: uint;

        public function EnemyVO(aTypeID: uint, aSpeed: uint, aWeapons: Vector.<WeaponSlot>, aInitialHP: Number, aWidth: Number, aHeight: Number)
        {
            _speed = aSpeed;
            super(aTypeID, aWeapons, aInitialHP, aWidth, aHeight);
        }

        public function get speed(): uint
        {
            return _speed;
        }
    }
}
