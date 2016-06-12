package game.controller.playerControl
{
    import flash.geom.Point;
    import flash.utils.getTimer;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.Actor;

    import starling.display.Stage;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class TouchController extends Actor implements ITouchController
    {
        private const SECONDAY_DOUBLECLICK_TIME: Number = 0.2 * 1000;
        public static const DISTANCE_TO_SPEED: int = 10;

        [Inject]
        public var viewModel: IViewModel;

        private var _directionChangeSignal: DirectionChangeSignal;
        private var _positionChangeSignal: PositionChangeSignal;
        private var _actionSwitchSignal: ActionSwitchSignal;

        private var _mouseDownPoint: Point;
        private var _stage: Stage;
        private var _enabled: Boolean;
        private var _playerID: uint = 0;
        private var _lastTime: int = 0;

        /**
         * Class Handling mouse / touch events and turning them to signals which GameModel can understand
         * and can control players GameObject accordingly
         */
        public function TouchController(aViewModel: IViewModel)
        {
            _directionChangeSignal = new DirectionChangeSignal();
            _positionChangeSignal = new PositionChangeSignal();
            _actionSwitchSignal = new ActionSwitchSignal();

            _stage = aViewModel.stage;
            _stage.addEventListener(TouchEvent.TOUCH, touchHandler);
            _enabled = true;
        }

        public function get enabled(): Boolean
        {
            return _enabled;
        }

        public function set enabled(value: Boolean): void
        {
            if (_enabled == value)
                return;

            _enabled = value;

            if (_enabled)
                _stage..addEventListener(TouchEvent.TOUCH, touchHandler);
            else
                _stage.removeEventListener(TouchEvent.TOUCH, touchHandler);
        }

        public function get directionChangeSignal(): DirectionChangeSignal
        {
            return _directionChangeSignal;
        }

        public function get positionChangeSignal(): PositionChangeSignal
        {
            return _positionChangeSignal;
        }

        public function get actionSwitchSignal(): ActionSwitchSignal
        {
            return _actionSwitchSignal;
        }

        public function destroy(): void
        {
            _stage.addEventListener(TouchEvent.TOUCH, touchHandler);
        }

        private function touchHandler(aEvent: TouchEvent): void
        {
            var touch: Touch = aEvent.touches[0];


            switch (touch.phase)
            {
                case TouchPhase.BEGAN:
                    _mouseDownPoint = new Point(touch.globalX, touch.globalY);
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.PRIMARY_FIRE, true);

                    if (getTimer() - _lastTime < SECONDAY_DOUBLECLICK_TIME)
                        _actionSwitchSignal.dispatch(_playerID, PlayerActionID.SECONDARY_FIRE, true);

                    _lastTime = getTimer();
                    break;

                case TouchPhase.ENDED:
                    if (_mouseDownPoint != null)
                    {
                        var deltaX: Number = (touch.globalX - _mouseDownPoint.x) / viewModel.gameWidth * DISTANCE_TO_SPEED;
                        var deltaY: Number = (touch.globalY - _mouseDownPoint.y) / viewModel.gameHeight * DISTANCE_TO_SPEED;
                        _directionChangeSignal.dispatch(0, deltaX, deltaY)
                    }
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.PRIMARY_FIRE, false);
                    break;

                case TouchPhase.HOVER:
                case TouchPhase.MOVED:
                    _positionChangeSignal.dispatch(_playerID, touch.globalX, touch.globalY);
                    break;
            }
        }
    }
}
