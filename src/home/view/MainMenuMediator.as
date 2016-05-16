package home.view
{
    import highScores.controller.ShowHighScoresSignal;

    import home.controller.StartGameSignal;
    import home.controller.StartGameSignalVO;

    import org.robotlegs.mvcs.StarlingMediator;

    public class MainMenuMediator extends StarlingMediator
    {

        [Inject]
        public var view: MainMenuView;

        [Inject]
        public var startGameSignal: StartGameSignal;

        [Inject]
        public var showHighScoresSignal: ShowHighScoresSignal;

        override public function onRegister(): void
        {
            view.menuPressedSignal.add(menuPressedHandler);
            super.onRegister();
        }

        override public function onRemove(): void
        {
            view.menuPressedSignal.remove(menuPressedHandler);
            super.onRegister();
        }

        private function menuPressedHandler(aButtonID: uint): void
        {
            switch (aButtonID)
            {
                case MainMenuView.BUTTON_SINGLE_PLAYER:
                    startGameSignal.dispatch(new StartGameSignalVO(1));
                    break;

                case MainMenuView.BUTTON_TWO_PLAYERS:
                    startGameSignal.dispatch(new StartGameSignalVO(2));
                    break;

                case MainMenuView.BUTTON_HIGH_SCORES:
                    showHighScoresSignal.dispatch();
                    break;

            }

        }

    }
}
