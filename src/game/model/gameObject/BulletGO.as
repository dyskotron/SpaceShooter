package game.model.gameObject
{
    import flash.utils.Dictionary;

    import game.model.gameObject.components.weapon.enums.AutoAimMode;
    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.BulletVO;

    import starling.utils.MathUtil;

    public class BulletGO extends SimpleMovingGO
    {
        private var _ownerID: uint;
        private var _bulletVO: BulletVO;
        private var _hittedGO: Dictionary;
        private var _target: ITarget;
        private var _targetProvider: ITargetProvider;
        private var _isAutoAim: Boolean;

        private var _speed: Number = 0;
        private var _angle: Number = 0;

        //temp vars for update method
        private var _angleDelta: Number = 0;
        private var _maxDelta: Number = 0;

        public function BulletGO(aOwnerID: int, aBulletVO: BulletVO, aX: Number, aY: Number, aSpeed: Number = 0, aAngle: Number = 0, aTargetProvider: ITargetProvider = null)
        {
            super(aBulletVO, aX, aY);

            _ownerID = aOwnerID;
            _bulletVO = aBulletVO;
            _speed = aSpeed;
            _angle = aAngle;

            transform.speedX = _speed * Math.sin(_angle);
            transform.speedY = _speed * Math.cos(_angle);
            transform.rotation = -_angle;

            if (_bulletVO.mode == BulletMode.EACH_ONCE)
                _hittedGO = new Dictionary();


            //AUTO AIM
            if (bulletVO.autoAim && bulletVO.autoAim.mode != AutoAimMode.NONE)
            {
                _target = aTargetProvider.getTarget(bulletVO.aimTarget, aX, aY, _angle);
                _targetProvider = aTargetProvider;
                if (_target != null)
                {
                    if (bulletVO.autoAim.mode == AutoAimMode.ON_INIT)
                    {
                        _angle = _target.getAngleFromCoords(transform.x, transform.y);
                        transform.speedX = _speed * Math.sin(transform.rotation);
                        transform.speedY = _speed * Math.cos(transform.rotation);
                        transform.rotation = -_angle;
                    }

                    _isAutoAim = true;
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
            //AUTO AIM
            if (_isAutoAim && bulletVO.autoAim.mode == AutoAimMode.ON_UPDATE)
            {
                _angleDelta = _target.getAngleDelta(transform.x, transform.y, _angle);

                if (Math.abs(_angleDelta) < bulletVO.autoAim.maxTriggerAngle)
                {
                    //max delta
                    _maxDelta = bulletVO.autoAim.maxRotation * aDeltaTime / 1000;
                    _angle = _angle + MathUtil.clamp(_angleDelta, -_maxDelta, _maxDelta);

                    transform.speedX = _speed * Math.sin(_angle);
                    transform.speedY = _speed * Math.cos(_angle);
                    transform.rotation = -_angle;
                }
                else
                {
                    //NEW TARGET
                    _target = _targetProvider.getTarget(bulletVO.aimTarget, transform.x, transform.y, _angle);
                    if (_target == null || Math.abs(_target.getAngleDelta(transform.x, transform.y, _angle)) > bulletVO.autoAim.maxTriggerAngle)
                        _isAutoAim = false;
                }
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
         * Hits object and Returns if bullet should be removed after hit or not
         * @param hittableGO
         * @return
         */
        public function hitObject(hittableGO: HittableGO): Boolean
        {
            hittableGO.hit(_bulletVO.damage);

            if (_bulletVO.mode == BulletMode.ONE_SHOT)
                return true;

            if (_bulletVO.mode == BulletMode.EACH_ONCE)
                _hittedGO[hittableGO] = true;

            return false;

        }
    }
}
