package game.view
{
    import game.controller.BackToMenuSignal;
    import game.model.IGameModel;

    import highScores.controller.ShowHighScoresSignal;

    import home.controller.StartGameSignal;
    import home.controller.StartGameSignalVO;

    import main.model.IMainModel;
    import main.model.IViewModel;

    import org.robotlegs.mvcs.StarlingMediator;

    public class ResultsMediator extends StarlingMediator
    {

        [Inject]
        public var gameModel: IGameModel;

        [Inject]
        public var mainModel: IMainModel;

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var resultsView: ResultsView;

        [Inject]
        public var backToMenuSignal: BackToMenuSignal;

        [Inject]
        public var showHighScoresSignal: ShowHighScoresSignal;

        [Inject]
        public var startGameSignal: StartGameSignal;

        public function ResultsMediator()
        {
            trace(this, "CONSTRUCTOR");
        }

        override public function onRegister(): void
        {
            resultsView.init(viewModel, gameModel, mainModel);
            resultsView.menuPressedSignal.add(menuPressedHandler);
        }

        private function menuPressedHandler(aButtonID: uint): void
        {
            switch (aButtonID)
            {
                case ResultsView.BUTTON_BACK_TO_MENU:
                    backToMenuSignal.dispatch();
                    break;
                case ResultsView.BUTTON_HIGHSCORES:
                    showHighScoresSignal.dispatch();
                    break;
                case ResultsView.BUTTON_PLAY_AGAIN:
                    startGameSignal.dispatch(new StartGameSignalVO(gameModel.numPlayers));
                    break;
            }
        }
    }
}
