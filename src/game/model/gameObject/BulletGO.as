package game.model.gameObject
{
    import flash.utils.Dictionary;

    import game.model.gameObject.components.weapon.enums.BulletAim;
    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.vo.BulletVO;

    public class BulletGO extends SimpleMovingGO
    {
        private static const AUTO_AIM_INTERVAL: int = 100;

        private var _ownerID: uint;
        private var _bulletVO: BulletVO;
        private var _hittedGO: Dictionary;
        private var _target: ITarget;
        private var _isAutoAim: Boolean;
        private var _hitDistanceSq: Number = Math.pow(30, 2);

        private var _speed: Number = 0;
        private var _angle: Number = 0;
        private var _origAngle: Number = 0;

        //tem vars for update method
        private var _angleDelta: Number = 0;
        private var _lastAimTime: int;

        public function BulletGO(aOwnerID: int, aBulletVO: BulletVO, aX: Number, aY: Number, aSpeed: Number = 0, aAngle: Number = 0, aTarget: ITarget = null)
        {
            super(aBulletVO, aX, aY);

            _ownerID = aOwnerID;
            _bulletVO = aBulletVO;
            _target = aTarget;
            _speed = aSpeed;
            _angle = _origAngle = aAngle;

            speedX = _speed * Math.sin(_angle);
            speedY = _speed * Math.cos(_angle);
            rotation = -_angle;

            if (_bulletVO.mode == BulletMode.EACH_ONCE)
                _hittedGO = new Dictionary();


            _isAutoAim = bulletVO.aim != BulletAim.NONE && _target != null;

            if (_isAutoAim)
            {
                if (bulletVO.aim == BulletAim.ON_INIT)
                {
                    _angle = _target.getAngleFromCoords(x, y);
                    speedX = _speed * Math.sin(rotation);
                    speedY = _speed * Math.cos(rotation);
                    rotation = -_angle;
                }
            }
        }

        public function get bulletVO(): BulletVO
        {
            return _bulletVO;
        }

        public function get ownerID(): uint
        {
            return _ownerID;
        }

        override public function update(aDeltaTime: int): void
        {
            if (_isAutoAim)
            {
                if (_target.getDistanceSq(x, y) < _hitDistanceSq)
                    _isAutoAim = false;

                if (bulletVO.aim == BulletAim.ON_UPDATE || bulletVO.aim == BulletAim.ROUGH)
                {
                    _angleDelta = _target.getAngleDelta(x, y, _origAngle);

                    if (Math.abs(_angleDelta) < Math.PI * 0.5)
                    {
                        _angle = _origAngle + _angleDelta;

                        speedX = _speed * Math.sin(_angle);
                        speedY = _speed * Math.cos(_angle);
                        rotation = -_angle;
                    }
                    else
                    {
                        _isAutoAim = false;
                        //or get new target
                    }

                }

                //if we turned off autoaim get new target

            }

            super.update(aDeltaTime);
        }

        public function canHit(enemyGO: HittableGO): Boolean
        {
            if (_bulletVO.mode == BulletMode.EACH_ONCE && _hittedGO[enemyGO])
                return false;

            return true;
        }

        /**
         * Returns if bullet should be removed after hit or not
         * @param enemyGO
         * @return
         */
        public function hitObject(enemyGO: HittableGO): Boolean
        {
            enemyGO.hit(_bulletVO.damage);

            if (_bulletVO.mode == BulletMode.ONE_SHOT)
                return true;

            if (_bulletVO.mode == BulletMode.EACH_ONCE)
                _hittedGO[enemyGO] = true;

            return false;

        }
    }
}
