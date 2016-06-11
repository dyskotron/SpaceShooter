package game.model.gameObject.components.weapon
{
    import game.model.gameObject.vo.BulletVO;

    public class BulletSpawnVO
    {
        private var _x: Number;
        private var _y: Number;
        private var _speedX: Number;
        private var _speedY: Number;
        private var _bulletVO: BulletVO;

        //orig values storage
        private var _origX: Number;
        private var _origY: Number;
        private var _speed: Number;
        private var _angle: Number;

        public function BulletSpawnVO(aBulletVO: BulletVO, aX: Number, aY: Number, aSpeed: Number = 0, aAngle: Number = 0)
        {
            _bulletVO = aBulletVO;

            _origX = _x = aX;
            _origY = _y = aY;

            _speed = aSpeed;
            _angle = aAngle;

            _speedX = _speed * Math.sin(_angle);
            _speedY = _speed * Math.cos(_angle);
        }

        public function get bulletVO(): BulletVO
        {
            return _bulletVO;
        }

        public function get x(): Number
        {
            return _x;
        }

        public function get y(): Number
        {
            return _y;
        }

        public function get speedX(): Number
        {
            return _speedX;
        }

        public function get speedY(): Number
        {
            return _speedY;
        }

        public function setRotation(aRotation: Number, aOrientation: int): void
        {
            //recalculate position
            _x = (_origX * aOrientation) * Math.cos(aRotation) - _origY * Math.sin(aRotation);
            _y = _origY * Math.cos(aRotation) + (_origX * aOrientation) * Math.sin(aRotation);

            //recalculate direction
            _speedX = _speed * Math.sin(_angle - aRotation);
            _speedY = _speed * Math.cos(_angle - aRotation);
        }
    }
}
