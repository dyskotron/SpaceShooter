package highScores.view
{
    import game.controller.BackToMenuSignal;
    import game.view.*;

    import highScores.controller.HighScoreFailedSignalVO;
    import highScores.controller.HighScoreLoadedSignalVO;
    import highScores.controller.HighScoresFailedSignal;
    import highScores.controller.HighScoresLoadedSignal;
    import highScores.model.IHighScoreService;

    import main.model.IViewModel;

    import org.robotlegs.mvcs.StarlingMediator;

    public class HighScoresMediator extends StarlingMediator
    {

        [Inject]
        public var viewModel: IViewModel;

        [Inject]
        public var highScoresView: HighScoresView;

        [Inject]
        public var backToMenuSignal: BackToMenuSignal;

        [Inject]
        public var highScoreLoadedSignal: HighScoresLoadedSignal;

        [Inject]
        public var highScoreFailedSignal: HighScoresFailedSignal;

        [Inject]
        public var highScoreService: IHighScoreService;

        override public function onRegister(): void
        {
            highScoresView.init(viewModel);

            highScoresView.menuPressedSignal.add(menuPressedHandler);
            highScoreLoadedSignal.add(highScoreLoadedHandler);
            highScoreFailedSignal.add(highScoreFailedHandler);

            highScoreService.getHighScores();
        }

        override public function onRemove(): void
        {
            highScoresView.menuPressedSignal.remove(menuPressedHandler);
            highScoreLoadedSignal.remove(highScoreLoadedHandler);
            highScoreFailedSignal.remove(highScoreFailedHandler);
        }

        private function menuPressedHandler(aButtonID: uint): void
        {
            switch (aButtonID)
            {
                case ResultsView.BUTTON_BACK_TO_MENU:
                    backToMenuSignal.dispatch();
                    break;
            }
        }

        private function highScoreLoadedHandler(aHighScoreFailedVO: HighScoreLoadedSignalVO): void
        {
            highScoresView.showHighScores(aHighScoreFailedVO.highScores);
        }

        private function highScoreFailedHandler(aHighScoreLoadedVO: HighScoreFailedSignalVO): void
        {
            highScoresView.showError(aHighScoreLoadedVO.errorMessage);
        }

    }
}
