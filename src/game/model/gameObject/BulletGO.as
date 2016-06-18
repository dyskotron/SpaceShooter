package game.model.gameObject
{
    import game.model.gameObject.components.collider.IColliderComponent;
    import game.model.gameObject.components.collider.OnceSquareColliderComponent;
    import game.model.gameObject.components.fsm.ITarget;
    import game.model.gameObject.components.fsm.ITargetProvider;
    import game.model.gameObject.components.fsm.Target;
    import game.model.gameObject.components.weapon.enums.AutoAimMode;
    import game.model.gameObject.vo.BulletVO;

    import starling.utils.MathUtil;

    public class BulletGO extends SimpleMovingGO
    {
        private var _ownerID: uint;
        private var _bulletVO: BulletVO;
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
            super(aBulletVO, aX, aY, aSpeed, aAngle);

            _ownerID = aOwnerID;
            _bulletVO = aBulletVO;
            _speed = aSpeed;
            _angle = aAngle;


            transform.rotation = -_angle;

            //AUTO AIM
            if (bulletVO.autoAim && bulletVO.autoAim.mode != AutoAimMode.NONE)
            {
                _target = aTargetProvider.getTarget(bulletVO.aimTarget, aX, aY, _angle);
                _targetProvider = aTargetProvider;
                if (_target != null)
                {
                    if (bulletVO.autoAim.mode == AutoAimMode.ON_INIT)
                    {
                        _angle = Target.getAngleFromCoords(_target, transform.x, transform.y);
                        movementParams.speedX = _speed * Math.sin(transform.rotation);
                        movementParams.speedY = _speed * Math.cos(transform.rotation);
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
                _angleDelta = Target.getAngleDelta(_target, transform.x, transform.y, _angle);

                if (Math.abs(_angleDelta) < bulletVO.autoAim.maxTriggerAngle)
                {
                    //max delta
                    _maxDelta = bulletVO.autoAim.maxRotation * aDeltaTime / 1000;
                    _angle = _angle + MathUtil.clamp(_angleDelta, -_maxDelta, _maxDelta);

                    movementParams.speedX = _speed * Math.sin(_angle);
                    movementParams.speedY = _speed * Math.cos(_angle);
                    transform.rotation = -_angle;
                }
                else
                {
                    //NEW TARGET
                    _target = _targetProvider.getTarget(bulletVO.aimTarget, transform.x, transform.y, _angle);
                    if (_target == null || Math.abs(Target.getAngleDelta(_target, transform.x, transform.y, _angle)) > bulletVO.autoAim.maxTriggerAngle)
                        _isAutoAim = false;
                }
            }

            super.update(aDeltaTime);
        }

        override protected function createCollider(): IColliderComponent
        {
            return new OnceSquareColliderComponent();
        }
    }
}
