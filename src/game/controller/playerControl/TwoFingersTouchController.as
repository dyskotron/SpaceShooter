package game.controller.playerControl
{
    import flash.utils.getTimer;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.Actor;

    import starling.display.Stage;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class TwoFingersTouchController extends Actor implements ITouchController
    {
        public static const CONTROL_Y_OFFSET: int = -200;

        private const CHARGE_DOUBLETAP_TIME: int = 200;

        [Inject]
        public var viewModel: IViewModel;

        private var _directionChangeSignal: DirectionChangeSignal;
        private var _positionChangeSignal: PositionChangeSignal;
        private var _actionSwitchSignal: ActionSwitchSignal;
        private var _actionTriggerSignal: ActionTriggerSignal;

        private var _stage: Stage;

        private var _enabled: Boolean;
        private var _playerID: uint = 0;
        private var _lastBeganTime: int = 0;

        /**
         * Class Handling mouse / touch events and turning them to signals which GameModel can understand
         * and can control players GameObject accordingly
         */
        public function TwoFingersTouchController(aViewModel: IViewModel)
        {
            _directionChangeSignal = new DirectionChangeSignal();
            _positionChangeSignal = new PositionChangeSignal();
            _actionSwitchSignal = new ActionSwitchSignal();
            _actionTriggerSignal = new ActionTriggerSignal();

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
                _stage.addEventListener(TouchEvent.TOUCH, touchHandler);
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

        public function get actionTriggerSignal(): ActionTriggerSignal
        {
            return _actionTriggerSignal;
        }

        public function destroy(): void
        {
            _stage.removeEventListener(TouchEvent.TOUCH, touchHandler);
        }

        private function touchHandler(aEvent: TouchEvent): void
        {
            var touch: Touch;


            touch = aEvent.touches[0];
            switch (touch.phase)
            {
                case TouchPhase.BEGAN:
                    _positionChangeSignal.dispatch(_playerID, touch.globalX, touch.globalY + CONTROL_Y_OFFSET);
                    break;
                case TouchPhase.HOVER:
                case TouchPhase.MOVED:
                    _positionChangeSignal.dispatch(_playerID, touch.globalX, touch.globalY + CONTROL_Y_OFFSET);
                    break;

            }

            if (aEvent.touches.length > 1)
            {
                touch = aEvent.touches[1];
                switch (touch.phase)
                {
                    case TouchPhase.BEGAN:
                        _actionSwitchSignal.dispatch(_playerID, PlayerActionID.PRIMARY_FIRE, true);

                        //double tap - charge
                        if (getTimer() - _lastBeganTime < CHARGE_DOUBLETAP_TIME)
                            _actionTriggerSignal.dispatch(_playerID, PlayerActionID.CHARGE_FIRE);
                        else
                            _lastBeganTime = getTimer();

                        break;
                    case TouchPhase.ENDED:
                        _actionSwitchSignal.dispatch(_playerID, PlayerActionID.PRIMARY_FIRE, false);
                        break;

                }
            }
        }
    }
}
