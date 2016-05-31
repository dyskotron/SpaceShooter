package game.controller.playerControl
{
    import flash.ui.Keyboard;
    import flash.utils.Dictionary;

    import game.controller.*;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.Actor;

    import starling.display.Stage;
    import starling.events.KeyboardEvent;

    public class KeyController extends Actor implements IPlayerController
    {
        private var _physicsUpdateSignal: PhysicsUpdateSignal;

        private var _directionChangeSignal: DirectionChangeSignal;
        private var _positionChangeSignal: PositionChangeSignal;
        private var _actionSwitchSignal: ActionSwitchSignal;

        private var _stage: Stage;
        private var _enabled: Boolean;
        private var _keysDown: Dictionary;
        private var _maxDistancePerSecond: int;
        private var _playerID: uint = 1;

        /**
         * Class Handling keyboard events and turning them to signals which GameModel can understand
         * and can control players GameObject accordingly
         * @param aViewModel
         * @param aPhysicsUpdateSignal
         */
        public function KeyController(aViewModel: IViewModel, aPhysicsUpdateSignal: PhysicsUpdateSignal)
        {
            _physicsUpdateSignal = aPhysicsUpdateSignal;
            _stage = aViewModel.stage;

            _directionChangeSignal = new DirectionChangeSignal();
            _positionChangeSignal = new PositionChangeSignal();
            _actionSwitchSignal = new ActionSwitchSignal();

            _keysDown = new Dictionary();

            addListeners();
            _enabled = true;

            //it will take one seconds to get from edge to edge of game viewport(horizontally)
            _maxDistancePerSecond = aViewModel.gameWidth / 2;
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
            {
                addListeners();
            }
            else
            {
                removeListeners();
                //forget all keys down
                _keysDown = new Dictionary();
            }
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
            removeListeners();
        }

        private function addListeners(): void
        {
            _stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
            _physicsUpdateSignal.add(physicsUpdateHandler);
        }

        private function removeListeners(): void
        {
            _stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        }

        private function keyDownHandler(aEvent: KeyboardEvent): void
        {
            //key is already down - return to avoid repeating key down without key up
            if (_keysDown[aEvent.keyCode])
                return;

            _keysDown[aEvent.keyCode] = true;
            switch (aEvent.keyCode)
            {
                case Keyboard.SPACE:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.SHOOT, true);
                    break;

                case Keyboard.SPACE:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.SHOOT, true);
                    break;

                case Keyboard.SPACE:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.SHOOT, true);
                    break;

                case Keyboard.NUMBER_1:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.WEAPON_ELECTRIC, true);
                    break;
                case Keyboard.NUMBER_2:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.WEAPON_LASER, true);
                    break;
                case Keyboard.NUMBER_3:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.WEAPON_PLASMA, true);
                    break;
            }


            CONFIG::debug{
                switch (aEvent.keyCode)
                {
                    case Keyboard.Q:
                        _actionSwitchSignal.dispatch(_playerID, PlayerActionID.POWER_UP, true);
                        break;

                    case Keyboard.A:
                        _actionSwitchSignal.dispatch(_playerID, PlayerActionID.POWER_DOWN, true);
                        break;
                }
            }
        }

        private function keyUpHandler(aEvent: KeyboardEvent): void
        {
            _keysDown[aEvent.keyCode] = false;

            switch (aEvent.keyCode)
            {
                case Keyboard.SPACE:
                    _actionSwitchSignal.dispatch(_playerID, PlayerActionID.SHOOT, false);
                    break;
            }
        }

        private function physicsUpdateHandler(aDeltaTime: int): void
        {
            var deltaSeconds: Number = aDeltaTime / 1000;
            var deltaX: Number = (int(_keysDown[Keyboard.RIGHT]) - int(_keysDown[Keyboard.LEFT])) * _maxDistancePerSecond * deltaSeconds;
            var deltaY: Number = (int(_keysDown[Keyboard.DOWN]) - int(_keysDown[Keyboard.UP])) * _maxDistancePerSecond * deltaSeconds;

            if (deltaX != 0 || deltaY != 0)
                _directionChangeSignal.dispatch(_playerID, deltaX, deltaY);
        }
    }
}
