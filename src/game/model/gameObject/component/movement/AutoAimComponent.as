package game.model.gameObject.component.movement
{
    import game.model.GameObject;
    import game.model.gameObject.component.Component;
    import game.model.gameObject.component.fsm.ITarget;
    import game.model.gameObject.component.fsm.ITargetProvider;
    import game.model.gameObject.component.fsm.Target;
    import game.model.gameObject.component.transform.TransformComponent;
    import game.model.gameObject.component.weapon.enums.AutoAimMode;
    import game.model.gameObject.vo.AutoAimVO;

    import starling.utils.MathUtil;

    public class AutoAimComponent extends Component
    {
        private var _target: ITarget;
        private var _targetProvider: ITargetProvider;

        //temp vars for update method
        private var _angleDelta: Number = 0;
        private var _maxDelta: Number = 0;
        private var transform: TransformComponent;
        private var _autoAim: AutoAimVO;

        private var _angle: Number;
        private var _movementParams: MoveParamsComponent;

        public function AutoAimComponent(aTargetProvider: ITargetProvider, aAutoAim: AutoAimVO, aAngle: Number)
        {
            _targetProvider = aTargetProvider;
            _autoAim = aAutoAim;
            _angle = aAngle;
        }

        override public function init(aGameObject: GameObject): void
        {
            super.init(aGameObject);
            transform = gameObject.transform;
            _movementParams = MoveParamsComponent(getGOComponent(MoveParamsComponent));

            _target = _targetProvider.getTarget(_autoAim.maxRotation, transform.x, transform.y, -transform.rotation);

            if (_target != null && _autoAim.mode == AutoAimMode.ON_INIT)
                _angle = Target.getAngleFromCoords(_target, transform.x, transform.y);

            transform.rotation = -_angle;
            _movementParams.speedX = _movementParams.speed * Math.sin(transform.rotation);
            _movementParams.speedY = _movementParams.speed * Math.cos(transform.rotation);

        }

        override public function update(aDeltaTime: int): void
        {
            //AUTO AIM
            if (_autoAim.mode == AutoAimMode.ON_UPDATE)
            {
                //get new target if needed
                if (!_target || Math.abs(Target.getAngleDelta(_target, transform.x, transform.y, _angle)) > _autoAim.maxTriggerAngle)
                {
                    _target = _targetProvider.getTarget(_autoAim.targetType, transform.x, transform.y, _angle);
                }

                //change direction
                if (_target)
                {
                    _angleDelta = Target.getAngleDelta(_target, transform.x, transform.y, _angle);

                    if (Math.abs(_angleDelta) < _autoAim.maxTriggerAngle)
                    {
                        //max delta
                        _maxDelta = _autoAim.maxRotation * aDeltaTime / 1000;
                        _angle = _angle + MathUtil.clamp(_angleDelta, -_maxDelta, _maxDelta);
                        _movementParams.speedX = _movementParams.speed * Math.sin(_angle);
                        _movementParams.speedY = _movementParams.speed * Math.cos(_angle);
                        transform.rotation = -_angle;
                    }

                }

            }

            transform.x += _movementParams.speedX * aDeltaTime / 1000;
            transform.y += _movementParams.speedY * aDeltaTime / 1000;
        }
    }
}
