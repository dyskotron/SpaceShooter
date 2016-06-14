package game.model.gameObject
{
    import flash.utils.Dictionary;

    import game.model.gameObject.components.weapon.enums.BulletAim;
    import game.model.gameObject.constants.BulletMode;
    import game.model.gameObject.fsm.ITarget;
    import game.model.gameObject.fsm.ITargetProvider;
    import game.model.gameObject.vo.BulletVO;

    import starling.utils.MathUtil;

    public class BulletGO extends SimpleMovingGO
    {
        private static const AUTO_AIM_MAX_TRIGGER_ANGLE: Number = Math.PI / 4;
        //private static const AUTO_AIM_MAX_ANGLE: Number = Math.PI * AUTO_AIM_MAX_TRIGGER_ANGLE * 2;
        private static const AUTO_AIM_MAX_DELTA_PER_S: Number = Math.PI;

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
        //private var _angleDeltaToOrig: Number = 0;

        public function BulletGO(aOwnerID: int, aBulletVO: BulletVO, aX: Number, aY: Number, aSpeed: Number = 0, aAngle: Number = 0, aTargetProvider: ITargetProvider = null)
        {
            super(aBulletVO, aX, aY);

            _ownerID = aOwnerID;
            _bulletVO = aBulletVO;
            _speed = aSpeed;
            _angle = aAngle;

            speedX = _speed * Math.sin(_angle);
            speedY = _speed * Math.cos(_angle);
            rotation = -_angle;

            if (_bulletVO.mode == BulletMode.EACH_ONCE)
                _hittedGO = new Dictionary();


            //AUTO AIM
            if (bulletVO.aim != BulletAim.NONE)
            {
                _target = aTargetProvider.getTarget(bulletVO.aimTarget, aX, aY, _angle);
                _targetProvider = aTargetProvider;
                if (_target != null)
                {
                    if (bulletVO.aim == BulletAim.ON_INIT)
                    {
                        _angle = _target.getAngleFromCoords(x, y);
                        speedX = _speed * Math.sin(rotation);
                        speedY = _speed * Math.cos(rotation);
                        rotation = -_angle;
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
            if (_isAutoAim && bulletVO.aim == BulletAim.ON_UPDATE)
            {
                _angleDelta = _target.getAngleDelta(x, y, _angle);

                if (Math.abs(_angleDelta) < AUTO_AIM_MAX_TRIGGER_ANGLE)
                {
                    //max delta
                    _maxDelta = AUTO_AIM_MAX_DELTA_PER_S * aDeltaTime / 1000;
                    _angle = _angle + MathUtil.clamp(_angleDelta, -_maxDelta, _maxDelta);

                    /**
                     //global max angle
                     _angleDeltaToOrig = _angle - _origAngle;
                     _angleDeltaToOrig = MathUtil.clamp(_angleDeltaToOrig, -AUTO_AIM_MAX_ANGLE, AUTO_AIM_MAX_ANGLE)
                     _angle = _origAngle + _angleDeltaToOrig;
                     */

                    speedX = _speed * Math.sin(_angle);
                    speedY = _speed * Math.cos(_angle);
                    rotation = -_angle;
                }
                else
                {
                    //NEW TARGET
                    _target = _targetProvider.getTarget(bulletVO.aimTarget, x, y, _angle);
                    if (_target == null || Math.abs(_target.getAngleDelta(x, y, _angle)) > AUTO_AIM_MAX_TRIGGER_ANGLE)
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
