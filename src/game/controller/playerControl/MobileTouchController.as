package game.controller.playerControl
{
    import flash.geom.Point;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.Actor;

    import starling.display.Stage;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class MobileTouchController extends Actor implements ITouchController
    {
        public static const CONTROLL_Y_OFFSET: int = -200;

        [Inject]
        public var viewModel: IViewModel;

        private var _directionChangeSignal: DirectionChangeSignal;
        private var _positionChangeSignal: PositionChangeSignal;
        private var _actionSwitchSignal: ActionSwitchSignal;

        private var _mouseDownPoint: Point;
        private var _stage: Stage;
        private var _enabled: Boolean;
        private var _playerID: uint = 0;

        private var _shootingEnabled: Boolean;

        /**
         * Class Handling mouse / touch events and turning them to signals which GameModel can understand
         * and can control players GameObject accordingly
         */
        public function MobileTouchController(aViewModel: IViewModel)
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
            _stage.removeEventListener(TouchEvent.TOUCH, touchHandler);
        }

        private function touchHandler(aEvent: TouchEvent): void
        {
            var touch: Touch = aEvent.touches[0];

            //todo double tap
            switch (touch.phase)
            {
                case TouchPhase.BEGAN:
                    _mouseDownPoint = new Point(touch.globalX, touch.globalY);
                    _shootingEnabled = !_shootingEnabled;
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.SHOOT, true);
                    _positionChangeSignal.dispatch(_playerID, touch.globalX, touch.globalY + CONTROLL_Y_OFFSET);
                    break;

                case TouchPhase.ENDED:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.SHOOT, false);
                    break;

                case TouchPhase.HOVER:
                case TouchPhase.MOVED:
                    _positionChangeSignal.dispatch(_playerID, touch.globalX, touch.globalY + CONTROLL_Y_OFFSET);
                    break;
            }
        }
    }
}
