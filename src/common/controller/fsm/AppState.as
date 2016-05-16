package common.controller.fsm
{
    import org.osflash.signals.Signal;
    import org.robotlegs.base.SignalCommandMap;
    import org.robotlegs.base.StarlingMediatorMap;
    import org.robotlegs.core.IInjector;

    public class AppState implements IFSMState
    {
        private var _transitionInFinishedSignal: Signal;
        private var _transitionOutFinishedSignal: Signal;

        [Inject]
        public var injector: IInjector;

        [Inject]
        public var mediatorMap: StarlingMediatorMap;

        [Inject]
        public var signalCommandMap: SignalCommandMap;

        public function AppState(): void
        {
            _transitionInFinishedSignal = new Signal();
            _transitionOutFinishedSignal = new Signal();
        }

        public function get transitionInFinishedSignal(): Signal
        {
            return _transitionInFinishedSignal;
        }

        public function get transitionOutFinishedSignal(): Signal
        {
            return _transitionOutFinishedSignal;
        }

        /**
         * Called by FSM as first method before scene is transitioned in and started
         */
        public function init(): void
        {

        }

        /**
         * Called by FSM when transitionIn is finished
         */
        public function start(): void
        {

        }

        /**
         * Called by FSM after init
         * When this method is overridden, its needed to call super.transitionIn() after all transitionIn stuff is done
         * or dispatch transitionInFinishedSignal manually if transition is finished outside ot this overridden function
         */
        public function transitionIn(): void
        {
            _transitionInFinishedSignal.dispatch();
        }

        /**
         * Called by FSM when scene is going to be shut down
         * When this method is overridden, its needed to call super.transitionOut() after all transitionIn stuff is done
         * or dispatch transitionOutFinishedSignal manually if transition is finished outside ot this overridden function
         */
        public function transitionOut(): void
        {
            _transitionOutFinishedSignal.dispatch();
        }

        public function destroy(): void
        {
            _transitionInFinishedSignal.removeAll();
            _transitionOutFinishedSignal.removeAll();
        }


    }
}
