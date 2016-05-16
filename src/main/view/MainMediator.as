package main.view
{
    import flash.events.Event;

    import game.controller.GameLoopDispatcher;

    import main.controller.AppActivateSignal;
    import main.controller.InitMainSignal;
    import main.controller.InitMainVO;

    import org.robotlegs.mvcs.StarlingMediator;

    import starling.core.Starling;

    public class MainMediator extends StarlingMediator
    {

        [Inject]
        public var gameLoopDispatcher: GameLoopDispatcher;

        [Inject]
        public var view: MainView;

        [Inject]
        public var initMainSignal: InitMainSignal;

        [Inject]
        public var appActivateSignal: AppActivateSignal;

        public function MainMediator()
        {
            Starling.current.nativeStage.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
        }

        override public function onRegister(): void
        {
            initMainSignal.dispatch(new InitMainVO(view.stage));
        }

        protected function deactivateHandler(aEvent: Event): void
        {
            if (Starling.current.stage)
            {
                Starling.current.stop();
                Starling.current.nativeStage.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
            }

            appActivateSignal.dispatch(false);
        }

        private function activateHandler(aEvent: Event): void
        {
            if (Starling.current.stage)
            {
                Starling.current.nativeStage.removeEventListener(Event.ACTIVATE, activateHandler);
                Starling.current.start();
            }

            appActivateSignal.dispatch(true);
        }
    }
}
