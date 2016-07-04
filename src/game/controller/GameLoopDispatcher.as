package game.controller
{
    import flash.utils.getTimer;

    import main.controller.AppActivateSignal;
    import main.model.IViewModel;

    import org.robotlegs.mvcs.Actor;

    import starling.events.Event;

    public class GameLoopDispatcher extends Actor
    {
        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var physicsUpdateSignal: PhysicsUpdateSignal;

        [Inject]
        public var viewUpdateSignal: ViewUpdateSignal;

        [Inject]
        public var appActivateSignal: AppActivateSignal;

        private var running: Boolean = false;

        private var _currentFrameTime: int;
        private var _previousFrameTime: int;
        private var _deltaTime: Number;

        /**
         * Class which controls core game loop, it dispatches physics and view update signals
         */
        public function GameLoopDispatcher()
        {

        }

        public function start(): void
        {
            if (running)
                return;

            _previousFrameTime = getTimer();
            viewModel.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            running = true;

            appActivateSignal.add(appActivateHandler);
        }

        public function stop(): void
        {
            if (!running)
                return;

            viewModel.stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            running = false;
            appActivateSignal.add(appActivateHandler);
        }

        private function enterFrameHandler(event: Event): void
        {
            _currentFrameTime = getTimer();
            _deltaTime = (_currentFrameTime - _previousFrameTime) / 1000;
            _previousFrameTime = _currentFrameTime;

            physicsUpdateSignal.dispatch(_deltaTime);
            viewUpdateSignal.dispatch(_deltaTime);
        }

        /**
         * Sets _previousFrameTime to actual time, otherwise GameLoopDispatcher would generate one loop with huge _deltaTime
         * when deactivated and activated again after some time
         * @param aActivated
         */
        private function appActivateHandler(aActivated: Boolean): void
        {
            if (aActivated)
                _previousFrameTime = getTimer();
        }
    }
}
