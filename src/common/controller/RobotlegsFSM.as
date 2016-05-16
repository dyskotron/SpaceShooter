package common.controller
{
    import common.controller.fsm.FSMTransitionType;
    import common.controller.fsm.IFSMState;

    import org.robotlegs.core.IInjector;
    import org.robotlegs.mvcs.Actor;

    public class RobotlegsFSM extends Actor
    {
        [Inject]
        public var injector: IInjector;

        private var _nextStates: Vector.<IFSMState>;
        private var _currentState: IFSMState;
        private var _currentTransition: uint;
        private var logEnabled: Boolean = true;

        /**
         * Simple finite state machine for easy use with robotlegs, managing transitions between states
         * doing all mapping/unmapping and other stuff needed in transition in/out, geting signals dispatched when related scene is ready
         * states dependencies are injected in robotlegs fashion
         */
        public function RobotlegsFSM()
        {
            _currentTransition = FSMTransitionType.NONE;
            _nextStates = new Vector.<IFSMState>();
        }

        public function get currentState(): IFSMState
        {
            return _currentState;
        }

        public function switchState(aState: IFSMState): void
        {
            log("_MO_", this, "switchState" + aState);

            if (_currentTransition == FSMTransitionType.NONE)
            {
                if (_currentState == null)
                {
                    startState(aState);
                }
                else
                {
                    _nextStates.push(aState);
                    closeCurrentState();
                }
            }
            else
            {
                _nextStates.push(aState);
            }
        }

        private function startState(aState: IFSMState): void
        {
            log("_MO_", this, "startState" + aState);
            _currentState = aState;

            _currentTransition = FSMTransitionType.IN;

            injector.injectInto(_currentState);
            _currentState.transitionInFinishedSignal.add(transitionInFinished);
            _currentState.init();
            _currentState.transitionIn();
        }

        private function closeCurrentState(): void
        {
            log("_MO_", this, "closeCurrentState" + _currentState);
            _currentTransition = FSMTransitionType.OUT;

            _currentState.transitionOutFinishedSignal.add(transitionOutFinished);
            _currentState.transitionOut();
        }

        private function transitionInFinished(): void
        {
            log("_MO_", this, "transitionInFinished");
            _currentState.transitionInFinishedSignal.remove(transitionInFinished);
            _currentTransition = FSMTransitionType.NONE;
            _currentState.start();
        }

        private function transitionOutFinished(): void
        {
            log("_MO_", this, "transitionOutFinished");
            _currentState.transitionOutFinishedSignal.remove(transitionOutFinished);
            _currentTransition = FSMTransitionType.NONE;

            _currentState.destroy();
            startState(_nextStates.shift());
        }

        private function log(...rest): void
        {
            if (logEnabled)
                trace(rest);
        }
    }
}
