package game.view
{
    import common.view.MenuView;

    import feathers.controls.ButtonGroup;
    import feathers.controls.Label;
    import feathers.data.ListCollection;

    import game.model.IGameModel;
    import game.model.gameObject.PlayerShipGO;

    import main.model.IMainModel;
    import main.model.IViewModel;

    import starling.events.Event;

    public class ResultsView extends MenuView
    {
        public static const BUTTON_BACK_TO_MENU: uint = 0;
        public static const BUTTON_HIGHSCORES: uint = 1;
        public static const BUTTON_PLAY_AGAIN: uint = 2;

        public static const WIDTH: Number = 500;
        public static const HEIGHT: uint = 150;

        private var _buttonGroup: ButtonGroup;

        public function init(aViewModel: IViewModel, aGameModel: IGameModel, aMainModel: IMainModel): void
        {

            var youDiedLabel: Label = new Label();
            youDiedLabel.text = aGameModel.finishedLevel ? "Congratulations, you finished the game, Universe is safe again." : "You died very much, Universe is doomed.";
            youDiedLabel.validate();
            youDiedLabel.x = (aViewModel.stageWidth - youDiedLabel.width) / 2;
            youDiedLabel.y = aViewModel.stageHeight / 2 - 50;
            addChild(youDiedLabel);

            for (var i: int = 0; i < aGameModel.numPlayers; i++)
            {
                var player: PlayerShipGO = aGameModel.getPlayerModelByID(i);
                var text: String = aGameModel.numPlayers == 1 ? "Your " : aMainModel.getPlayerName(i);

                var scoreLabel: Label = new Label();
                scoreLabel.text = text + " score is " + player.score;
                scoreLabel.validate();
                scoreLabel.x = (aViewModel.stageWidth - scoreLabel.width) / 2;
                scoreLabel.y = aViewModel.stageHeight / 2 + 20 * i - (aGameModel.numPlayers - 1) * 10;
                addChild(scoreLabel);
            }

            _buttonGroup = new ButtonGroup();
            _buttonGroup.dataProvider = new ListCollection(
                    [
                        { label: "Back to menu", triggered: backToMenu_triggeredHandler },
                        { label: "High Scores", triggered: highScores_triggeredHandler },
                        { label: "Play Again", triggered: playAgain_triggeredHandler }
                    ]);

            var btnGroupWidth: Number = aViewModel.stageWidth / 3;
            _buttonGroup.setSize(btnGroupWidth, 30);
            _buttonGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
            _buttonGroup.x = (aViewModel.stageWidth - btnGroupWidth) / 2;
            _buttonGroup.y = aViewModel.stageHeight / 2 + 60;

            _buttonGroup.setSize(WIDTH, HEIGHT);
            addChild(_buttonGroup);
        }

        private function backToMenu_triggeredHandler(aEvent: Event): void
        {
            _menuPressedSignal.dispatch(BUTTON_BACK_TO_MENU);
        }

        private function highScores_triggeredHandler(aEvent: Event): void
        {
            _menuPressedSignal.dispatch(BUTTON_HIGHSCORES);
        }

        private function playAgain_triggeredHandler(aEvent: Event): void
        {
            _menuPressedSignal.dispatch(BUTTON_PLAY_AGAIN);
        }
    }
}
